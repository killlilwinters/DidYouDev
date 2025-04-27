//
//  WorkSessionProgress.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import Foundation

struct WorkSessionProgress {
    let timeSpent: Duration
    let goalTime: Duration
    
    var formattedTime: String {
        timeSpent.formatted(.units(allowed: [.hours, .minutes]))
    }
    
    var formattedGoalTime: String {
        goalTime.formatted(.units(allowed: [.hours, .minutes]))
    }
    
    var formattedSpent: String {
        if timeSpent > .seconds(3600) {
            timeSpent.formatted(.units(allowed: [.hours]))
        } else {
            timeSpent.formatted(.units(allowed: [.minutes]))
        }
    }
    
    var formattedGoal: String {
        if goalTime > .seconds(3600) {
            goalTime.formatted(.units(allowed: [.hours]))
        } else {
            goalTime.formatted(.units(allowed: [.minutes]))
        }
    }
    
    var progress: Double {
        let ratio = timeSpent / goalTime
        guard !(ratio > 1) else { return 1.0 }
        
        return ratio
    }
    
    static let mockSession = Self(
        timeSpent: .seconds(1200),
        goalTime: .seconds(3600)
    )
}
