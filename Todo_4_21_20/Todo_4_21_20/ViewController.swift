//
//  ViewController.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/21/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableview: UITableView = {
        let tv = UITableView()
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
}

