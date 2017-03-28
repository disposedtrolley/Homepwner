//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by James Liu on 27/3/17.
//  Copyright © 2017 James Liu. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    struct Section {
        var heading: String
        var items: [Item]
        
        init(title: String, objects: [Item]) {
            heading = title
            items = objects
        }
    }
    
    var sections: [Section]!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        if indexPath.row == sections[indexPath.section].items.count {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
            cell.textLabel?.font = UIFont(name: "Avenir", size: 16)
        } else {
            cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].name
            cell.detailTextLabel?.text = "$\(sections[indexPath.section].items[indexPath.row].valueInDollars)"
            cell.textLabel?.font = UIFont(name: "Avenir", size: 22)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == sections[indexPath.section].items.count {
            return 44
        } else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Set background colour of cells and text labels
        cell.textLabel?.backgroundColor = UIColor(white: 1, alpha: 0.3)
        cell.detailTextLabel?.backgroundColor = UIColor(white: 1, alpha: 0.3)
        cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        sections = getSectionsFromItemStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Add background image
        let backgroundImage = UIImage(named: "640x1136.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }
    
    func getSectionsFromItemStore() -> [Section] {
        var sectionsArray = [Section]()
        
        var expensiveItemsArray = [Item]()
        var cheapItemsArray = [Item]()
        for item in itemStore.allItems {
            if item.valueInDollars > 50 {
                expensiveItemsArray.append(item)
            } else {
                cheapItemsArray.append(item)
            }
        }
        
        let expensiveItems = Section(title: "Expensive Items", objects: expensiveItemsArray)
        let cheapItems = Section(title: "Cheap Items", objects: cheapItemsArray)
        
        sectionsArray.append(expensiveItems)
        sectionsArray.append(cheapItems)
        
        return sectionsArray
    }
}
