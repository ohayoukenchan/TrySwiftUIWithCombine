//
//  GundamFetchable.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import Foundation
import Combine

protocol GundamFetchable {
  func fetchGundam(tag: String) -> AnyPublisher<[GundamModel], RequestError>
}
