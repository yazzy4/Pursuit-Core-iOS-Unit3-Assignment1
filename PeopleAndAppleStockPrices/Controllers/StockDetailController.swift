//
//  StockDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yaz Burrell on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockClose: UILabel!
    
    var stockDetailImage: StockPrice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedStockUI()
        print(stockDetailImage.date)
       
    }
    func updatedStockUI(){
        dateLabel.text = stockDetailImage.date
        stockOpen.text = "$" + String(format: "%.2f", stockDetailImage.open)
        stockClose.text = "$" + String(format: "%.2f", stockDetailImage.close)
        if stockDetailImage.open < stockDetailImage.close {
            stockImage.image = UIImage(named: "thumbsUP")
            self.view.backgroundColor = .green
        } else {
            stockImage.image = UIImage(named: "thumbsDown")
            self.view.backgroundColor = .red
        }
    }

    

}
