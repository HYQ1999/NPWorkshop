//
//  tianxieViewController.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/20.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class tianxieViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    

//    @IBOutlet weak var baoxiuid: UILabel!
//    @IBOutlet weak var shebeiname: UILabel!
//    @IBOutlet weak var zichanxuhao: UILabel!
//    @IBOutlet weak var xinghaocanshu: UILabel!
//    @IBOutlet weak var baoxiuzhuangtai: UILabel!
//    @IBOutlet weak var guzhangxianxiang: UITextView!
//    @IBOutlet weak var guzhangyuanyin: UITextView!
//    @IBOutlet weak var baoxiuren: UILabel!
//    @IBOutlet weak var baoxiubumen: UILabel!
//    @IBOutlet weak var lianxifangshi: UILabel!
//    @IBOutlet weak var jiexiuren: UILabel!
//    @IBOutlet weak var weixiuren: UILabel!
//    @IBOutlet weak var peijianshengouyuan: UILabel!
//    @IBOutlet weak var rengongfei: UILabel!
//    @IBOutlet weak var weixiujine: UILabel!
//    @IBOutlet weak var baoxiushijian: UILabel!
//    @IBOutlet weak var wanxiushijian: UILabel!
//    @IBOutlet weak var peijiantableview: UITableView!
    
    @IBOutlet weak var baoxiudanID: UILabel!
    @IBOutlet weak var shebeiName: UILabel!
    @IBOutlet weak var zichanID: UILabel!
    @IBOutlet weak var xinghaoSander: UILabel!
    @IBOutlet weak var guzhangSee: UITextView!
    @IBOutlet weak var baoxiuState: UILabel!
    @IBOutlet weak var baoxiuMan: UILabel!
    @IBOutlet weak var baoxiuMent: UILabel!
    @IBOutlet weak var styleContant: UILabel!
    @IBOutlet weak var jiexiuMan: UILabel!
    @IBOutlet weak var baoxiuTime: UILabel!
    @IBOutlet weak var guzhangReason: UITextView!
    @IBOutlet weak var rengongMoney: UITextField!
    @IBOutlet weak var peijianSelect: UIButton!
    @IBOutlet weak var chose1: UIButton!
    @IBOutlet weak var chose2: UIButton!
    @IBOutlet weak var xianLast: UIImageView!
    @IBOutlet weak var xianLast2: UIImageView!

    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var weixiuPeijian: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chose1.setImage(UIImage.init(named: "未单选"), for: .normal)
        chose2.setImage(UIImage.init(named: "单选"), for: .normal)
        xianLast.isHidden = true
        xianLast2.isHidden = true
        
        selectLabel.isHidden = true
        peijianSelect.isHidden = true
        weixiuPeijian.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveWeixiu(_ sender: Any) {
    }
    @IBAction func peijianChose(_ sender: Any) {
    }
    @IBAction func xuanzeOne(_ sender: Any) {
        chose1.setImage(UIImage.init(named: "未单选"), for: .normal)
        chose2.setImage(UIImage.init(named: "单选"), for: .normal)
        xianLast.isHidden = true
        xianLast2.isHidden = true
        
        selectLabel.isHidden = true
        peijianSelect.isHidden = true
        weixiuPeijian.isHidden = true
        
    }
    @IBAction func xuanzeTwo(_ sender: Any) {
        chose1.setImage(UIImage.init(named: "单选"), for: .normal)
        chose2.setImage(UIImage.init(named: "未单选"), for: .normal)
        xianLast.isHidden = false
        xianLast2.isHidden = false
       
        selectLabel.isHidden = false
        peijianSelect.isHidden = false
        weixiuPeijian.isHidden = false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        peijianuselist.loadData()
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tianxiePiejianCell", for: indexPath) as! tianxiePeiJianTableViewCell
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
