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
}

class TableViewController: UITableViewController {
    
    var elementArray = [Element]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("table did load")
        
        
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
        let element = elementArray[indexPath.row]
  let imagePath = getImage(imageName: element.imageName)
        cell.mealImagePlace.image = UIImage(contentsOfFile: imagePath)
        
        return cell
    }
    
    func getImage(imageName: String) -> String {
        // create instance of FileManager
        let fileManager = FileManager.default
        
        // get the file system image path and return it
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        if (fileManager.fileExists(atPath: imagePath)) {
            return imagePath
        } else {
            return "default"
        }
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
