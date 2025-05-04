//
//  HomeViewModel.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var scans: [ScanData] = []
    @Published var searchText = ""
    @Published var selectedCategory: ScanCategory?
    @Published var showFavoritesOnly = false
    @Published var sortOption: SortOption = .newest
    @Published var isGridView = true
    @Published var showScannerSheet = false
    
    enum SortOption: String, CaseIterable {
        case newest = "Newest"
        case oldest = "Oldest"
        case titleAZ = "Title A-Z"
        case titleZA = "Title Z-A"
    }
    
    var filteredScans: [ScanData] {
        var result = scans
        
        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }
        
        if showFavoritesOnly {
            result = result.filter { $0.isFavorite }
        }
        
        if !searchText.isEmpty {
            result = result.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Apply sorting
        switch sortOption {
        case .newest:
            result.sort { $0.dateCreated > $1.dateCreated }
        case .oldest:
            result.sort { $0.dateCreated < $1.dateCreated }
        case .titleAZ:
            result.sort { $0.title < $1.title }
        case .titleZA:
            result.sort { $0.title > $1.title }
        }
        
        return result
    }
    
    func toggleFavorite(_ scan: ScanData) {
        if let index = scans.firstIndex(where: { $0.id == scan.id }) {
            scans[index].isFavorite.toggle()
        }
    }
    
    func toggleViewMode() {
        isGridView.toggle()
    }
    
    func setCategory(_ category: ScanCategory?) {
        selectedCategory = category
    }
    
    func setSortOption(_ option: SortOption) {
        sortOption = option
    }
    
    func toggleFavoritesFilter() {
        showFavoritesOnly.toggle()
    }
    
    func addScannedImages(_ images: [UIImage]?) {
        guard let scannedImages = images else { return }
        
        for (index, image) in scannedImages.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let defaultTitle = "Scan \(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short))"
                
                let newScan = ScanData(
                    image: image,
                    title: defaultTitle + (scannedImages.count > 1 ? " (\(index+1))" : ""),
                    category: .document,
                    dateCreated: Date()
                )
                
                withAnimation {
                    self.scans.append(newScan)
                }
            }
        }
    }
}
