//
//  GundamView.swift
//  TrySwiftUIWithCombine
//
//  Created by  ohayoukenchan on 2020/07/30.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import SwiftUI

struct GundamView: View {
    private let viewModel: GundamRowViewModel

    @State var isShowSafariAlert = false

    var openUrl: String {
        viewModel.url
    }

    init(viewModel: GundamRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(alignment: .center) {
            Group {
                VStack(alignment: .leading) {
                    Text("\(viewModel.modelNumber)")
                    Text("\(viewModel.name)")
                    Text("\(viewModel.description)")
                    URLImage(url: viewModel.url)
                    .aspectRatio(contentMode: .fit)
                }
                ZStack {
                    Button("") {
                        self.isShowSafariAlert = true
                    }
                }
            }
        }.alert(isPresented: $isShowSafariAlert, content: {
            Alert(title: Text(""),
                  message: Text("safariを起動しますか?"),
                  primaryButton: .default(Text("ok"),
                                          action: {
                                            self.isShowSafariAlert = false
                                            guard let url = URL(string: self.viewModel.url) else {
                                                return
                                            }
                                            UIApplication.shared.open(url)
                  }),
                  secondaryButton: .cancel(Text("キャンセル")))
        })
    }
}

