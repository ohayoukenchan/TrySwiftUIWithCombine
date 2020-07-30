//
//  GundamRowViewModel.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import Foundation
import SwiftUI

struct GundamRowViewModel: Identifiable {
    private let item: GundamModel

    var id: String {
        name + modelNumber
    }

    var name: String {
        item.name
    }

    var description: String {
        item.description
    }

    var modelNumber: String {
        item.product.number
    }

    var url: URL? {
        guard !item.imageUrl.isEmpty else {
            return nil
        }
        return URL(string: item.imageUrl)
    }

    init(item: GundamModel) {
        self.item = item
    }
}

extension GundamRowViewModel: Hashable {
    static func == (lhs: GundamRowViewModel, rhs: GundamRowViewModel) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
}

