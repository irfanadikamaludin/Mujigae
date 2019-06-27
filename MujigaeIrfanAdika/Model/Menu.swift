//
//  Menu.swift
//  MujigaeIrfanAdika
//
//  Created by PACTINDO on 27/06/19.
//  Copyright © 2019 PACTINDO. All rights reserved.
//

import Foundation

class Menu: NSObject {
    
    //properties of a name
    
    var name: String?
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name and @price parameters
    
    init(name: String) {
        
        self.name = name
        
    }
    
    
    //prints a stock's name and price
    
    override var description: String {
        return (String(describing: name))
        
    }
    
}
