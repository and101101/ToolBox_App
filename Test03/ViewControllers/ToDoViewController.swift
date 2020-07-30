//
//  ToDoViewController.swift
//  Test03
//
//  Created by Andrew Matula on 6/25/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import Foundation
import UIKit

struct listDataJSON: Codable {
    var message: String
    var priority: String
}

var listData = [listDataJSON]()

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initJSON()
        loadJSON()
        
        let nib = UINib(nibName: "AlphaTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AlphaTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(listData.count)")
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ToDoCell = tableView.dequeueReusableCell(withIdentifier: "AlphaTableViewCell", for: indexPath) as! AlphaTableViewCell
    
        ToDoCell.myLabel.text = listData[indexPath.row].message
        ToDoCell.priority.text = listData[indexPath.row].priority
        return ToDoCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            deleteListItem(itemIndex: indexPath.row)
            tableView.reloadData()
        }
    }
    func initJSON () {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let initData = [listDataJSON(message: "loaded from documents" , priority: "!!!")]
        do {
            let encodedData = try! encoder.encode(initData)
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("dataJSON.json")
            let fileExists = FileManager.default.fileExists(atPath: fileURL.path)
            print(fileURL.path)
            if fileExists {
                print("file exists")
            } else {
                try encodedData.write(to: fileURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadJSON() {
        let decoder = JSONDecoder()
        do{
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("dataJSON.json")
            let data = try Data(contentsOf: fileURL)
            print(data)
            let decodedData = try decoder.decode([listDataJSON].self, from: data)
            listData = decodedData
        } catch {
            print(error.localizedDescription)
            }
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

    
    func deleteListItem(itemIndex:Int){
        if itemIndex < listData.count {
            listData.remove(at: itemIndex)
        }
        updateJSONfile()
    }
    
    @IBAction func addItem(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddToDoViewController") as? AddToDoViewController {
            vc.update = {
                DispatchQueue.main.async {
                    self.loadJSON()
                    self.tableView.reloadData()
                }
            }
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapDismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
