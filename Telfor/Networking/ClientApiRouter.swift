//
//  ClientApiRouter.swift
//  Telfor
//
//  Created by Marko Mladenovic on 28/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public let baseUrl = "http://127.0.0.1:8080"

public enum ClientApiRouter {
    case getPrimaryInfo
    case getSecondaryInfo(Int)
    case getTertiaryInfo
    case getSession(String)
    case getAuthor(String)
    case getPaper(String)
    case getRoom(String)

    public func asUrl() -> URL? {
        let urlPath = baseUrl + "/api/u"
        guard let url = URL(string: urlPath) else { return nil }
        switch self {
        case .getPrimaryInfo:
            return url.appendingPathComponent("primaryInfo")
        case .getSecondaryInfo(let limit):
            guard let url = add(queryItem: "limit", with: String(limit), to: urlPath) else {
                return nil
            }
            return url.appendingPathComponent("secondaryInfo")
        case .getTertiaryInfo:
            return url.appendingPathComponent("tertiaryInfo")
        case .getSession(let uid):
            return url.appendingPathComponent("session").appendingPathComponent(uid)
        case .getAuthor(let uid):
            return url.appendingPathComponent("author").appendingPathComponent(uid)
        case .getPaper(let uid):
            return url.appendingPathComponent("paper").appendingPathComponent(uid)
        case .getRoom(let uid):
            return url.appendingPathComponent("room").appendingPathComponent(uid)
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
