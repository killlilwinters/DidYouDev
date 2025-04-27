//
//  ActivityRegistrationManager.swift
//  DidYouDev
//
//  Created by Maks Winters on 27.04.2025.
//

import DeviceActivity
import Foundation

final class ActivityRegistrationManager {
    let center = DeviceActivityCenter()
    let stManager: ScreenTimeAuthorizationManager
    
    init(stManager: ScreenTimeAuthorizationManager) {
        self.stManager = stManager
    }
    
    func register(_ activity: RegisterActivity) throws {
        try stManager.checkAuthorization
        guard !center.activities.contains(activity.name) else { return }
        
        try center.startMonitoring(activity.name, during: activity.schedule)
    }
}

struct RegisterActivity {
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
}
