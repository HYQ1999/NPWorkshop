//
//  WeiXiuTableViewCell.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/16.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit

class WeiXiuTableViewCell: UITableViewCell {
    @IBOutlet weak var weixiuzhuangtai: UILabel!
    @IBOutlet weak var weixiushebei: UILabel!
    @IBOutlet weak var weixiuren: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
