import Foundation
import UIKit

fileprivate extension Movie {
    struct JSONKey {
        static let id = "id"
        static let imagePath = "image"
        static let title = "title"
        static let index = "index"
    }
}

public struct Movie {
    var id: String
    var imagePath: String
    var title: String
    var index: Int?
    
    init(json: NSDictionary) {
        self.id = json[JSONKey.id] as! String
        self.imagePath = json[JSONKey.imagePath] as! String
        self.title = json[JSONKey.title] as! String
        self.index = json[JSONKey.index] as? Int
    }
    
    var indexLabel: String? {
        guard let index = self.index else { return nil }
        return "Index: \(index)"
    }
    
    var titleLabel: String? {
        return "Title: \(title)"
    }
}
