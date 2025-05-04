//
//  HomeView.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Categories horizontal scroll
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        CategoryButton(
                            title: "All",
                            icon: "rectangle.stack",
                            isSelected: viewModel.selectedCategory == nil
                        ) {
                            viewModel.setCategory(nil)
                        }
                        
                        ForEach(ScanCategory.allCases) { category in
                            CategoryButton(
                                title: category.rawValue,
                                icon: category.icon,
                                isSelected: viewModel.selectedCategory == category
                            ) {
                                viewModel.setCategory(category)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(Color(.systemBackground))
                
                // Toggle view type and sort buttons
                HStack {
                    Button(action: {
                        viewModel.toggleViewMode()
                    }) {
                        Label(
                            viewModel.isGridView ? "List View" : "Grid View",
                            systemImage: viewModel.isGridView ? "list.bullet" : "square.grid.2x2"
                        )
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Menu {
                        ForEach(HomeViewModel.SortOption.allCases, id: \.self) { option in
                            Button(action: {
                                viewModel.setSortOption(option)
                            }) {
                                HStack {
                                    Text(option.rawValue)
                                    if viewModel.sortOption == option {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                        
                        Divider()
                        
                        Button(action: {
                            viewModel.toggleFavoritesFilter()
                        }) {
                            HStack {
                                Text(viewModel.showFavoritesOnly ? "Show All" : "Favorites Only")
                                if viewModel.showFavoritesOnly {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                            .padding(.horizontal, 10)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                if viewModel.filteredScans.isEmpty {
                    EmptyStateView()
                } else {
                    if viewModel.isGridView {
                        GridScanView(scans: viewModel.filteredScans) { scan in
                            viewModel.toggleFavorite(scan)
                        }
                    } else {
                        ListScanView(scans: viewModel.filteredScans) { scan in
                            viewModel.toggleFavorite(scan)
                        }
                    }
                }
            }
            .navigationTitle("Document Scanner")
            .searchable(text: $viewModel.searchText, prompt: "Search documents")
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
