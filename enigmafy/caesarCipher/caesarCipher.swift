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

func decaesarify(input: String, shift: Int) -> String {
    var output = ""
    let shift = shift % 26 // Normalize the shift to within the range of the alphabet

    for letter in input.uppercased() {
        if let index = alphabet.firstIndex(of: letter) {
            // Calculate the new index ensuring it wraps correctly
            let newIndex = (index - shift + 26) % 26
            output.append(alphabet[newIndex])
        } else {
            output.append(letter) // Append non-alphabetic characters as is
        }
    }

    return output
}
