//
//  DidYouDevApp.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import SwiftUI
import FamilyControls

@main
struct DidYouDevApp: App {
    @Environment(\.self) var enviroment
    
    @State private var authManager: ScreenTimeAuthorizationManager = .init()
    
    @State private var isPresented = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(authManager: authManager)
                .onAppear {
                    do {
                        try authManager.checkAuthorization
                    } catch {
                        isPresented = true
                    }
                }
                .onChange(of: authManager.status) {
                    do {
                        try authManager.checkAuthorization
                        isPresented = false
                    } catch {
                        isPresented = true
                    }
                }
                .fullScreenCover(isPresented: $isPresented) {
                    AuthorizationView(manager: authManager)
                }
        }
    }
}
