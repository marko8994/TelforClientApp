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

public enum ClientHomeRouter {
    case getAll(Int)
    case getAuthor(String)
    case getPaper(String)

    public func asUrl() -> URL? {
        let urlPath = baseUrl + "/api/u"
        guard let url = URL(string: urlPath) else { return nil }
        switch self {
        case .getAll(let limit):
            guard let url = add(queryItem: "limit", with: String(limit), to: urlPath) else {
                return nil
            }
            return url.appendingPathComponent("home").appendingPathComponent("getAll")
        case .getAuthor(let uid):
            return url.appendingPathComponent("author").appendingPathComponent(uid)
        case .getPaper(let uid):
            return url.appendingPathComponent("paper").appendingPathComponent(uid)
        }
    }
    
    private func add(queryItem: String, with value: String, to urlPath: String) -> URL? {
        if var urlComponents = URLComponents(string: urlPath) {
            urlComponents.query = "\(queryItem)=\(value)"
             if let url = urlComponents.url {
                return url
             } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

public class ClientHomeApi {

    
    // -MARK: Returns home data
//    public func getAll(limit: Int,
//                       fail: @escaping (Error) -> Void,
//                       success: @escaping (HomeModel) -> Void) {
//        do {
//            let session = URLSession.shared
//            let url = try ClientHomeRouter.getAll(limit).asUrl()
//            let queryItems = [URLQueryItem(name: "limit", value: String(limit))]
//            var urlComps = URLComponents(string: "http://127.0.0.1:8080/api/u/home/getAll")
//            urlComps?.queryItems = queryItems
//            let result = (urlComps?.url!)!
//            let task = session.dataTask(with: result, completionHandler: { data, response, error in
//                guard let data = data else {
//                    fatalError("Data is not")
//                }
//                if let error = error {
//                    fail(error)
//                    print(error.localizedDescription)
//                    return
//                }
//                do {
//                    let homeData: HomeModel = try JSONDecoder().decode(HomeModel.self, from: data)
//                    success(homeData)
//                } catch {
//                    fail(error)
//                    print("Error during JSON serialization: \(error.localizedDescription)")
//                }
//            })
//            task.resume()
//        } catch let error {
//            fail(error)
//        }
//    }
}
