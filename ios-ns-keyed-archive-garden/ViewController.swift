//
//  ViewController.swift
//  ios-ns-keyed-archive-garden
//
//  Created by Kahne Raja on 3/31/17.
//  Copyright © 2017 Kahne Raja. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let myItemKey = "myItem"
    var myItemKeyValue: String?
    @IBOutlet weak var UITextField1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    @IBAction func Save(_ sender: Any) {
        self.saveData(value: UITextField1.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadData(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as? String
        let path = documentDirectory?.appending("MyData")
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: path!)){
            if let bundlePath = Bundle.main.path(forResource: "MyData", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                let bundleDescription = result?.description ?? ""
                print("Bundle file MyData.plist is -> \(bundleDescription)")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path!)
                } catch {
                    print("copy fail")
                }
            } else {
                print("file MyData.plist not found.")
            }
        } else {
            print("file MyData.plist already exists at path.")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path!)
        let loadDescription = resultDictionary?.description ?? ""
        print("load MyData.plist is -> \(loadDescription)")
        
        let myDict = NSDictionary(contentsOfFile: path!)
        if let dict = myDict {
            myItemKeyValue = dict.object(forKey: myItemKey) as! String?
            UITextField1 .text = myItemKeyValue
        } else {
            print("load failure.")
        }
    }
    
    func saveData(value: String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as? String
        let path = documentDirectory?.appending("MyData")
        let dict: NSMutableDictionary = [:]
        dict.setObject(value, forKey: myItemKey as NSCopying)
        dict.write(toFile: path!, atomically: false)
        print("saved \(value)")
    }

}

