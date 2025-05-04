//
//  GridScanView.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//
import SwiftUI

struct GridScanView: View {
    let scans: [ScanData]
    let toggleFavorite: (ScanData) -> Void
    
    let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(scans) { scan in
                    NavigationLink(destination: DetailView(scan: scan, toggleFavorite: toggleFavorite)) {
                        ScanGridCell(scan: scan)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}

struct ScanGridCell: View {
    let scan: ScanData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack(alignment: .topTrailing) {
                Image(uiImage: scan.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 2)
                
                if scan.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .padding(8)
                        .background(Circle().fill(Color.black.opacity(0.5)))
                        .padding(5)
                }
            }
            
            Text(scan.title)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)
            
            HStack {
                Image(systemName: scan.category.icon)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Text(scan.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(scan.dateCreated.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}
