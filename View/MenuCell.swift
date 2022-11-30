//
//  MenuCell.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 24/02/2022.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var lineMenu: UIView!
    @IBOutlet weak var labelLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
