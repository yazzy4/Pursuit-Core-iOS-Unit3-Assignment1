//
//  PeopleDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yaz Burrell on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var contactLocation: UILabel!
    
    public var user: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
   
    private func updateUI() {
        contactName.text = user?.name.fullName
        contactEmail.text = user?.email
        contactLocation.text = user?.location.city.uppercased()
    }
    

    

}
