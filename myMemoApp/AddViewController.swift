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
            let alert = UIAlertController(title: "알림", message: "제목과 내용을 모두 입력해주십시오.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        //제목과 내용 둘 다 작성하고 Add 버튼 눌러야 list에 내용 추가
        else if addTitleTextField.text != "" && addContentTextField.text != ""{
            let alert = UIAlertController(title: "일정추가", message: "작성하신 내용을 추가하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .default){action in
                self.addTitleTextField.text = ""
                self.addContentTextField.text = ""
            })
            alert.addAction(UIAlertAction(title: "확인", style: .default){action in
                list.append(Todo(title: self.addTitleTextField.text!, todoContent: self.addContentTextField.text!, iscompleted: false))
                self.addTitleTextField.text = ""
                self.addContentTextField.text = ""
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
