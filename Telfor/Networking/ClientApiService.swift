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

public struct AuthorResponse: Codable {
    let author: Author
    let papers: [LightPaper]
}

public struct PaperResponse: Codable {
    let paper: Paper
    let authors: [LightAuthor]
}


public class ClientApiService {

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
    
    func getAuthor(with id: String, completion: @escaping SingleServiceResult<AuthorResponse>) {
        dataTask?.cancel()
        guard let url = ClientHomeRouter.getAuthor(id).asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let authorResponse: AuthorResponse = try JSONDecoder().decode(AuthorResponse.self, from: data)
                    DispatchQueue.main.async {
                      completion(authorResponse, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func getPaper(with id: String, completion: @escaping SingleServiceResult<PaperResponse>) {
        dataTask?.cancel()
        guard let url = ClientHomeRouter.getPaper(id).asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatter.locale = Locale.current
                    dateFormatter.timeZone = TimeZone.current
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let paperResponse: PaperResponse = try decoder.decode(PaperResponse.self, from: data)
                    DispatchQueue.main.async {
                      completion(paperResponse, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
}
