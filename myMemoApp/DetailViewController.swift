//
//  DetailViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

class DetailViewController: UIViewController {
    var receiveItem = ""
    
    @IBOutlet var detailViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewLabel.text = receiveItem
    }
    func receiveItem(_ item: String){
        receiveItem = item
    }
}
