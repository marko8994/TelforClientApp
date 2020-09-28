//
//  HomeDataProvider.swift
//  Telfor
//
//  Created by Marko Mladenovic on 28/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public typealias ListCompletion<T> = (Error?, [T]?) -> Void
public typealias SingleCompletion<T> = (Error?, T?) -> Void

class HomeDataProvider {
    
    private lazy var homeApi: ClientApiService = {
        return ClientApiService()
    }()
    
//    func getAll(limit: Int, completion: @escaping SingleServiceResult<HomeModel>) {
//        homeApi.getAll(limit: limit) { (data, error)
//            guard error == nil {
//                return
//            }
//            guard let data = data {
//                return
//            }
//        }
    
//    func getAll(limit: Int, completion: @escaping SingleCompletion<HomeModel>) {
//        homeApi.getAll(limit: limit, fail: { (error) in
//            completion(error, nil)
//        }, success: { [weak self] (homeData) in
//            guard self != nil else {
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, homeData)
//            }
//        })
//    }
}
