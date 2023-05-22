//
//  PageModel.swift
//  PinchApp
//
//  Created by Vuk Knezevic on 20.05.23.
//

import Foundation

struct Page: Identifiable {
    var id: Int
    var imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
