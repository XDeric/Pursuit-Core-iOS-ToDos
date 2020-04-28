//
//  addTaskVC.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/26/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit

class addTaskVC: UIViewController {
    
    var searchString = ""{
        didSet{
            do{
                try OutstandingHelper.manager.save(newFavorite: Outstanding(name: searchString))
            }
            catch{
                print(error)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    lazy var searchText: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Type in a Task"
    tf.delegate = self
    tf.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    tf.layer.cornerRadius = 5
    tf.borderStyle = .roundedRect
    return tf
    }()
    
    func setUpConstraints(){
        searchText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchText)

        NSLayoutConstraint.activate([
            searchText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchText.widthAnchor.constraint(equalToConstant: 300),
            searchText.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
    }
    

}

extension addTaskVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchString = textField.text ?? ""
        return true
    }
}
