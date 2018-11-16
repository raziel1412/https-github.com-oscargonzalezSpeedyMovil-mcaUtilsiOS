//
//  CardDetailDataTableCell.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 02/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardDetailDataTableCell: UITableViewCell {
    @IBOutlet weak var lblNameService: UILabel!
    @IBOutlet weak var lblConsumingData: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
