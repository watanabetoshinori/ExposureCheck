//
//  ContentView.swift
//  ExposureCheck
//
//  Created by Watanabe Toshinori on 2020/08/10.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text("接触ログ\n一致したキーの数")
                .font(.title)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            (Text("\(viewModel.matchCount)")
                .font(.system(size: 60))
                + Text(" 件")
                .font(.body)
                )
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            Text("接触日: \( viewModel.latestMatchedTimestamp)")
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            Text("最終確認日: \(viewModel.lastCheckDate)")
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 40)
        .padding(.horizontal)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
