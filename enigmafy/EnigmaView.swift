//
//  EnigmaView.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import SwiftUI

struct EnigmaView: View {
    @State private var rotor1StartChar = "A"
    @State private var rotor2StartChar = "A"
    @State private var rotor3StartChar = "A"
    @State private var usePlugboard = false
    @State private var plugboardMappings: [Character: Character] = [:]
    @State private var plaintext = ""
    @State private var ciphertext = ""
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    private let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Rotor Settings")) {
                        Picker("Rotor 1 Start", selection: $rotor1StartChar) {
                            ForEach(alphabet, id: \.self) { char in
                                Text(String(char)).tag(String(char))
                            }
                        }
                        Picker("Rotor 2 Start", selection: $rotor2StartChar) {
                            ForEach(alphabet, id: \.self) { char in
                                Text(String(char)).tag(String(char))
                            }
                        }
                        Picker("Rotor 3 Start", selection: $rotor3StartChar) {
                            ForEach(alphabet, id: \.self) { char in
                                Text(String(char)).tag(String(char))
                            }
                        }
                    }
                    
                    Section(header: Text("Plugboard")) {
                        Toggle("Use Plugboard", isOn: $usePlugboard)
                        if usePlugboard {
                            PlugboardSettingsView(plugboardMappings: $plugboardMappings)
                        }
                    }
                    
                    Section(header: Text("Text to Encrypt")) {
                        TextField("Enter plaintext", text: $plaintext)
                    }
                    
                    Section(header: Text("Encrypted Text")) {
                        Text(ciphertext)
                    }
                    
                    Button(action: {
                        do {
                            try encryptText()
                        } catch {
                            errorMessage = error.localizedDescription
                            showingErrorAlert = true
                        }
                    }) {
                        Text("Encrypt")
                    }
                    .alert(isPresented: $showingErrorAlert) {
                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }

                }
                .navigationTitle("Enigma Encryption")
            }
    }

    func encryptText() throws{
        let enigma = EnigmaMachine(startChar1: Character(rotor1StartChar),
                                   startChar2: Character(rotor2StartChar),
                                   startChar3: Character(rotor3StartChar),
                                   plugboard: plugboardMappings)
        
        do {ciphertext = try enigma.encrypt(plaintext)}
        catch (EnigmaError.asciiNotExist) {throw EnigmaError.asciiNotExist}
    }
}

struct PlugboardSettingsView: View {
    @Binding var plugboardMappings: [Character: Character]

    private let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(alphabet, id: \.self) { char in
                HStack {
                    Text(String(char))
                    Spacer()
                    TextField("Plug", text: Binding(
                        get: { self.plugboardMappings[char]?.description ?? "" },
                        set: { self.plugboardMappings[char] = $0.isEmpty ? nil : $0.first }))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 50)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
