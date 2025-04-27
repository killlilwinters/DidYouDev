//
//  ActivityRegistrationManager.swift
//  DidYouDev
//
//  Created by Maks Winters on 27.04.2025.
//

import DeviceActivity
import ManagedSettings
import Foundation

final class ActivityRegistrationManager {
    
    private let center = DeviceActivityCenter()
    private let authManager: ScreenTimeAuthorizationManager
    
    init(authManager: ScreenTimeAuthorizationManager) {
        self.authManager = authManager
    }
    
    func register(_ activity: RegisterActivity) throws {
        try authManager.checkAuthorization
        guard !center.activities.contains(activity.name) else { return }
        
        try center.startMonitoring(activity.name, during: activity.schedule)
        print("Initiate monitoring for \(activity.name)")
    }
    
    func remove(_ activity: RegisterActivity) throws {
        try authManager.checkAuthorization
        center.stopMonitoring([activity.name])
    }
    
    func stopMonitoring() {
        center.stopMonitoring()
    }
    
}

struct RegisterActivity {
    static let daily = Self("daily", start: .startOfDay, end: .endOfDay, repeats: true)
    
    let name: DeviceActivityName
    let schedule: DeviceActivitySchedule

    init(_ identifier: String, start: DateComponents, end: DateComponents, repeats: Bool) {
        self.name = DeviceActivityName(rawValue: identifier)
        self.schedule = DeviceActivitySchedule(
            intervalStart: start,
            intervalEnd: end,
            repeats: repeats
        )
    }

    init() {
        let calendar = Calendar.current
        let now = Date()
        let tenSecondsFromNow = calendar.date(byAdding: .second, value: 10, to: now)!

        let components = calendar.dateComponents([.hour, .minute, .second], from: tenSecondsFromNow)
        
        self.name = .init("now")
        self.schedule = .init(intervalStart: components, intervalEnd: .endOfDay, repeats: false)
    }
}
