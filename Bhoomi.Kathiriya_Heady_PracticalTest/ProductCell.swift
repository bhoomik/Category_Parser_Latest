//
//  ProductCellTableViewCell.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell
{
    @IBOutlet weak var lblTitle : UILabel?
    @IBOutlet weak var lblDateAdded : UILabel?
    @IBOutlet weak var lblTax : UILabel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
