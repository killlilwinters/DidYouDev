//
//  ContentView.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    let session: WorkSessionProgress = .mockSession
    
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
    }
}

#Preview {
    ContentView()
}
