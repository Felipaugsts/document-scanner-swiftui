//
//  Model.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI

struct ScanData: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
    var title: String
    var category: ScanCategory
    var dateCreated: Date
    var isFavorite: Bool = false
    
    static func == (lhs: ScanData, rhs: ScanData) -> Bool {
        lhs.id == rhs.id
    }
}

enum ScanCategory: String, CaseIterable, Identifiable {
    case document = "Document"
    case receipt = "Receipt"
//    case note = "Note"
//    case id = "ID"
    case other = "Other"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .document: return "doc.text"
        case .receipt: return "receipt"
//        case .note: return "note.text"
//        case .id: return "person.text.rectangle"
        case .other: return "doc"
        }
    }
}
