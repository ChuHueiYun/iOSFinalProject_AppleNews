//
//  MediumDetailViewController.swift
//  iOSFinalProject_AppleNews
//
//  Created by user_02 on 2017/12/28.
//  Copyright © 2017年 wendy. All rights reserved.
//

import UIKit

class MediumDetailViewController: UIViewController {

    var allCollections = [Collection]()
    
    @IBOutlet weak var webView: UIWebView!
    
    var NewsTitle = ""
    var NewsLink = ""
    
    @IBAction func collect(_ sender: Any) {
        if let collections = Collection.readFromFile() {
            self.allCollections = collections
        }
        
        for element in self.allCollections {
            if self.NewsTitle == element.title {
                let alertController = UIAlertController(
                    title: "提醒",
                    message: "此文章已被收藏",
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(
                    title: "確認",
                    style: .default,
                    handler: {
                        (action: UIAlertAction!) -> Void in
                })
                alertController.addAction(okAction)
                self.present(
                    alertController,
                    animated: true,
                    completion: nil
                )
                return
            }
        }
        
        var tempCollection = Collection()
        tempCollection.title = self.NewsTitle
        tempCollection.link = self.NewsLink
        tempCollection.type = 1
        self.allCollections.append(tempCollection)
        Collection.saveToFile(collections: self.allCollections)
        
        /*print("in MediumDetailViewController")
         for element in self.allCollections {
         print(element.title)
         }*/
        
        let alertController = UIAlertController(
            title: "提醒",
            message: "收藏成功",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
        })
        alertController.addAction(okAction)
        self.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*print(NewsTitle)
        print(NewsLink)*/
        
        self.title = self.NewsTitle
        
        if let url = URL(string: NewsLink) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
