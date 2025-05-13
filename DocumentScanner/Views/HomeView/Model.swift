//
//  Model.swift
//  DocumentScanner
//
//  Created by Felipe Augusto Silva on 04/05/25.
//

import SwiftUI
import SwiftData
import Foundation

@Model
final class ScanDataModel {
    var id: UUID
    var imageData: Data?
    var title: String
    var category: String
    var dateCreated: Date
    var isFavorite: Bool
    
    init(id: UUID = UUID(), imageData: Data? = nil, title: String, category: String, dateCreated: Date = Date(), isFavorite: Bool = false) {
        self.id = id
        self.imageData = imageData
        self.title = title
        self.category = category
        self.dateCreated = dateCreated
        self.isFavorite = isFavorite
    }
}

enum ScanCategory: String, CaseIterable, Identifiable {
    case document = "Document"
//    case receipt = "Receipt"
//    case note = "Note"
//    case id = "ID"
    case other = "Other"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .document: return "doc.text"
//        case .receipt: return "receipt"
//        case .note: return "note.text"
//        case .id: return "person.text.rectangle"
        case .other: return "doc"
        }
    }
}
