//
//  AuthorizationView.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import SwiftUI

struct AuthorizationView: View {
    
    let manager: ScreenTimeAuthorizationManager
    
    let systemImage = "person.badge.key"
    let title = "Enable Screen Time Access"
    let subTitle = "We need access to Screen Time to help you manage app usage and support your development goals."
    let detail = "We use Screen Time to show your app activity and apply usage limits, only on your device. Your data stays private and is never shared."
    
    var body: some View {
        header(
            systemImage: systemImage,
            title: title,
            subTitle: subTitle,
            detail: detail
        ) {
            Button("Authorize") {
                Task {
                    try? manager.authorize()
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
    }
    
    func header(
        systemImage: String,
        title: String,
        subTitle: String? = nil,
        detail: String? = nil,
        actionButton: () -> some View
    ) -> some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: systemImage)
                .font(.system(size: 84))
            Text(title)
                .font(.system(size: 24, weight: .bold))
            if let subTitle {
                Text(subTitle)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            Spacer()
            
            if let detail {
                HStack {
                    Image(systemName: "lock.rotation")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 30))
                    Text(detail)
                        .font(.system(size: 12, weight: .thin))
                }
            }
            
            actionButton()
            
        }
        .padding()
    }
    
}

#Preview {
    AuthorizationView(manager: ScreenTimeAuthorizationManager())
}
