//
//  ExposureCheck.swift
//  ExposureCheck
//
//  Created by Watanabe Toshinori on 2020/08/10.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct ExposureCheck: Codable {

    var hash: String

    var randomIDCount: Int

    var matchCount: Int

    var dataSource: String

    var timestamp: Date

    enum CodingKeys: String, CodingKey {
        case hash = "Hash"
        case randomIDCount = "RandomIDCount"
        case matchCount = "MatchCount"
        case dataSource = "DataSource"
        case timestamp = "Timestamp"
    }

}
