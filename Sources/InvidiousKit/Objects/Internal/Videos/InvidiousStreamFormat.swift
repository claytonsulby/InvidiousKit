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
    let quality: String
    let fps: Int32
    let container: String
    let encoding: String
    let resolution: String
    let qualityLabel: String
    let size: String
}
