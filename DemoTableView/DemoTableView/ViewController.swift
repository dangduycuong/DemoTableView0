//
//  ViewController.swift
//  DemoTableView
//
//  Created by duycuong on 2/20/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: properties
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet var dataInt: DataInt!
    @IBOutlet var dataString: DataString!
    @IBOutlet var noDataView: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataView.frame = view.frame
        dataInt.delegateInt = self
        dataString.delegateString = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            if stateSwitch.isOn {
                detailVC?.detailData = String(dataInt.numbers[indexPath.row])
            } else {
                detailVC?.detailData = dataString.listNames[indexPath.row]
            }
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        let source = unwindSegue.source as? DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            if stateSwitch.isOn {
                dataInt.numbers[indexPath.row] = Int((source?.detailData)!) ?? 0
            } else {
                dataString.listNames[indexPath.row] = (source?.detailData)!
            }
        } else {
            stateSwitch.isOn ? (dataInt.numbers.append(Int((source?.detailData!)!) ?? 0)) : (dataString.listNames.append((source?.detailData)!))
        }
        
        
        
        tableView.reloadData()
    }
    
    
    //MARK: Actions
    @IBAction func switchData(_ sender: UISwitch) {
        if stateSwitch.isOn {
            tableView.dataSource = dataInt
        } else {
            tableView.dataSource = dataString
        }
        tableView.reloadData()
    }
    
    func showNoDataLabel(isShow: Bool) {
        if isShow {
            tableView.backgroundView = noDataView
        } else {
            tableView.backgroundView = nil
        }
    }

}


extension ViewController: UITableViewDelegate {
    
}

class DataInt: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var numbers = [Int](0...3)
    var delegateInt: ViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = String(numbers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            numbers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            delegateInt?.showNoDataLabel(isShow: numbers.count == 0)
        }
    }
    
}

class DataString: NSObject,UITableViewDelegate,  UITableViewDataSource {
    
    var listNames = ["Kien", "Cuong", "Duc Anh", "Dai", "Vu"]
    var delegateString: ViewController?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = listNames[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            delegateString?.showNoDataLabel(isShow: listNames.count == 0)
        }
    }
  
}

