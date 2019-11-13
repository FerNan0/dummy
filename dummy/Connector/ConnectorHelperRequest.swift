//
//  ConnectorHelperRequest.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

enum baseURL: String {
    case url = "https://n161.tech/api/dummyapi"
}

class ConnectorHelperRequest {
    static func request(method: String, completion: @escaping (Data) -> ()){
        let url = URL(string: "\(baseURL.url.rawValue)\(method)")
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
          if error != nil {
            print(error)
          } else {
            do {
              let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                
                completion(data!)
                print(parsedData)
              
            } catch let error as NSError {
              print(error)
            }
          }

        }.resume()
    }
    
    static func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()) {
        var img: UIImage?
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            img = UIImage(data: data)
            completion(img!)
        }
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
