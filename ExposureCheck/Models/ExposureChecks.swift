//
//  ExposureChecks.swift
//  ExposureCheck
//
//  Created by Watanabe Toshinori on 2020/08/10.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct ExposureChecks: Codable {

    var build: String

    var exportVersion: Int

    var exposureChecks: [ExposureCheck]

    var deviceProductType: String

    enum CodingKeys: String, CodingKey {
        case build = "Build"
        case exportVersion = "ExportVersion"
        case exposureChecks = "ExposureChecks"
        case deviceProductType = "DeviceProductType"
    }

    static func parse(_ url: URL) throws -> Self {
        let data = try Data(contentsOf: url)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let object = try decoder.decode(ExposureChecks.self, from: data)
        return object
    }

    var matchCount: Int {
        exposureChecks.compactMap({ $0.matchCount }).reduce(0, +)
    }

    var latestMatchedTimestamp: Date? {
        exposureChecks.filter({ $0.matchCount > 0 }).sorted(by: { $0.timestamp < $1.timestamp }).first?.timestamp
    }

}
