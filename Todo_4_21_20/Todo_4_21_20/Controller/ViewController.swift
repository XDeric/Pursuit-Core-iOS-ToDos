//
//  ViewController.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/21/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var outTask = [OutstandingTask](){
        didSet{
            tableview.reloadData()
        }
    }
    var compTask = [CompletedTask](){
        didSet{
            tableview.reloadData()
        }
    }
    
    lazy var add: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(systemName: "plus"), for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    lazy var tableview: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.register(TableViewCell.self, forCellReuseIdentifier: "cellList")
        return tv
    }()
    
    @objc func addPressed(){
        let addVC = addTaskVC()
        present(addVC, animated: true, completion: nil)
    }
    
    func getOutData(){
        outTask = PersistanceHelper.shared.fetchData(OutstandingTask.self)
    }
    
    func getCompData(){
        compTask = PersistanceHelper.shared.fetchData(CompletedTask.self)
    }
    
    
    func setUp(){
        tableview.translatesAutoresizingMaskIntoConstraints = false
        add.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(add)
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            
            add.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            add.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            add.widthAnchor.constraint(equalToConstant: 50),
            add.heightAnchor.constraint(equalToConstant: 20),
            
            tableview.topAnchor.constraint(equalTo: add.bottomAnchor),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    
    
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getOutData()
        getCompData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }


}




//MARK: Extensions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return outTask.count
        case 1:
            return compTask.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        switch indexPath.section {
        case 0:
            cell.title.text = outTask[indexPath.row].name
        case 1:
            cell.title.text = compTask[indexPath.row].name
        default:
            cell.title.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Outstanding Task"
        case 1:
            return "Completed Task"
        default:
            return ""
        }
    }
    
    
    
}

