//
//  DaoHuoTableViewCell.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class DaoHuoTableViewCell: UITableViewCell {

    @IBOutlet weak var tongzhiren: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var shijian: UILabel!
    @IBOutlet weak var repairid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
