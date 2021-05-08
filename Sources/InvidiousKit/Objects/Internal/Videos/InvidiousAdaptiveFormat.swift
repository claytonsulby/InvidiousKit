//
//  InvidiousAdaptiveFormat.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousAdaptiveFormat: Codable {
    
    let index: String
    let bitrate: String
    let url: String
    let itag: String
    let type: String
    let clen: String
    let lmt: String
    let projectionType: String
    let container: String?
    let encoding: String?
    let qualityLabel: String?
    let resolution: String?
}
