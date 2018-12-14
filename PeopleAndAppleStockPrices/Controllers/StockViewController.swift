//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yaz Burrell on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    var stockPrices = [StockPrice]()
    var stocks = [StockPrice]() {
        didSet{
            DispatchQueue.main.async {
                self.stockTableView.reloadData()
            }
        
        }
    }
    
    var stocksByYear = [[StockPrice]]()
    var stocksByMonth = [[StockPrice]]()
    var previousDate = ""
    var sectionNames = [String]()
    
    @IBOutlet weak var stockTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        stocks = loadData()
        getSectionNames()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let StockDetailController = segue.destination as? StockDetailController,
            let cellSelected = stockTableView.indexPathForSelectedRow else { return }
        let sectionStocks = self.stockBySection(intSection: cellSelected.section)
        let myStock = sectionStocks[cellSelected.row]
        StockDetailController.stockDetailImage = myStock
    }
    
    func getSectionNames() {
        for stock in stockPrices {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        
        }
        
    }
    func stockBySection(intSection: Int) -> [StockPrice]{
        return stocks.filter({$0.sectionName == sectionNames[intSection]})
    }
    
    

    func headerSection(){
        for yearNum in 2016...2017 {
            let  yearStock = stocks.filter {(StockPrice) -> Bool in
                let dateSeparated = StockPrice.date.components(separatedBy: "-")
                let currentStockMonth = dateSeparated[1]
                if Int(currentStockMonth) == yearNum {
                  return true
                } else {
                    return false
                }
                
            }
            stocksByYear.append(yearStock)
            
        }
        for arrYearStocks in stocksByYear {
            for monthNum in 1...12 {
                let stockMonthArr = arrYearStocks.filter {(StockPrice)-> Bool in
                    let dateSeperated = StockPrice.date.components(separatedBy: "-")
                    let currentStockMonth = dateSeperated[1]
                    if Int(currentStockMonth) == monthNum {
                        return true
                    } else {
                        return false
                    }
                    
                }
                if !stockMonthArr.isEmpty {
                    stocksByMonth.append(stockMonthArr)
                }
            }
        }
        
    }

    func loadData() ->[StockPrice] {
        var stocks = [StockPrice]()
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            print("path not valid")
           
            return stocks
        }
        
        guard let data = FileManager.default.contents(atPath: path) else {
            return stocks
        }
        
        do {
            let stocksArray = try JSONDecoder().decode([StockPrice].self,from: data)
            stocks = stocksArray.sorted(by: {(stockOne, stockTwo) -> Bool in
                return stockOne.date < stockTwo.date
            })

        } catch {
            print("decoding error: \(error)")
                }
        return stocks
            }

        }



extension StockViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return stocks.count
        
        }
    func numberOfSections(in tableView: UITableView) -> Int {
       return stocksByMonth.count
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionHeader = sectionNames[section]
        let stocksInThisSection = stocks.filter({($0.sectionName == sectionHeader)})
        var sum = 0.0
        for stock in stocksInThisSection {
            sum += stock.open
        }
        let average = sum / Double(stocksInThisSection.count)
        return sectionNames[section] + "                  " + "Average \(String(format: "% .2", average))"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stockToSet = stocks[indexPath.row]
            cell.textLabel?.text = stockToSet.date
        cell.detailTextLabel?.text = "$" + String(format: "%.2", stockToSet.open)
        return cell
    }
    
    
    
}
