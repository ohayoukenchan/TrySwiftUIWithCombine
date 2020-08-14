//
//  ImageDownloader.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/08/14.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import Foundation

class ImageDownloader : ObservableObject {
    @Published var downloadData: Data? = nil

    func downloadImage(url: String) {

        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
}
