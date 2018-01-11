//
//  MediumTableViewController.swift
//  iOSFinalProject_AppleNews
//
//  Created by user_02 on 2017/12/28.
//  Copyright © 2017年 wendy. All rights reserved.
//

import UIKit

class MediumTableViewController: UITableViewController, XMLParserDelegate {

    class NewsItem {
        var title = ""
        var link = ""
    }
    
    var urlString1 = "https://medium.com/feed/@apppeterpan"
    var urlString2 = "https://medium.com/feed/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86"
    var xmlParser = XMLParser()
    var foundCharacters = ""
    var itemCount = 0
    var newsItem:[NewsItem] = []
    var tempNewsItem = NewsItem()
    var newsTotal = 20
    
    var sections = ["彼得潘的 Swift iOS App 開發問題解答集", "彼得潘的 iOS App Neverland"]
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //print("in parser 1")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters += string;
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            let str = self.foundCharacters
            let str2 = str.replacingOccurrences(of: "            ", with: "")
            let str3 = str2.replacingOccurrences(of: "\n", with: "")
            let start = str3.index(str3.startIndex, offsetBy: 8)
            let end = str3.index(str3.endIndex, offsetBy: 0)
            let range = start..<end
            let str4 = str3[range]
            let str5 = String(str4)
            self.tempNewsItem.title = str5
            //print("title: " + self.foundCharacters)
        }
        if elementName == "link" {
            let str = self.foundCharacters
            let str2 = str.replacingOccurrences(of: " ", with: "")
            let str3 = str2.replacingOccurrences(of: "\n", with: "")
            self.tempNewsItem.link = str3
            //print("link: " + self.foundCharacters)
        }
        if elementName == "item" {
            let temp = NewsItem()
            temp.title = self.tempNewsItem.title
            temp.link = self.tempNewsItem.link
            self.newsItem.append(temp)
            //print(self.itemCount)
            self.itemCount += 1
            self.tempNewsItem.title = ""
            self.tempNewsItem.link = ""
        }
        self.foundCharacters = ""
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        //print("in parserDidEndDocument")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destination is MediumDetailViewController {
            let controller = segue.destination as? MediumDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller?.NewsTitle = self.newsItem[indexPath!.section * 10 + indexPath!.row].title
            controller?.NewsLink = self.newsItem[indexPath!.section * 10 + indexPath!.row].link
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url2 = URL(string: self.urlString2)
        self.xmlParser = XMLParser(contentsOf: url2!)!
        self.xmlParser.delegate = self
        self.xmlParser.parse()
        
        let url1 = URL(string: self.urlString1)
        self.xmlParser = XMLParser(contentsOf: url1!)!
        self.xmlParser.delegate = self
        self.xmlParser.parse()
        //print("after self.xmlParser.parse()")
        
        /*for (index, element) in self.newsItem.enumerated() {
            print(index)
            print(element.title)
            print(element.link)
            if index == self.newsTotal {
                break
            }
        }*/
        
        self.refreshControl?.addTarget(self, action: #selector(AppleNewsroomTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        self.refreshControl?.tintColor = UIColor.gray
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //print("Refresh!")
        //self.newsItem.removeAll()
        self.xmlParser.delegate = self
        self.xmlParser.parse()
        
        /*let temp = NewsItem()
         temp.title = "self.tempNewsItem.title"
         temp.link = "self.tempNewsItem.link"
         self.newsItem.insert(temp, at: 0)*/
        /*for (index, element) in self.newsItem.enumerated() {
         print(index)
         print(element.title)
         print(element.link)
         }*/
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        // #warning Incomplete implementation, return the number of sections
        return sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsTotal / sections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediumCell", for: indexPath)
        cell.textLabel?.text = self.newsItem[indexPath.section * 10 + indexPath.row].title
        return cell
    }

    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.viewDidAppear(true)
        self.tableView.reloadData()
    }*/

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
