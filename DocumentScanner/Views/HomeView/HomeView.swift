//
//  HomeView.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.modelContext) private var modelContext
    @State private var searchFilter: String = ""
    @Query
    private var documentList: [ScanDataModel]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                NavigationLink(
                    destination: DetailView(scan: viewModel.confirmationScans, saveScan: { scanned in
                        modelContext.insert(scanned)
                        viewModel.confirmationSheetIsPresented = false
                    }, deleteScan: { scanned in
                        
                    }),
                    isActive: $viewModel.confirmationSheetIsPresented
                ) {
                    EmptyView()
                }

                if documentList.isEmpty {
                    EmptyStateView()
                } else {
                    ListScanView(scans: searchFilter.isEmpty
                                 ? documentList
                                 : documentList.filter { scan in
                                     scan.title.localizedCaseInsensitiveContains(searchFilter)
                                 }) { scan in
                        modelContext.delete(scan)
                    }
                }
            }
            .navigationTitle("Document Scanner")
            .searchable(text: $searchFilter, prompt: "Search documents")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showScannerSheet = true
                    }) {
                        Image(systemName: "doc.viewfinder")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showScannerSheet) {
                ScannerView { images in
                    viewModel.addScannedImages(images)
                    viewModel.showScannerSheet = false
                }
            }
        }
    }
}
