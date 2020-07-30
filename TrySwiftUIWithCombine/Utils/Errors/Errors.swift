//
//  Errors.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import Foundation

enum RequestError: Error {
  case parsing(description: String)
  case network(description: String)
}
