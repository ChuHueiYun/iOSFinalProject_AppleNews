//
//  Collection.swift
//  iOSFinalProject_AppleNews
//
//  Created by user_02 on 2017/12/29.
//  Copyright © 2017年 wendy. All rights reserved.
//

import Foundation
import UIKit

struct Collection: Codable {
    var title = ""
    var link = ""
    var type = -1
    var comment = "目前尚無筆記"
    var date = ""
    var imageName: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    static func saveToFile(collections: [Collection]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(collections) {
            let url = documentsDirectory?.appendingPathComponent("collections.txt")
            try? data.write(to: url!)
        }
    }
    
    static func readFromFile() -> [Collection]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Collection.documentsDirectory?.appendingPathComponent("collections.txt")
        if let data = try? Data(contentsOf: url!), let collections = try? propertyDecoder.decode([Collection].self, from: data) {
            return collections
        } else {
            return nil
        }
    }
    
    var image: UIImage? {
        if let imageName = imageName {
            let url = Collection.documentsDirectory?.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: (url?.path)!)
        } else {
            return  #imageLiteral(resourceName: "white_image")
        }
    }
}
