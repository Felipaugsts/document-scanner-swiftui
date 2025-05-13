//
//  DocumentScannerApp.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI
import SwiftData

@main
struct DocumentScannerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [
                    ScanDataModel.self
                ])
        }
    }
}
