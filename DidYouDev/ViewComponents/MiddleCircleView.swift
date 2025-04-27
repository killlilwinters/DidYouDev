//
//  MiddleCircleView.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import SwiftUI

struct MiddleCircleView: View {
    
    let session: WorkSessionProgress
    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(.ultraThinMaterial)
            
            VStack(spacing: 20) {
                Text(session.formattedSpent)
                    .font(.system(size: 55))
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 4)
                    .padding(.horizontal, 40)
                Text(session.formattedGoal)
                    .font(.system(size: 30))
            }
            
        }
    }
}

#Preview {
    MiddleCircleView(session: .mockSession)
}
