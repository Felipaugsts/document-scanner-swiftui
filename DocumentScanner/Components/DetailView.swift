//
//  DetailView.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct DetailView: View {
    @State var scan: ScanData
    let toggleFavorite: (ScanData) -> Void
    
    @State private var isEditing = false
    @State private var editTitle = ""
    @State private var editCategory: ScanCategory = .document
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image(uiImage: scan.image)
                        .resizable()
                        .scaledToFit()
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
                                    editCategory = scan.category
                                } label: {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            Divider()
                            
                            DetailRow(icon: scan.category.icon, title: "Category", value: scan.category.rawValue)
                            DetailRow(icon: "calendar", title: "Date created", value: scan.dateCreated.formatted(date: .long, time: .shortened))
                            
                            DocumentActionButtons()
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
                                scan.category = editCategory
                                isEditing = false
                            },
                            onCancel: {
                                isEditing = false
                            }
                        )
                        .padding()
                    }
                }
                .padding(.bottom, 80)
            }
        }
        .navigationTitle("Scan Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    scan.isFavorite.toggle()
                    toggleFavorite(scan)
                } label: {
                    Image(systemName: scan.isFavorite ? "star.fill" : "star")
                        .foregroundColor(scan.isFavorite ? .yellow : .primary)
                }
            }
        }
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
