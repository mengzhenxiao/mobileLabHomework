//
//  TableViewController.swift
//  My Meal
//
//  Created by 肖梦真 on 2/20/19.
//  Copyright © 2019 mengzhenxiao. All rights reserved.
//

import UIKit

private let elementArrayKey = "ELEMENT_ARRAY_KEY"
private let reuseIdentifier = "TableViewCell"

struct Element: Codable {
    let imageName: String
    let mealTime: String
    let date: String
}

class TableViewController: UITableViewController {
    
    var elementArray = [Element]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("table did load")
        
//        let meal1 = Meals(imageName: "meal1.jpg", mealTime: "03:02", currentTime: "20:41", date: "02/18/19")
//
//        let meal2 = Meals(imageName: "meal2.jpg", mealTime: "04:02", currentTime: "13:45", date: "02/19/19")
//
//        meals.append(meal1)
//        meals.append(meal2)
        
        // Get Data from user defaults and set data array.
        if let data = UserDefaults.standard.value(forKey: elementArrayKey) as? Data {
            
            let elementArray = try? PropertyListDecoder().decode(Array<Element>.self, from: data)
            
            self.elementArray = elementArray!
            
            self.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elementArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        
        // Configure the cell...
        cell.mealTimePlace.text = elementArray[indexPath.row].mealTime
        cell.datePlace.text = elementArray[indexPath.row].date
        cell.mealImagePlace.image = UIImage(named: elementArray[indexPath.row].imageName)
        
        return cell
    }
    

    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ActionViewController") as? ActionViewController else {
            print("Error instantiating ActionViewController" )
            return
        }
        
        // Define callback method.
        vc.didSaveElement = { [weak self] element in
            
            self?.elementArray.append(element)
            
            // Resave element array into User defaults.
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self?.elementArray), forKey: elementArrayKey)
            
            self?.tableView.reloadData()
        }

      present(vc, animated: true, completion: nil)
    }
    
}
