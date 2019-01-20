//
//  tianxiePeiJianTableViewCell.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/20.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit

class tianxiePeiJianTableViewCell: UITableViewCell {

    @IBOutlet weak var peijianname: UILabel!
    @IBOutlet weak var peijianshuliang: UILabel!
    @IBOutlet weak var peijiandanjia: UILabel!
    @IBOutlet weak var peijiantotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
