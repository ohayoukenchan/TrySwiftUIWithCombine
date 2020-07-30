//
//  GundamModel.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

struct GundamModel: Codable {
    var name: String
    var description: String
    var product: Model
    var imageUrl: String


    enum CodingKeys: String, CodingKey {
        case name
        case description
        case product
        case imageUrl = "url"
    }

    struct Model: Codable {
        var number: String
    }
}
