//
//  PostListInteractor.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

enum methodURLPost: String {
    case post = "/post"
}

protocol call {
    func request(method:String, completion: @escaping (Data) -> ())
}

protocol callImage {
    func downloadImage(from url: URL, completion: @escaping (UIImage) -> ())
}


class PostListInteractor: call, callImage {
    func request(method: String, completion: @escaping (Data) -> ()) {
        ConnectorHelperRequest.request(method: method, completion: completion)
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()) {
        ConnectorHelperRequest.downloadImage(from: url, completion: completion)
    }
}
