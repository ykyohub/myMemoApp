//
//  AddViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var addViewTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        list.append(Todo(title: addViewTextField.text!, iscompleted: false))
        addViewTextField.text = ""
    }
    
}
