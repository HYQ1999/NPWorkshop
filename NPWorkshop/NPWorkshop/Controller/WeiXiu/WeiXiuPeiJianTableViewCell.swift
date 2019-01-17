//
//  WeiXiuPeiJianTableViewCell.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class WeiXiuPeiJianTableViewCell: UITableViewCell {

    @IBOutlet weak var peijianminchen: UILabel!
    @IBOutlet weak var peijianshuliang: UILabel!
    @IBOutlet weak var peijianleibie: UILabel!
    @IBOutlet weak var peijiandanjia: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
