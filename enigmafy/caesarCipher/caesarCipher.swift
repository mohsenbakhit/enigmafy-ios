//
//  caesarCipher.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import Foundation

private let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

func caesarify(input: String, shift: Int) -> String{
    var output = ""
    for letter in input.uppercased() {
        if let index = alphabet.firstIndex(of: letter) {
            let newIndex = (index + shift) % 26
            output.append(alphabet[newIndex])
        } else {
            output.append(letter)
        }
    }
    return output
}
