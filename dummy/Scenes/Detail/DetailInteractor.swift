//
//  DetailInteractor.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

enum methodURLDetail: String {
    case postDetail = "/post/{postId}/comment"
}

class DatailInteractor: call, callImage {
    func request(method: String, completion: @escaping (Data) -> ()) {
        ConnectorHelperRequest.request(method: method, completion: completion)
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()) {
        ConnectorHelperRequest.downloadImage(from: url, completion: completion)
    }
}
