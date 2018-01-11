//
//  MyCollectionTableViewController.swift
//  iOSFinalProject_AppleNews
//
//  Created by user_02 on 2017/12/29.
//  Copyright © 2017年 wendy. All rights reserved.
//

import UIKit

class MyCollectionTableViewController: UITableViewController {

    var allCollections = [Collection]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destination is MyCollectionDetailViewController {
            let controller = segue.destination as? MyCollectionDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller?.NewsTitle = self.allCollections[indexPath!.row].title
            controller?.NewsLink = self.allCollections[indexPath!.row].link
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("in MyCollectionTableViewController")
        if let collections = Collection.readFromFile() {
            self.allCollections = collections
        }
        /*for (index, element) in self.allCollections.enumerated()  {
            print(index)
            print(element.title)
        }*/
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allCollections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCollectionCell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = self.allCollections[indexPath.row].title
        return cell
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.allCollections.remove(at: indexPath.row)
        Collection.saveToFile(collections: self.allCollections)
        if let collections = Collection.readFromFile() {
            self.allCollections = collections
        }
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
