//
//  DetailModels.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

struct ResponsePostDetail: Codable {
    var limit: Int64?
    var dados: [DadosDetail]?
    var total: Int64?
    var page: Int64?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingDefaultKeys.self)
        limit = try values.decode(Int64.self, forKey: .limit)
        total = try values.decode(Int64.self, forKey: .total)
        page = try values.decode(Int64.self, forKey: .page)
        dados = try values.decode([DadosDetail].self, forKey: .data)
    }
}

enum CodingDetailKeys: String, CodingKey {
    case owner
    case id
    case post
    case message
}

struct DadosDetail: Codable {
    var id: Int64
    var message: String
    var owner: Owner
    var post: Int64
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingDetailKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        post = try values.decode(Int64.self, forKey: .post)
        message = try values.decode(String.self, forKey: .message)
        owner = try values.decode(Owner.self, forKey: .owner)
    }
}
