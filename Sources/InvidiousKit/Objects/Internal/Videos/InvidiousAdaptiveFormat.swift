//
//  InvidiousAdaptiveFormat.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousAdaptiveFormat: Codable {
    
    let `init`:String?
    let index: String?
    let bitrate: String
    let url: String
    let itag: String
    let type: String
    let clen: String
    let lmt: String
    let projectionType: String
    let audioQuality: String?
    let audioSampleRate: Int?
    let audioChannels: Int?
    let fps: Int?
    let colorInfo: InvidiousColorInfo?
    let container: String?
    let encoding: String?
    let qualityLabel: String?
    let resolution: String?
}

struct InvidiousColorInfo: Codable {
    let primaries:String
    let transferCharacteristics:String
    let matrixCoefficients:String
}
