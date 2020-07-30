//
//  AddToDoViewController.swift
//  Test03
//
//  Created by Andrew Matula on 6/25/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var update: (() ->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func segValueOut(_ indexVal: String) -> String {
        var priority = ""
        switch indexVal {
        case "0":
            priority = "!"
        case "1":
            priority = "!!"
        default:
            priority = "!!!"
        }
        return priority
    }
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userPriority: UISegmentedControl!
    
    @IBAction func backToDo(_ sender: Any) {
        update?()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToDo(_ sender: Any) {
        if userInput.text != ""{
            let textUser = "\(userInput.text!)"
            let prioUser = "\(segValueOut( userPriority.selectedSegmentIndex.description))"
            userInput.text = ""
            addListItem(newMessage: textUser, newPriority: prioUser)
        }
    }
    
    func addListItem(newMessage:String, newPriority:String) {
        let newDataEntry = listDataJSON.init(message: newMessage, priority: newPriority)
        print(newDataEntry)
        listData.append(newDataEntry)
        updateJSONfile()
    }
    
    func updateJSONfile() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("dataJSON.json")
            let encodedData = try encoder.encode(listData)
            if FileManager.default.fileExists(atPath: fileURL.path) {
                print("file exists")
                try FileManager.default.removeItem(atPath: fileURL.path)
                FileManager.default.createFile(atPath: fileURL.path, contents: encodedData, attributes: nil )
            } else {
                FileManager.default.createFile(atPath: fileURL.path, contents: encodedData, attributes: nil )}
        } catch {
            print(error.localizedDescription)
        }
    }
}
