//
//  KeychainStore.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

final class KeychainStore {

    enum KeychainStoreError: Error {
        case failedToDelete
        case failedToGet
        case noResult
        case failedTransformToData
        case noItem
        case itemExists
        case failedToAdd
    }

    private let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
    }

    func addItem(key: String, item: Data) throws {
        guard !hasItem(key: key) else {
            throw KeychainStoreError.itemExists
        }

        var query = initialQuery(for: key)
        query[kSecValueData] = item

        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw KeychainStoreError.failedToAdd
        }
    }

    func getItem(key: String) throws -> Data {
        var query = initialQuery(for: key)
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnData] = kCFBooleanTrue as Any

        var result: AnyObject?

        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else {
            throw KeychainStoreError.failedToGet
        }

        guard let result else {
            throw KeychainStoreError.noResult
        }

        guard let data = result as? Data else {
            throw KeychainStoreError.failedTransformToData
        }

        return data
    }

    func deleteItem(key: String) throws {
        let query = initialQuery(for: key) as CFDictionary

        let status = SecItemDelete(query)

        guard status == errSecSuccess else {
            throw KeychainStoreError.failedToDelete
        }
    }

    func hasItem(key: String) -> Bool {
        let query = initialQuery(for: key) as CFDictionary

        let status = SecItemCopyMatching(query, nil)

        return status == errSecSuccess
    }
}

private extension KeychainStore {

    func initialQuery(for key: String) -> [CFString: Any] {
        [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key as CFString,
            kSecAttrService: identifier,
        ]
    }
}
