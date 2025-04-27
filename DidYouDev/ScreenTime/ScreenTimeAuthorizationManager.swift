//
//  ScreenTimeAuthorizationManager.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import FamilyControls
import UIKit
import Combine

@Observable
final class ScreenTimeAuthorizationManager {
    enum Error: LocalizedError {
        case notAuthorized, authorizationDenied
        
        var errorDescription: String? {
            switch self {
            case .notAuthorized:       "ScreenTime not authorized"
            case .authorizationDenied: "Authorization denied"
            }
        }
    }
    
    var status: AuthorizationStatus = .notDetermined
    
    var checkAuthorization: Void {
        get throws {
            if status == .notDetermined || status == .denied {
                throw ScreenTimeAuthorizationManager.Error.notAuthorized
            }
        }
    }
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        AuthorizationCenter.shared
          .$authorizationStatus
          .sink { [weak self] in
              self?.status = $0
          }
          .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                try? self?.authorize()
            }
            .store(in: &cancellables)
    }

    func authorize() throws(ScreenTimeAuthorizationManager.Error) {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            } catch {
                status = .denied
                throw ScreenTimeAuthorizationManager.Error.authorizationDenied
            }
        }
        status = AuthorizationCenter.shared.authorizationStatus
    }
    
}
