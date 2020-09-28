//
//  ClientMainService.swift
//  Telfor
//
//  Created by Marko Mladenovic on 28/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public typealias SingleServiceResult<T> = (T?, Error?) -> Void
public typealias ListServiceResult<T> = ([T]?, Error?) -> Void


class ClientMainService {

    let defaultSession = URLSession(configuration: .default)

    var dataTask: URLSessionDataTask?

    func getAll(limit: Int, completion: @escaping SingleServiceResult<HomeModel>) {
        //1
        dataTask?.cancel()
        // 2
        guard let url = ClientHomeRouter.getAll(limit).asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        // 4
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }
            
            // 5
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let homeData: HomeModel = try JSONDecoder().decode(HomeModel.self, from: data)
                    // 6
                    DispatchQueue.main.async {
                      completion(homeData, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        // 7
        dataTask?.resume()
    }
}
