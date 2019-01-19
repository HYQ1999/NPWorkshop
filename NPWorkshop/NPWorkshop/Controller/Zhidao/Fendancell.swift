//
//  Fendancell.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/19.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class Fendancell: UITableViewCell {

    @IBOutlet weak var UserId: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userquanxian: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
