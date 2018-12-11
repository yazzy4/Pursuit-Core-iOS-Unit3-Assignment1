//
//  StockPrices .swift
//  PeopleAndAppleStockPrices
//
//  Created by Yaz Burrell on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockInfo: Codable {
    var date: String
    var open: Int
    var high: Int
    var low: Int
    var close: Int
}
