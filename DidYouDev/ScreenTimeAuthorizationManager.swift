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
    enum ScreenTimeAuthorizationError: LocalizedError {
        case notAuthorized, authorizationDenied
        
        var errorDescription: String? {
            switch self {
            case .notAuthorized:       "ScreenTime not authorized"
            case .authorizationDenied: "Authorization denied"
            }
        }
    }
    
    var status: AuthorizationStatus = .notDetermined
    
    var requiresAuthorization: Bool {
        status == .notDetermined || status == .denied
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
                Task { try? await self?.authorize() }
            }
            .store(in: &cancellables)
    }

    func authorize() async throws(ScreenTimeAuthorizationError) {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        } catch {
            status = .denied
            throw .authorizationDenied
        }
        status = AuthorizationCenter.shared.authorizationStatus
    }
    
}
