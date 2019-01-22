//
//  WodePeiJianShenGouTableViewCell.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class WodePeiJianShenGouTableViewCell: UITableViewCell {

    @IBOutlet weak var shenbaobianhao: UILabel!
    @IBOutlet weak var shenbaoren: UILabel!
    @IBOutlet weak var peijianname: UILabel!
    @IBOutlet weak var shengouzhuangtai: UILabel!
    @IBOutlet weak var shengoushuliang: UILabel!
    @IBOutlet weak var shengoutime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
