//
//  Caption.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Objects responsible for storing caption data
public struct Caption {
    
    /// Initializes Caption from JSON decoded representiation
    /// - Parameter caption: JSON decoded response from Invidious
    internal init(from caption: InvidiousCaption) {
        self.label = caption.label
        self.language = caption.languageCode
        self.url = URL(string: caption.url)!
    }
    
    public let label: String
    public let language: String
    public let url: URL
}
