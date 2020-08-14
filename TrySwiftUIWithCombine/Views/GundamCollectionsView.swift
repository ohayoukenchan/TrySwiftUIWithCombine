//
//  GundamCollectionsView.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import SwiftUI

struct GundamCollectionsView: View {
  @State var isShown = false
  @ObservedObject var viewModel: GundamCollectionViewModel

  init(viewModel: GundamCollectionViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      List {
        searchField
        //textfield
        if viewModel.dataSource.isEmpty {
          emptySection
        } else {
          gundamRowSection
        }
      }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("SD玩駄無")
    }
  }
}

private extension GundamCollectionsView {

    var searchField: some View {
        HStack(alignment: .center) {
            TextField("example", text: $viewModel.tag, onEditingChanged: { (changed) in
                print("onEditingChanged: \(changed)")
            }, onCommit: {
                print("onCommit")
            })
        }
    }

//    var textfield: some View {
//        Section {
//            Text(String(viewModel.tag)).foregroundColor(.gray)
//        }
//    }

  var gundamRowSection: some View {
    Section {
      ForEach(viewModel.dataSource, content: GundamView.init(viewModel:))
    }
  }

  var emptySection: some View {
    Section {
      Text("No results")
        .foregroundColor(.gray)
    }
  }
}


