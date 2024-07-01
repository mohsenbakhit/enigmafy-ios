//
//  ContentView.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: EnigmaView()) {
                    Text("Enigma Encryption")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(width: 280, height: 60)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: CaesarView()) {
                    Text("Caesar Cipher")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(width: 280, height: 60)
                        .background(Color(red: 220/255, green: 15/255, blue: 50/255))
                        .cornerRadius(10)
                }
                Text("More support will be added!")
            }
            .navigationTitle("Enigmafy")
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
