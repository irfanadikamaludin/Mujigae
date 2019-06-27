//
//  ViewController.swift
//  MujigaeIrfanAdika
//
//  Created by PACTINDO on 27/06/19.
//  Copyright © 2019 PACTINDO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ApiConfig, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
     let TAGS = ["Topokki", "Sundubu", "Galbitang", "Beef BBQ", "Korean Fried Chicken", "Bingsoo", "Dakgalbi", "Ramyun", "Bulgogi", "Anyeong Se 1", "Nori", "Mandu", "Kimchi", "Beef", "Anyeong Set 2", "Choko Bingsoo", "Bokumbap", "Bulgogi Bibimbowl", "Classic Bingsoo", "Matcha", "Japchae", "Yoghurt Bingsoo", "Korean Lemonade", "Matha Milk Tea", "Choco Banan Milk", "Jeju Orange Tea", "Apple Tea", "Mineral Water", "Tea"]
    
    var menuItems: NSArray = NSArray()
    var selectMenu: Menu = Menu()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var flowLayout: FlowLayout!
    
    var sizingCell: TagCell?
    
    var tags = [Tag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getMenu = Api()
        getMenu.delegate = self
        getMenu.downloadItems()
        // Do any additional setup after loading the view.
        
        let cellNib = UINib(nibName: "TagCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "TagCell")
        self.collectionView.backgroundColor = UIColor.clear
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCell?
        self.flowLayout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        for name in TAGS {
            let tag = Tag()
            tag.name = name
            self.tags.append(tag)
        }
    }
    
    func itemsDownloaded(items: NSArray) {
        menuItems = items
        print(menuItems)
        
//        for menuss in items {
//            let tag = Tag()
//            tag.name = String[(menuss)]
//            self.tags.append(tag)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        self.configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.sizingCell?.setMaximumCellWidth(collectionView.frame.width)
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        tags[indexPath.row].selected = !tags[indexPath.row].selected
        self.collectionView.reloadData()
    }
    
    func configureCell(_ cell: TagCell, forIndexPath indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        cell.tagName.text = tag.name
        cell.tagName.textColor = tag.selected ? UIColor.white : UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        cell.backgroundColor = tag.selected ? UIColor(red: 0.9216, green: 0.6314, blue: 0.6314, alpha: 1.0): UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        //        cell.btnTag.setTitle(tag.name, for: UIControl.State.normal)
        //        cell.btnTag.textColor = tag.selected ? UIColor.white : UIColor(red: 235, green: 161, blue: 161, alpha: 1)
        //        cell.backgroundColor = tag.selected ? UIColor(red: 0, green: 1, blue: 0, alpha: 1) : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        //        cell.layer.cornerRadius = 20
        //        cell.layer.borderWidth = 1
        //        cell.layer.borderColor = UIColor(red: 235, green: 161, blue: 161, alpha: 1).cgColor
        //        cell.backgroundColor = tag.selected ? UIColor(red: 0, green: 1, blue: 0, alpha: 1) : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
