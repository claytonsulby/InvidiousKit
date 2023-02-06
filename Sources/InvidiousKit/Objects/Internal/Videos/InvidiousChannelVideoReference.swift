//
//  File.swift
//  
//
//  Created by Clayton Sulby on 2/4/23.
//

import Foundation

struct InvidiousChannelVideoReference: Codable {
    let videos: [InvidiousVideoPreview.ChannelVideo]
    let continuation: String?
}
