//
//  ContentView.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import SwiftUI

// Main front page
struct ContentView: View {
    var encryptionMethods = [
        "Enigma Cipher",
        "Caesar Cipher",
        "RSA Encryption"
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Enigmafy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("Choose your encryption method:")
                    .font(.headline)

                List(encryptionMethods, id: \ .self) { method in
                    NavigationLink(destination: destinationView(for: method)) {
                        Text(method)
                    }
                }
            }
            .navigationTitle("Home")
        }
    }

    // Maps encryption methods to their respective views
    @ViewBuilder
    func destinationView(for method: String) -> some View {
        switch method {
        case "Enigma Cipher":
            EnigmaView()
        case "Caesar Cipher":
            CaesarView()
        case "RSA Encryption":
            RSAView()
        default:
            Text("Unknown Method")
        }
    }
}

struct FrontPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
