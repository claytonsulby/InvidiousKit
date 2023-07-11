//
//  Agent.swift
//  JSFun
//
//  Created by Clayton Sulby on 3/30/21.
//

import Foundation
import Combine

struct Agent {

    struct Response<T> {
        internal init(value: T, response: URLResponse) {
            self.value = value
            self.response = response
        }
        
        let value: T
        let response: URLResponse
    }

    @available(iOS 13.0, *)
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap {
                result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder(), completion: @escaping (T?, Error?) -> Void) throws {
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                completion(try map(response: response, error: error, data: data), nil)
            } catch {
                completion(nil, error)
            }
        }).resume()
    }
    
    @available(iOS 13.0.0, *)
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) async throws -> Response<T> {
        let (data, response) = try await URLSession.shared.data(for: request)
        let value = try decoder.decode(T.self, from: data)
        return Response(value: value, response: response)
    }
    
    func map<T: Decodable>(response: URLResponse?, error: (any Error)?, data: Data?) throws -> T? {
        if (error as? URLError)?.code == .timedOut {
            throw InvidiousError.requestTimeout(data: data)
        }
        if let error = error as? URLError {
            throw InvidiousError.invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: data)
        }
        if let response = response as? HTTPURLResponse {
            if (200..<300) ~= response.statusCode {
                guard let data = data else {
                    throw InvidiousError.decodingError(message: "Could not Convert Optional<Data> into Data", data: data) as Error
                }
                if let object = try? JSONDecoder().decode(T.self, from: data) {
                    if let stringError = object as? StringError {
                        if stringError.error == nil {
                            return object
                        } else {
                            throw InvidiousError.suppliedErrorField(message: stringError.error!, data: data)
                        }
                    }
                } else {
                    throw InvidiousError.decodingError(message: "Could not decode data", data: data)
                }
            } else {
                throw InvidiousError.invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: data)
            }
        } else {
            throw InvidiousError.decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: data)
        }
        return nil
    }
}
