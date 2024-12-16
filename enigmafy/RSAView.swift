//
//  RSAView.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-12-15.
//

import SwiftUI

struct RSAView: View {
    @State private var plaintext: String = ""
    @State private var encryptedText: String = ""
    @State private var decryptedText: String = ""
    @State private var keyText: String = "" // Field for the RSA Key
    @State private var keyPlaceholder: String = "Enter RSA public key"
    @State private var textPlaceholder: String = "Enter plaintext"
    var body: some View {
        VStack(spacing: 20) {
            Text("RSA Encryption")
                .font(.largeTitle)
                .padding()
            
            ZStack(alignment: .leading) {
                
                if keyText.isEmpty {
                    TextEditor(text: $keyPlaceholder)
                        .font(.body)
                        .foregroundColor(.gray)
                        .disabled(true)
                        .padding()
                        .cornerRadius(5)
                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.black, lineWidth: 1 / 3)
                                                .opacity(0.3)
                                        )
                }
                TextEditor(text: $keyText)
                    .font(.body)
                    .opacity(keyText.isEmpty ? 0.5: 1)
                    .padding()
                    .cornerRadius(5)
                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.black, lineWidth: 1 / 3)
                                            .opacity(0.3)
                                    )
                                    
            }
            
            ZStack(alignment: .leading) {
                
                if plaintext.isEmpty {
                    TextEditor(text: $textPlaceholder)
                        .font(.body)
                        .foregroundColor(.gray)
                        .disabled(true)
                        .padding()
                        .cornerRadius(5)
                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.black, lineWidth: 1 / 3)
                                                .opacity(0.3)
                                        )
                }
                TextEditor(text: $plaintext)
                    .font(.body)
                    .opacity(plaintext.isEmpty ? 0.5: 1)
                    .padding()
                    .cornerRadius(5)
                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.black, lineWidth: 1 / 3)
                                            .opacity(0.3)
                                    )
                                    
            }
            
            Button("Encrypt") {
                do {
                    if let encrypted = try rsaEncrypt(text: plaintext, key: keyText) {
                        encryptedText = encrypted
                    }
                } catch {
                    encryptedText = "Error: \(error.localizedDescription)"
                }
            }
            .buttonStyle(.borderedProminent)
            Text("Encrypted: \(encryptedText)")
                .padding()
            
            Button("Decrypt") {
                do {
                    if let decrypted = try rsaDecrypt(cipherText: encryptedText, key: keyText) {
                        decryptedText = decrypted
                    }
                } catch {
                    decryptedText = "Error: \(error.localizedDescription)"
                }
            }
            .buttonStyle(.borderedProminent)
            
            Text("Decrypted: \(decryptedText)")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    RSAView()
}
