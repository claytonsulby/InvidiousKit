//
//  InvidiousError.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public enum InvidiousError: Error {
    case invalidDataSupplied(message: String, data: Data?)
    case invalidDataReturned(message: String, data: Data?)
    case decodingError(message: String, data: Data?)
    case suppliedErrorField(message: String, data: Data?)
    
    public func getAssociatedData() -> (String, Data?) {
        switch self {
        case .invalidDataSupplied(let message, let data), .invalidDataReturned(let message, let data), .decodingError(let message, let data), .suppliedErrorField(let message, let data):
            return (message, data)
        }
    }
}
