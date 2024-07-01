//
//  CaesarView.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import SwiftUI

struct CaesarView: View {
    @State private var shift = 3
    @State private var plaintext = ""
    @State private var ciphertext = ""
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    private let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cipher Settings")) {
                    Text("\(shift): A ➡︎ \(alphabet[shift])")
                    Slider(value:IntFromDoubleBinding(intValue: $shift).doubleValue, in: 1...26, step:1.0) {
                    }
                }
                
                Section(header: Text("Text to Encrypt")) {
                    TextField("Enter Plaintext", text: $plaintext)
                }
                
                Button(action: {
                    ciphertext = caesarify(input: plaintext, shift: shift)
                }) {
                    Text("Encrypt")
                }
                .alert(isPresented: $showingErrorAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                
                Section(header: Text("Caesared text")) {
                    Text(ciphertext)
                }
            }
            .navigationTitle("Caesar Cipher")
        }
    }
}

struct IntFromDoubleBinding {
    var intValue: Binding<Int>
    var doubleValue: Binding<Double>
    
    init(intValue: Binding<Int>) {
        self.intValue = intValue
        self.doubleValue = Binding<Double>(get: {Double(intValue.wrappedValue)}, set: {intValue.wrappedValue = Int($0)})
    }
}

#Preview {
    CaesarView()
}
