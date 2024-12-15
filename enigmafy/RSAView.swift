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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("RSA Encryption View")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter text to encrypt", text: $plaintext)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Encrypt") {
                if let encrypted = rsaEncrypt(text: plaintext) {
                    encryptedText = encrypted
                }
            }
            .buttonStyle(.borderedProminent)
            
            Text("Encrypted: \(encryptedText)")
                .padding()
            
            Button("Decrypt") {
                if let decrypted = rsaDecrypt(cipherText: encryptedText) {
                    decryptedText = decrypted
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
