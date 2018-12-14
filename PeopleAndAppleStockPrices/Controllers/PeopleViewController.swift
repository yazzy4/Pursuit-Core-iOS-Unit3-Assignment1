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
    var searchUsers = [Person]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        peopleTableView.dataSource = self
        searchBar.delegate = self
        loadData()
        dump(users)
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = peopleTableView.indexPathForSelectedRow,
            let PeopleDetailController = segue.destination as? PeopleDetailController else {fatalError("indexPath, error")}
            let user = users[indexPath.row]
                PeopleDetailController.user = user
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let peopleURL = URL.init(fileURLWithPath: path)
       
            if let data = try? Data.init(contentsOf: peopleURL) {
                do {
                    let outerLayer = try JSONDecoder().decode(Person.UserInfo.self, from: data)
                        self.users = outerLayer.results
                        self.searchUsers = outerLayer.results
                    
                } catch {
                    print("type: \(error)")
                }
            }
        }
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return searchUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let personToSet = searchUsers[indexPath.row]
        cell.textLabel?.text = personToSet.name.fullName
        cell.detailTextLabel?.text = personToSet.location.city.uppercased()
        guard let image = URL.init(string: personToSet.picture.thumbnail) else {
            return UITableViewCell()
        }
        do {
            let data = try Data.init(contentsOf: image)
            cell.imageView?.image = UIImage.init(data: data)
        } catch {
            print("image not found")
        }
        return cell
    }
    
   
}

extension PeopleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            
        }

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        var searchQueryUsers = [Person]()
        if searchText.isEmpty {
            self.searchUsers = self.users
            self.peopleTableView.reloadData()
//            searchBar.resignFirstResponder()
        } else {
            for user in self.users {
                if user.name.fullName.contains(searchText) {
                    print(user.name.fullName)
                    searchQueryUsers.append(user)
                    
                }
                
            }
            self.searchUsers = searchQueryUsers
            self.peopleTableView.reloadData()
            
        }
        
    }
    
}


