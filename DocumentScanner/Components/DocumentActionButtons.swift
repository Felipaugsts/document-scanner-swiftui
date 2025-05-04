//
//  DocumentActionButtons.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct DocumentActionButtons: View {
    var body: some View {
        HStack(spacing: 12) {
            ActionButton(title: "Share", icon: "square.and.arrow.up") {
                // Share functionality would go here
            }
            
            ActionButton(title: "Export", icon: "arrow.down.doc") {
                // Export functionality would go here
            }
            
            ActionButton(title: "Delete", icon: "trash", color: .red) {
                // Delete functionality would go here
            }
        }
        .padding(.top, 10)
    }
}
