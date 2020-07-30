//
//  GundamFetcher.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import Foundation
import Combine

//var name: String
//var description: String
//var product: Model
//var imageUrl: String

var sampleData: [GundamModel] = [GundamModel(
    name: "aaa",
    description: "aaa",
    product: GundamModel.Model(number: "aaa"),
    imageUrl: "hoeg")
]

class GundamFetcher {
  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - QiitaFetchable

extension GundamFetcher: GundamFetchable {
  func fetchGundam(tag: String) -> AnyPublisher<[GundamModel], RequestError> {
    return fetchGundam(with: requestComponents(tag: tag))
  }

  private func fetchGundam<T>(with requestComponents: URLComponents) -> AnyPublisher<T, RequestError> where T: Decodable {
    guard let url = requestComponents.url else {
      let error = RequestError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
        .network(description: error.localizedDescription)
    }
    .flatMap(maxPublishers: .max(1)) { pair in
      decode(pair.data)
    }
    .eraseToAnyPublisher()
  }
}

// MARK: - Qiita API

private extension GundamFetcher {
  struct QiitaAPI {
    static let scheme = "https"
    static let host = "qiita.com"
    static let path = "/api/v2"
  }

  func requestComponents(tag: String) -> URLComponents {
    var components = URLComponents()
    components.scheme = QiitaAPI.scheme
    components.host = QiitaAPI.host
    components.path = QiitaAPI.path + "/items"

    components.queryItems = [
      URLQueryItem(name: "per_page", value: "50"),
      URLQueryItem(name: "query", value: "tag:" + tag),
    ]
    print(components.url?.absoluteString ?? "nil")
    return components
  }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, RequestError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
  }
  .eraseToAnyPublisher()
}

