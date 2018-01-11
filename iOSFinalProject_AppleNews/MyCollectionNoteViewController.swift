//
//  MyCollectionNoteViewController.swift
//  iOSFinalProject_AppleNews
//
//  Created by user_02 on 2017/12/29.
//  Copyright © 2017年 wendy. All rights reserved.
//

import UIKit

class MyCollectionNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var allCollections = [Collection]()
    
    var NewsTitle = ""
    var NewsLink = ""
    
    @IBOutlet weak var NoteTitle: UILabel!
    
    @IBOutlet weak var NoteComment: UITextView!
    
    @IBOutlet weak var photo: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        photo.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        for (index, element) in self.allCollections.enumerated()  {
            if element.title == self.NewsTitle {
                self.allCollections[index].comment = self.NoteComment.text
                
                var imageName: String?
                imageName = "\(Date().timeIntervalSinceReferenceDate)"
                let url = Collection.documentsDirectory?.appendingPathComponent(imageName!)
                let data = UIImageJPEGRepresentation(self.photo.image!, 0.8)
                try? data?.write(to: url!)
                self.allCollections[index].imageName = imageName
            }
        }
        Collection.saveToFile(collections: self.allCollections)
        
        for element in self.allCollections {
            if self.NewsTitle == element.title {
                let alertController = UIAlertController(
                    title: "提醒",
                    message: "儲存成功",
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NoteComment.layer.borderColor =  UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        
        /*print(NewsTitle)
         print(NewsLink)*/
        
        self.title = self.NewsTitle
        
        //print("in MyCollectionNoteViewController")
        
        if let collections = Collection.readFromFile() {
            self.allCollections = collections
        }
        /*for (index, element) in self.allCollections.enumerated()  {
             print(index)
             print(element.title)
         }*/
        
        self.NoteTitle.text = self.NewsTitle
        
        for (index, element) in self.allCollections.enumerated()  {
            if element.title == self.NewsTitle {
                self.NoteComment.text = self.allCollections[index].comment
                self.photo?.image = self.allCollections[index].image
            }
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
