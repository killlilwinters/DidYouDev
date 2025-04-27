//
//  CategoryView.swift
//  DidYouDev
//
//  Created by Maks Winters on 26.04.2025.
//

import SwiftUI

struct CategoryView: View {
    
    let systemImage: String
    let color: Color
    let appName: String
    let categoryName: String
    
    let session: WorkSessionProgress
    
    var body: some View {
        
        HStack {
             
            Image(systemName: systemImage)
                .font(.system(size: 35))
                .foregroundStyle(color)
                .opacity(0.7)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                
                Text("\(appName) - \(categoryName)")
                Text(session.formattedTime)
                    .foregroundStyle(.secondary)
                
                ProgressView(value: session.progress)
                    .progressViewStyle(.linear)
                    .foregroundStyle(color)
                
                
            }
            .padding(.trailing)
            
        }
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CategoryView(
        systemImage: "hammer.fill",
        color: .blue,
        appName: "Xcode",
        categoryName: "Development Tools",
        session: .mockSession
    )
        .frame(width: 400, height: 100)
}
