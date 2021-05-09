//
//  InvidiousError.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Error object that indicates any errors while processing data requests
public enum InvidiousError: Error {
    case invalidDataSupplied(message: String, data: Data?)
    case invalidDataReturned(message: String, data: Data?)
    case decodingError(message: String, data: Data?)
    case suppliedErrorField(message: String, data: Data?)
    case requestTimeout(data: Data?)
    
    /// Returns associated data of a given error case
    /// - Returns: Tuple containing error message and a data optional that might have been the cause
    public func getAssociatedData() -> (String, Data?) {
        switch self {
        case .invalidDataSupplied(let message, let data), .invalidDataReturned(let message, let data), .decodingError(let message, let data), .suppliedErrorField(let message, let data):
            return (message:message, data: data)
        case .requestTimeout(let data):
            return (message: "Request timed out", data: data)
        }
    }
}
