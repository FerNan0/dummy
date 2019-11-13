//
//  PostListModel.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

enum CodingDefaultKeys: String, CodingKey {
    case limit
    case data
    case total
    case page
}

enum CodingDadosKeys: String, CodingKey {
    case owner
    case tags
    case id
    case image
    case message
}

enum CodingOwnerKeys: String, CodingKey {
    case id
    case nameTitle
    case firstName
    case lastName
    case image
}

struct ResponsePostDefault: Codable {
    var limit: Int64?
    var dados: [DadosDefault]?
    var total: Int64?
    var page: Int64?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingDefaultKeys.self)
        limit = try values.decode(Int64.self, forKey: .limit)
        total = try values.decode(Int64.self, forKey: .total)
        page = try values.decode(Int64.self, forKey: .page)
        dados = try values.decode([DadosDefault].self, forKey: .data)
    }
}
struct DadosDefault: Codable {
    var owner: Owner
    var tags: [String] = [String]()
    var id: Int64
    var image: String
    var message: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingDadosKeys.self)
        owner = try values.decode(Owner.self, forKey: .owner)
        var arrayContainer = try decoder.container(keyedBy: CodingDadosKeys.self).nestedUnkeyedContainer(forKey: .tags)
        while !arrayContainer.isAtEnd {
            let chapterDict = try? arrayContainer.decode(String.self)
            if chapterDict != nil {
                self.tags.append(String(chapterDict!))
            } else {
                break
            }
        }
        id = try values.decode(Int64.self, forKey: .id)
        image = try values.decode(String.self, forKey: .image)
        message = try values.decode(String.self, forKey: .message)
    }
}

struct Owner: Codable {
    var id: Int64
    var nameTitle: String
    var firstName: String
    var lastName: String
    var image: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingOwnerKeys.self)
        nameTitle = try values.decode(String.self, forKey: .nameTitle)
        id = try values.decode(Int64.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        image = try values.decode(String.self, forKey: .image)
    }
}
