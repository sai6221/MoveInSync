//
//  TableViewCell.swift
//  MoveInSync
//
//  Created by Sai Reddy on 25/08/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var employeeBubble: UIView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        random()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
