//
//  ListScanView.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct ListScanView: View {
    let scans: [ScanData]
    let toggleFavorite: (ScanData) -> Void
    
    var body: some View {
        List {
            ForEach(scans) { scan in
                NavigationLink(destination: DetailView(scan: scan, toggleFavorite: toggleFavorite)) {
                    ScanListCell(scan: scan)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ScanListCell: View {
    let scan: ScanData
    
    var body: some View {
        HStack(spacing: 15) {
            Image(uiImage: scan.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(scan.title)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    Label(scan.category.rawValue, systemImage: scan.category.icon)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if scan.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
                
                Text(scan.dateCreated.formatted())
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 5)
    }
}
