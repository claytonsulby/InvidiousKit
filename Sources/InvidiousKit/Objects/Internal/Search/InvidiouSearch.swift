//
//  InvidiousSearch.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousSearchReference: Codable {
    
    struct Suggestions: Codable {
        public let query: String
        public let suggestions: [String]
        public let error: String?
    }
    
}
