//
//  URLQueryItem+.swift
//  InvidiousTest
//
//  Created by Clayton Sulby on 2/4/23.
//

import Foundation

extension URLQueryItem {
    
    init?(name: String, optional value: String?) {
        guard value != nil else { return nil }
        self.init(name: name, value: value)
    }
    
}
