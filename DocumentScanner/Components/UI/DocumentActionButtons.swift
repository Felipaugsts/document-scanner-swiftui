//
//  DocumentActionButtons.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct DocumentActionButtons: View {
    // Todas as funções de ação são opcionais com padrão nulo
    var deleteScan: (() -> Void)? = nil
    var shareScan: (() -> Void)? = nil
    var exportScan: (() -> Void)? = nil
    
    // Customizações visuais
    var spacing: CGFloat = 12
    var showShareButton: Bool = true
    var showExportButton: Bool = true
    var showDeleteButton: Bool = true
    
    var body: some View {
        HStack(spacing: spacing) {
            if showShareButton {
                ActionButton(title: "Share", icon: "square.and.arrow.up") {
                    if let shareAction = shareScan {
                        shareAction()
                    } else {
                        // Mensagem de fallback quando nenhuma ação é fornecida
                        print("Share action não implementada")
                    }
                }
            }
            
            if showDeleteButton {
                ActionButton(title: "Delete", icon: "trash", color: .red) {
                    if let deleteAction = deleteScan {
                        deleteAction()
                    } else {
                        // Mensagem de fallback quando nenhuma ação é fornecida
                        print("Delete action não implementada")
                    }
                }
            }
        }
        .padding(.top, 10)
    }
}
