//
//  ApiConfig.swift
//  MujigaeIrfanAdika
//
//  Created by PACTINDO on 27/06/19.
//  Copyright © 2019 PACTINDO. All rights reserved.
//

import Foundation

protocol ApiConfig: class {
    func itemsDownloaded(items: NSArray)
}


class Api: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: ApiConfig!
    
    let urlPath = "https://cloudirfan.000webhostapp.com/food/getfood.php"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }else {
                print("menu downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
}

    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let menus = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let menu = Menu()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["food_name"] as? String
                
            {
//                print(name)
                menu.name = name
                
                
            }
            
            menus.add(menu)
            print(menus)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: menus)
            
        })
    }
}
