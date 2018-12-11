//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yaz Burrell on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Person: Codable {
    struct UserInfo: Codable {
        var results: [Person]
    }
    
    struct NameInfo: Codable {
        var first: String
        var last: String
        public var fullName: String {
            return first.capitalized + " " + last.capitalized
        }

    }
    
    struct Places: Codable {
        var city: String
        var state: String
    }
    struct UserImage: Codable{
        var large: String
    }

    
    var name: NameInfo
    var location: Places
    var email: String
    var picture : UserImage
    
    }
