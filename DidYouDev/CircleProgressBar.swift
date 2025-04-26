//
//  CircleProgressBar.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import SwiftUI

struct CircleProgressBar: View {
    enum CircleProgressBarStyle { case even, thinUnderlay }
    
    @Binding var progress: Double
    let overlayColor: Color
    
    var thickness: CGFloat = 40
    let style: CircleProgressBarStyle
    
    var body: some View {
        Circle()
            .stroke(
                lineWidth: style == .even ? thickness : thickness / 3
            )
            .fill(.ultraThinMaterial)
            .opacity(0.7)
            .overlay {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                    .fill(overlayColor)
                    .shadow(color: overlayColor, radius: 10)
                    .rotationEffect(.degrees(-90))
            }
            .padding(40)
    }
}

#Preview {
    CircleProgressBar(
        progress: .constant(0.2),
        overlayColor: .green,
        thickness: 40,
        style: .thinUnderlay
    )
}
