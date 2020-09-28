//
//  ClientHomeApi.swift
//  Telfor
//
//  Created by Marko Mladenovic on 28/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public let baseUrl = "http://127.0.0.1:8080"

public enum TelforError: Error {
    case invalidUrl
}

public protocol URLConvertible {
    func asUrl() throws -> URL
}

extension String: URLConvertible {

    public func asUrl() throws -> URL {
        if let url = URL(string: self) {
            return url
        }
        throw TelforError.invalidUrl
    }
}

public class ClientHomeApi {
    
    private enum ClientHomeRouter: URLConvertible {
        case getAll(Int)

        public func asUrl() throws -> URL {
            let url = try (baseUrl + "/api/u/home").asUrl()
            switch self {
            case .getAll:
                return url.appendingPathComponent("getAll")
            }
        }
    }
    
    // -MARK: Returns home data
    public func getAll(limit: Int,
                       fail: @escaping (Error) -> Void,
                       success: @escaping (HomeModel) -> Void) {
        do {
            let session = URLSession.shared
            let url = try ClientHomeRouter.getAll(limit).asUrl()
            let queryItems = [URLQueryItem(name: "limit", value: String(limit))]
            var urlComps = URLComponents(string: "http://127.0.0.1:8080/api/u/home/getAll")
            urlComps?.queryItems = queryItems
            let result = (urlComps?.url!)!
            let task = session.dataTask(with: result, completionHandler: { data, response, error in
                guard let data = data else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                // Check the response
    //                print(response)
                
                // Check if an error occured
                if let error = error {
                    // HERE you can manage the error
                    fail(error)
                    print(error.localizedDescription)
                    return
                }
                // Serialize the data into an object
                do {
                    let decoder = JSONDecoder()
                    let homeData: HomeModel = try decoder.decode(HomeModel.self, from: data)
                    success(homeData)
                } catch {
                    fail(error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            })
            task.resume()
        } catch let error {
            fail(error)
        }
    }
}

//            let task = try sessionManager.dataTask(url: url,
//                                                   httpMethod: .get)
//            task.completion = { response in
//                do {
//                    guard response.error == nil else {
//                        throw response.error!
//                    }
//                    let channel = try EndUserChannel(dictionary: task.result())
//                    self.completionQueue.async {
//                        success(channel)
//                    }
//                } catch let error {
//                    self.completionQueue.async {
//                        fail(error.asOCError())
//                    }
//                }
//            }
//            task.resume()
//        } catch let error {
//            self.completionQueue.async {
//                fail(error.asOCError())
//            }
//        }
