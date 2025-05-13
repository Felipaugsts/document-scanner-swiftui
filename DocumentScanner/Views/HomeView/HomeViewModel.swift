//
//  HomeViewModel.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var showScannerSheet = false
    @Published var confirmationSheetIsPresented: Bool = false
    @Published var confirmationScans: ScanDataModel = ScanDataModel(title: "", category: "")
    
    
    func addScannedImages(_ image: UIImage?) {
        guard let scannedImages = image else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let defaultTitle = "Scan \(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short))"
            
            let newScan = ScanDataModel(
                imageData: image?.pngData(),
                title: defaultTitle,
                category: "document",
                dateCreated: Date()
            )
            
            withAnimation {
                self.confirmationSheetIsPresented = true
                self.confirmationScans = newScan
            }
        }
    }
}
