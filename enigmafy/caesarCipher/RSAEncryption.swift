//
//  RSAEncryption.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-12-15.
//

import Foundation

enum RSAError: Error, LocalizedError {
    case invalidKey
    case invalidText
    case invalidCipherText
    case encryptionFailed(String)
    case decryptionFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidKey:
            return "Invalid RSA Key. Please provide a valid Base64-encoded key."
        case .invalidText:
            return "Invalid text. Unable to process the provided input."
        case .invalidCipherText:
            return "Invalid cipher text. Ensure the encrypted input is valid."
        case .encryptionFailed(let message):
            return "Encryption failed: \(message)"
        case .decryptionFailed(let message):
            return "Decryption failed: \(message)"
        }
    }
}
    
    func rsaEncrypt(text: String, key: String) throws -> String? {
        guard let keyData = Data(base64Encoded: key) else {
            throw RSAError.invalidKey
        }
        
        guard let publicKey = try? SecKeyCreateWithData(
            keyData as CFData,
            [
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass: kSecAttrKeyClassPublic
            ] as CFDictionary,
            nil
        ) else {
            throw RSAError.invalidKey
        }
        
        guard let textData = text.data(using: .utf8) else {
            throw RSAError.invalidText
        }
        
        var error: Unmanaged<CFError>?
        guard let encryptedData = SecKeyCreateEncryptedData(
            publicKey,
            .rsaEncryptionOAEPSHA256,
            textData as CFData,
            &error
        ) as Data? else {
            throw RSAError.encryptionFailed(error?.takeRetainedValue().localizedDescription ?? "Unknown Error")
        }
        
        return encryptedData.base64EncodedString()
    }
    
    func rsaDecrypt(cipherText: String, key: String) throws -> String? {
        guard let keyData = Data(base64Encoded: key) else {
            throw RSAError.invalidKey
        }
        
        guard let privateKey = try? SecKeyCreateWithData(
            keyData as CFData,
            [
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass: kSecAttrKeyClassPrivate
            ] as CFDictionary,
            nil
        ) else {
            throw RSAError.invalidKey
        }
        
        guard let cipherData = Data(base64Encoded: cipherText) else {
            throw RSAError.invalidCipherText
        }
        
        var error: Unmanaged<CFError>?
        guard let decryptedData = SecKeyCreateDecryptedData(
            privateKey,
            .rsaEncryptionOAEPSHA256,
            cipherData as CFData,
            &error
        ) as Data? else {
            throw RSAError.decryptionFailed(error?.takeRetainedValue().localizedDescription ?? "Unknown Error")
        }
        
        return String(data: decryptedData, encoding: .utf8)
    }
