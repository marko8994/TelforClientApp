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

public class ClientApiService {

    let defaultSession = URLSession(configuration: .default)

    var dataTask: URLSessionDataTask?
    
    private func dateDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    func getPrimaryInfo(completion: @escaping SingleServiceResult<PrimaryInfoModel>) {
        dataTask?.cancel()
        guard let url = ClientApiRouter.getPrimaryInfo.asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completion(nil, nil)
                return
            }
            defer {
                self.dataTask = nil
            }
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let primaryInfo: PrimaryInfoModel = try self.dateDecoder().decode(PrimaryInfoModel.self, from: data)
                    DispatchQueue.main.async {
                      completion(primaryInfo, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }

    func getSecondaryInfo(limit: Int, completion: @escaping SingleServiceResult<SecodanryInfoModel>) {
        dataTask?.cancel()
        guard let url = ClientApiRouter.getSecondaryInfo(limit).asUrl() else {
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
                    let secondaryInfo: SecodanryInfoModel = try JSONDecoder().decode(SecodanryInfoModel.self, from: data)
                    DispatchQueue.main.async {
                      completion(secondaryInfo, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func getTertiaryInfo(completion: @escaping SingleServiceResult<TertiaryInfoModel>) {
        dataTask?.cancel()
        guard let url = ClientApiRouter.getTertiaryInfo.asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completion(nil, nil)
                return
            }
            defer {
              self.dataTask = nil
            }
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let tertiaryInfo: TertiaryInfoModel = try self.dateDecoder().decode(TertiaryInfoModel.self, from: data)
                    DispatchQueue.main.async {
                      completion(tertiaryInfo, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func getSession(with id: String, completion: @escaping SingleServiceResult<Session>) {
        dataTask?.cancel()
        guard let url = ClientApiRouter.getSession(id).asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completion(nil, nil)
                return
            }
            defer {
              self.dataTask = nil
            }
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let session: Session = try self.dateDecoder().decode(Session.self, from: data)
                    DispatchQueue.main.async {
                      completion(session, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func getAuthor(with id: String, completion: @escaping SingleServiceResult<Author>) {
        dataTask?.cancel()
        guard let url = ClientApiRouter.getAuthor(id).asUrl() else {
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
                    let author: Author = try JSONDecoder().decode(Author.self, from: data)
                    DispatchQueue.main.async {
                      completion(author, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func getPaper(with id: String, completion: @escaping SingleServiceResult<Paper>) {
        dataTask?.cancel()
        guard let url = ClientApiRouter.getPaper(id).asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completion(nil, nil)
                return
            }
            defer {
              self.dataTask = nil
            }
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let paper: Paper = try self.dateDecoder().decode(Paper.self, from: data)
                    DispatchQueue.main.async {
                      completion(paper, nil)
                    }
                } catch {
                    completion(nil, error)
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func getRoom(with id: String, completion: @escaping SingleServiceResult<Room>) {
        dataTask?.cancel()
        guard let url = ClientApiRouter.getRoom(id).asUrl() else {
            completion(nil, nil)
            print("Invalid url passed for request")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completion(nil, nil)
                return
            }
            defer {
              self.dataTask = nil
            }
            if let error = error {
              completion(nil, error)
            } else if let data = data {
                do {
                    let room: Room = try self.dateDecoder().decode(Room.self, from: data)
                    DispatchQueue.main.async {
                      completion(room, nil)
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




