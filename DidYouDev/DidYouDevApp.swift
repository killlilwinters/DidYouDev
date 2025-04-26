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
    @State private var manager: ScreenTimeAuthorizationManager = .init()
    @State private var isPresented = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        try? await manager.authorize()
                        if manager.requiresAuthorization {
                            isPresented = true
                        }
                    }
                }
                .onChange(of: manager.status) {
                    if manager.requiresAuthorization {
                        isPresented = true
                    } else {
                        isPresented = false
                    }
                }
                .fullScreenCover(isPresented: $isPresented) {
                    AuthorizationView(manager: manager)
                }
        }
    }
}
