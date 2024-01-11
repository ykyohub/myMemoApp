//
//  AddViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

protocol AddProtocol {
    func addList(category: String, content: String)
}

class AddViewController: UIViewController {
    
    var delegate: AddProtocol?
    
    @IBOutlet weak var addCategoryTextField: UITextField!
    @IBOutlet weak var addContentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedAddButton(_ sender: UIButton) {
        guard let category = addCategoryTextField.text, let content = addContentTextField.text else { return }
        
        if category.isEmpty || content.isEmpty {
            // 빈 필드에 대한 경고 표시
            let alert = UIAlertController(title: "알림", message: "제목과 내용을 모두 입력해주십시오.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            // 두 필드가 모두 채워졌을 때 확인 대화상자 표시
            let alert = UIAlertController(title: "일정추가", message: "작성하신 내용을 추가하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .default) { _ in
                self.addCategoryTextField.text = ""
                self.addContentTextField.text = ""
            })
            alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in

                self.delegate?.addList(category: self.addCategoryTextField.text!, content: self.addContentTextField.text!)
                self.addCategoryTextField.text = ""
                self.addContentTextField.text = ""
            })
            //pop
            self.present(alert, animated: true, completion: nil)
        }
    }
}
