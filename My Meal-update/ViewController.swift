//
//  ViewController.swift
//  My Meal
//
//  Created by 肖梦真 on 2/28/19.
//  Copyright © 2019 mengzhenxiao. All rights reserved.
//

import UIKit

private let elementArrayKey = "ELEMENT_ARRAY_KEY"
private let reuseIdentifier = "TableViewCell"

struct Element: Codable {
    let imageName: String
    let date: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

     var elementArray = [Element]()

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        print ("table did load")
        
        
        // Get Data from user defaults and set data array.
        if let data = UserDefaults.standard.value(forKey: elementArrayKey) as? Data {
            
            let elementArray = try? PropertyListDecoder().decode(Array<Element>.self, from: data)
            
            self.elementArray = elementArray!
            
            self.tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        
        cell.datePlace.text = elementArray[indexPath.row].date
        // Configure the cell...
        let element = elementArray[indexPath.row]
        let imagePath = getImage(imageName: element.imageName)
        cell.mealImagePlace.image = UIImage(contentsOfFile: imagePath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            elementArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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
    
    
    @IBAction func addButton(_ sender: UIButton) {
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
