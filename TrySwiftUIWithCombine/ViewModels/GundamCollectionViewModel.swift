//
//  GundamCollectionViewModel.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class GundamCollectionViewModel: ObservableObject, Identifiable {
  @Published var tag: String = ""
  @Published var dataSource: [GundamRowViewModel] = []

  private let gundamFetcher: GundamFetchable
  private var disposables = Set<AnyCancellable>()

  init(
    gundamFetcher: GundamFetchable,
    scheduler: DispatchQueue = DispatchQueue(label: "GundamCollectionViewModel")
  ) {
    self.gundamFetcher = gundamFetcher
    _ = $tag
        .sink(receiveCompletion: {_ in
            print(self.tag)
        },
        receiveValue: {_ in
            print(self.tag)
        })
    _ = $tag
      .dropFirst(1)
      .debounce(for: .seconds(0.5), scheduler: scheduler)
      .sink (
        receiveValue: {_ in
            print(self.tag)
            self.fetchGundam(tag: self.tag)
        }
      )
      .store(in: &disposables)
  }

  func fetchGundam(tag: String) {
    gundamFetcher.fetchGundam(tag: tag)
      .map { response in
        response.map(GundamRowViewModel.init)
      }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] value in
          guard let self = self else { return }
          switch value {
          case .failure:
            self.dataSource = []
          case .finished:
            break
          }
        },
        receiveValue: { [weak self] list in
          guard let self = self else { return }
          self.dataSource = list
          print(list)
      })
      .store(in: &disposables)
  }
}

struct GundamCollectionViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
