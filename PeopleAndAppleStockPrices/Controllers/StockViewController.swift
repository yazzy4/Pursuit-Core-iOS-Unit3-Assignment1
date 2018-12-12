//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yaz Burrell on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {

    var stocks = [StockPrice]()
    
    
    @IBOutlet weak var stockTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stocks = loadData()
        
    }
    
    func loadData() ->[StockPrice] {
        var stocks = [StockPrice]()
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            print("path not valid")
            return stocks
        }
        
        guard let data = FileManager.default.contents(atPath: path) else {
            print("contents not found at path: \(path)")
            return stocks
        }
        
        do {
            stocks = try JSONDecoder().decode([StockPrice].self,from: data)
            print("\(stocks.count)")
        } catch {
            print("decoding error: \(error)")
        }
        return stocks
    }
        
        
        

    
}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return stocks.count
        
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stockToSet = stocks[indexPath.row]
            cell.textLabel?.text = stockToSet.date
            return cell
    }
    
}
