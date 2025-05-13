//
//  DetailView.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct DetailView: View {
    @State var scan: ScanDataModel
    
    @State private var isEditing = false
    @State private var editTitle = ""
    @State private var editCategory: ScanCategory = .document
    var saveScan: ((ScanDataModel) -> Void)? = nil
    var deleteScan: ((ScanDataModel) -> Void)? = nil
    
    func convertDataToImage(_ data: Data?) -> UIImage {
        return UIImage(data: data ?? Data()) ?? UIImage()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: convertDataToImage(scan.imageData))
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200)
                .cornerRadius(12)
                .padding(.horizontal)
                .shadow(radius: 3)
            
            if !isEditing {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(scan.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            isEditing = true
                            editTitle = scan.title
                            editCategory = ScanCategory(rawValue: scan.category) ?? .document
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Divider()
                    
                    DetailRow(icon: scan.category, title: "Category", value: scan.category)
                    DetailRow(icon: "calendar", title: "Date created", value: scan.dateCreated.formatted(date: .long, time: .shortened))
                    
                    DocumentActionButtons(
                        deleteScan: {
                            deleteScan?(scan)
                        },
                        shareScan: {
                            shareImage(from: scan)
                        }
                    )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                )
                .padding()
            } else {
                EditScanView(
                    title: $editTitle,
                    category: $editCategory,
                    onSave: {
                        scan.title = editTitle
                        scan.category = editCategory.rawValue
                        isEditing = false
                    },
                    onCancel: {
                        isEditing = false
                    }
                )
                .padding()
            }
            
            if !isEditing && saveScan != nil {
                Button(action: {
                    saveScan?(scan)
                }) {
                    Text("Salvar")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .navigationTitle("Scan Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    scan.isFavorite.toggle()
//                    toggleFavorite(scan)
                } label: {
                    Image(systemName: scan.isFavorite ? "star.fill" : "star")
                        .foregroundColor(scan.isFavorite ? .yellow : .primary)
                }
            }
        }
    }
    
    func shareImage(from scan: ScanDataModel) {
        // Verificar se temos dados de imagem
        guard let imageData = scan.imageData,
              let image = UIImage(data: imageData) else {
            print("Não foi possível obter a imagem para compartilhar")
            return
        }
        
        // Obter o controlador raiz
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Não foi possível obter o controlador de visualização raiz")
            return
        }
        
        // Criar e apresentar o UIActivityViewController
        let activityViewController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        
        // Para iPad: configurar a origem do popover
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = rootViewController.view
            popoverController.sourceRect = CGRect(
                x: rootViewController.view.bounds.midX,
                y: rootViewController.view.bounds.midY,
                width: 0,
                height: 0
            )
        }
        
        rootViewController.present(activityViewController, animated: true)
    }

}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
