//
//  InvidiousCaption.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousCaption: Codable {
   
    let label: String
    let languageCode: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case label = "label"
        case languageCode = "language_code"
        case url = "url"
    }
}
