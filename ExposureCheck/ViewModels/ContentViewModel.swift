//
//  ContentViewModel.swift
//  ExposureCheck
//
//  Created by Watanabe Toshinori on 2020/08/10.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {

    @Published var matchCount: Int = 0

    @Published var latestMatchedTimestamp: String = "-"

    @Published var lastCheckDate: String = "-"

    private var cancellables = [AnyCancellable]()

    init() {
        NotificationCenter.default.publisher(for: .init(rawValue: "LocalStoreExposureChecksDidChange")).sink { _ in
            self.update()
        }
        .store(in: &cancellables)

        update()
    }

    private func update() {
        matchCount = LocalStorage.shared.exposureChecks?.matchCount ?? 0

        if let latestMatchedTimestamp = LocalStorage.shared.exposureChecks?.latestMatchedTimestamp {
            self.latestMatchedTimestamp = DateFormatter.localizedString(from: latestMatchedTimestamp, dateStyle: .long, timeStyle: .none)
        } else {
            self.latestMatchedTimestamp = "-"
        }

        if let lastCheckDate = LocalStorage.shared.lastCheckDate {
            self.lastCheckDate = DateFormatter.localizedString(from: lastCheckDate, dateStyle: .long, timeStyle: .none)
        } else {
            self.lastCheckDate = "-"
        }
    }

}
