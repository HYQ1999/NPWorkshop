//
//  BaoxiuSearchTableViewCell.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class BaoxiuSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var baoxiuid: UILabel!
    @IBOutlet weak var shebeimin: UILabel!
    @IBOutlet weak var baoxiustate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
