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
                    do {
                        try manager.checkAuthorization
                    } catch {
                        isPresented = true
                    }
                }
                .onChange(of: manager.status) {
                    do {
                        try manager.checkAuthorization
                        isPresented = false
                    } catch {
                        isPresented = true
                    }
                }
                .fullScreenCover(isPresented: $isPresented) {
                    AuthorizationView(manager: manager)
                }
        }
    }
}
