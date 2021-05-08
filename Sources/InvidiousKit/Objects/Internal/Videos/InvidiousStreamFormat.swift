//
//  InvidiousStreamFormat.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousStreamFormat: Codable {
    
    let url: String
    let itag: String
    let type: String
    let container: String
    let fps: Int32
    let encoding: String
    let qualityLabel: String
    let resolution: String
    let size: String
}
