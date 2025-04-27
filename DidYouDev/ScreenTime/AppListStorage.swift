//
//  AppListStorage.swift
//  DidYouDev
//
//  Created by Maks Winters on 27.04.2025.
//

import FamilyControls
import ManagedSettings
import Foundation

struct AppListStorage {
    let identifier = "AppListStorage"
    let userDefaults = UserDefaults(suiteName: appGroupIdentifier)!
    
    var activitySelection: FamilyActivitySelection {
        didSet {
            try? self.saveSelectionToDiscourage(activitySelection)
        }
    }
    
    var appSelectionToDiscourage: Set<ApplicationToken> {
        var applicationTokens: Set<ApplicationToken> = .init()
        for item in activitySelection.applicationTokens {
            applicationTokens.insert(item)
        }
        return applicationTokens
    }
    
    var categorySelectionToDiscourage: Set<ActivityCategoryToken> {
        var categoryTokens: Set<ActivityCategoryToken> = .init()
        for item in activitySelection.categoryTokens {
            categoryTokens.insert(item)
        }
        return categoryTokens
    }
    
    init() throws {
        let data = userDefaults.data(forKey: identifier) ?? Data()
        let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        self.activitySelection = decoded ?? FamilyActivitySelection()
    }
    
    func saveSelectionToDiscourage(_ selection: FamilyActivitySelection) throws {
        let data = try JSONEncoder().encode(selection)
        userDefaults.set(data, forKey: identifier)
    }
}
