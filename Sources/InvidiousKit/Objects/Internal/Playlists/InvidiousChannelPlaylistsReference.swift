//
//  InvidiousChannelPlaylists.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousChannelPlaylistsReference: Codable {
    let playlists: [InvidiousChannelPlaylist]
    let continuation: String?
}
