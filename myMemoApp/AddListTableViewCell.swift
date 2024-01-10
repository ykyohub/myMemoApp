//
//  AddListTableViewCell.swift
//  myMemoApp
//
//  Created by 윤규호 on 1/10/24.
//

import Foundation
import UIKit

class AddListTableViewCell: UITableViewCell, UITableViewDelegate {
    
    var addTitleClosure: ((_ title: String) -> ())?
    var addContentClosure: ((_ title: String) -> ())?
    
    @IBAction func titleTextField(_ sender: UITextField) {
        addTitleClosure?(sender.text!)
    }
    
    @IBAction func contentTextField(_ sender: UITextField) {
        addContentClosure?(sender.text!)
    }
    
}
