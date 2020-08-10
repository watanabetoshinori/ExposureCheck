//
//  LocalStorage.swift
//  ExposureCheck
//
//  Created by Watanabe Toshinori on 2020/08/10.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class LocalStorage: NSObject {

    static let shared = LocalStorage()

    @Persisted(userDefaultsKey: "exposureChecks", notificationName: .init("LocalStoreExposureChecksDidChange"), defaultValue: nil)
    var exposureChecks: ExposureChecks?

    @Persisted(userDefaultsKey: "errorMessage", notificationName: .init("LocalStoreErrorMessageDidChange"), defaultValue: nil)
    var errorMessage: String?

    @Persisted(userDefaultsKey: "lastCheckDate", notificationName: .init("LocalStoreLastCheckDateDidChange"), defaultValue: nil)
    var lastCheckDate: Date?

}

@propertyWrapper
class Persisted<Value: Codable> {

    init(userDefaultsKey: String, notificationName: Notification.Name, defaultValue: Value) {
        self.userDefaultsKey = userDefaultsKey
        self.notificationName = notificationName
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                wrappedValue = try JSONDecoder().decode(Value.self, from: data)
            } catch {
                wrappedValue = defaultValue
            }
        } else {
            wrappedValue = defaultValue
        }
    }

    let userDefaultsKey: String
    let notificationName: Notification.Name

    // swiftlint:disable force_try
    var wrappedValue: Value {
        didSet {
            UserDefaults.standard.set(try! JSONEncoder().encode(wrappedValue), forKey: userDefaultsKey)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
    }

    var projectedValue: Persisted<Value> { self }

    func addObserver(using block: @escaping () -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) { _ in
            block()
        }
    }
}
