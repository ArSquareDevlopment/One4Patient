//
//  MConditionTC.swift
//  One for Patient
//
//  Created by Idontknow on 01/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class MConditionTC: UITableViewCell {
    
    
    @IBOutlet weak var IDLbl: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var MConditionTypeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var InfoLbl: UILabel!
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var timeTypeLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
