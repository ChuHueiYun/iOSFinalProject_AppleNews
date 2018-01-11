//
//  MyCollectionDetailViewController.swift
//  iOSFinalProject_AppleNews
//
//  Created by user_02 on 2017/12/29.
//  Copyright © 2017年 wendy. All rights reserved.
//

import UIKit

class MyCollectionDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var NewsTitle = ""
    var NewsLink = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destination is MyCollectionNoteViewController {
            let controller = segue.destination as? MyCollectionNoteViewController
            controller?.NewsTitle = self.NewsTitle
            controller?.NewsLink = self.NewsTitle
        }
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
