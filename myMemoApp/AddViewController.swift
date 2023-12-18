//
//  AddViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var addTitleTextField: UITextField!
    @IBOutlet weak var addContentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        if addTitleTextField.text == "" || addContentTextField.text == ""{
            // 제목과 내용중 한개라도 빈칸이면 Alert 메세지 띄움
            
        }
        //제목과 내용 둘 다 작성하고 Add 버튼 눌러야 list에 내용 추가
        else if addTitleTextField.text != "" && addContentTextField.text != ""{
            list.append(Todo(title: addTitleTextField.text!, todoContent: addContentTextField.text!, iscompleted: false))
            addTitleTextField.text = ""
            addContentTextField.text = ""
        }
    }
    
}
