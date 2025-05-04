//
//  ActionButton.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let icon: String
    var color: Color = .blue
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(title)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(8)
        }
    }
}
