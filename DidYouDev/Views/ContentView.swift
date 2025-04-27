//
//  ContentView.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import SwiftUI
import FamilyControls
import os.log

private let logger = Logger(subsystem: "ContentView", category: "View")

struct ContentView: View {
    enum AppState: String {
        case running, stopped
        
        mutating func toggle() {
            switch self {
            case .running: self = .stopped
            case .stopped: self = .running
            }
        }
    }
    
    let registrationManager: ActivityRegistrationManager
    @State private var appListStorage = try! AppListStorage()
    
    let session: WorkSessionProgress = .mockSession
    
    @AppStorage("APPSTATE") private var appState: AppState = .stopped
    
    @State private var isShowingPicker = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                CircleProgressBar(
                    progress: .constant(session.progress),
                    overlayColor: .blue,
                    thickness: 30,
                    style: .thinUnderlay
                )
                .overlay {
                    GeometryReader { proxy in
                        let size = proxy.size
                        MiddleCircleView(session: session)
                            .frame(width: size.width * 0.7, height: size.height  * 0.7)
                            .position(x: size.width / 2, y: size.height / 2)
                    }
                }
                
                Group {
                    HStack {
                        Button(
                            appState == .running ? "Stop" : "Start",
                            systemImage: appState == .running ? "pause.fill" : "play.fill"
                        ) {
                            withAnimation {
                                appState.toggle()
                                registerIfNeeded()
                            }
                        }
                        .foregroundStyle(appState == .running ? .red : .green)
                        Button("Setup", systemImage: "gearshape.fill") {
                            isShowingPicker.toggle()
                        }
                        .foregroundStyle(.purple)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    Divider()
                }
                .padding(.horizontal, 20)
                    
                ForEach(0..<10) { _ in
                    CategoryView(
                        systemImage: "hammer.fill",
                        color: .blue,
                        appName: "Xcode",
                        categoryName: "Development Tools",
                        session: session
                    )
                }
                .padding(.horizontal)
            }
            .navigationTitle("DidYouDev")
        }
        .onAppear {
            logger.log("ContentView appeared")
            registerIfNeeded()
        }
        .familyActivityPicker(isPresented: $isShowingPicker, selection: $appListStorage.activitySelection)
    }
     
    func registerIfNeeded() {
        guard appState != .stopped else {
            registrationManager.stopMonitoring()
            return
        }
        
        do {
            try registrationManager.register(.init())
        } catch {
            logger.log("\(error.localizedDescription)")
        }
    }
    
    init(authManager: ScreenTimeAuthorizationManager) {
        self.registrationManager = .init(authManager: authManager)
    }
}

#Preview {
    ContentView(authManager: .init())
}
