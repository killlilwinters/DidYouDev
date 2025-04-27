//
//  DailyTracker.swift
//  DidYouDev
//
//  Created by Maks Winters on 27.04.2025.
//

import DeviceActivity

final class DailyTracker: DeviceActivityMonitor {
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        print("DailyTracker: \(activity)")
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        print("DailyTracker: \(activity)")
    }
    
}
