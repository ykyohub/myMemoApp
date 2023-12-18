//
//  DetailViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

class DetailViewController: UIViewController {
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
    }
    func receiveItem(_ title: String, _ content: String){
        receiveItem = title
        receiveContent = content
    }
}
