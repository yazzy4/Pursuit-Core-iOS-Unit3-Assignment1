//
//  PeopleViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    var users = [Person]()

    @IBOutlet weak var peopleTableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        peopleTableView.dataSource = self
        loadData()
        dump(users)
  }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let peopleURL = URL.init(fileURLWithPath: path)
       
            if let data = try? Data.init(contentsOf: peopleURL) {
                do {
                    let outerLayer = try JSONDecoder().decode(Person.UserInfo.self, from: data)
                    self.users = outerLayer.results
                } catch {
                    print("type: \(error)")
                }
            }
        }
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let personToSet = users[indexPath.row]
        cell.textLabel?.text = personToSet.name.fullName
        cell.detailTextLabel?.text = personToSet.location.city.uppercased()
        return cell
    }
}
