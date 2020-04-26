//
//  TableViewCell.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/26/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    lazy var title: UILabel = {
        let txt = UILabel()
        txt.font = UIFont.systemFont(ofSize: 20)
        txt.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        txt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        txt.numberOfLines = 0
        return txt
    }()
    
    func setupCell(){
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }


    
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

}
