//
//  DetailViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

protocol EditProtocol {
    func editList(category: String, content: String)
}

class DetailViewController: UIViewController, EditProtocol {
    func editList(category: String, content: String) {
        
    }
    
    
    var delegate: EditProtocol?
    var receiveItem = ""
    var receiveContent = ""
    
    @IBOutlet weak var detailViewLabel: UILabel!
    @IBOutlet weak var detailTodoContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewLabel.text = receiveItem
        detailViewLabel.sizeToFit() //텍스트 사이즈에 맞춰서 Label 크기 맞춤
        detailTodoContent.text = receiveContent
        detailTodoContent.sizeToFit()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(DetailViewController.editButton))
    }
    
    func receiveItem(_ category: String, _ content: String){
        receiveItem = category
        receiveContent = content
    }
    
    @objc func editButton() {
        print("hi")
        let alertController = UIAlertController(title: "수정하기", message: "수정할 내용을 입력해주세요.", preferredStyle: .alert)
            
        alertController.addTextField { textField in
            textField.placeholder = "\(self.detailViewLabel.text ?? "")"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "\(self.detailTodoContent.text ?? "")"
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let categoryEditedText = alertController.textFields?[0].text, 
               let todoContentEditedText = alertController.textFields?[1].text {
                
                self.delegate?.editList(category: categoryEditedText, content: todoContentEditedText)
                
                print("첫 번째 텍스트: \(categoryEditedText)")
                print("두 번째 텍스트: \(todoContentEditedText)")
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
