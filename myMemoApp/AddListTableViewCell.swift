//
//  AddListTableViewCell.swift
//  myMemoApp
//
//  Created by 윤규호 on 1/10/24.
//

import Foundation
import UIKit

class AddListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
