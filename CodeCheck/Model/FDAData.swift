//
//  FDAAPI.swift
//  CodeCheck
//
//  Created by Ņikita Roldugins on 18/03/2022.
//

import Foundation

struct FDAData: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let city: String
}
