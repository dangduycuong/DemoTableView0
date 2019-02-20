//
//  DetailViewController.swift
//  DemoTableView
//
//  Created by duycuong on 2/20/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTextField: UITextField!
    var detailData: String?
    
    override func viewDidLoad() {
        
        if detailData != nil {
            detailTextField.text = detailData
        }
        
        super.viewDidLoad()
        
       

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        detailData = detailTextField.text
    }
    


}
