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
    
     var peijianuselist = PeiJianUserModel()
    var detaillist = DetailModel()
    var repairid : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        chose1.setImage(UIImage.init(named: "未单选"), for: .normal)
        chose2.setImage(UIImage.init(named: "单选"), for: .normal)
        xianLast.isHidden = true
        xianLast2.isHidden = true
        
        selectLabel.isHidden = true
        peijianSelect.isHidden = true
        weixiuPeijian.isHidden = true
        guzhangSee.isEditable = false
        self.guzhangSee.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangSee.layer.borderWidth = 2
        
        self.guzhangSee.layer.cornerRadius = 16
        self.guzhangReason.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangReason.layer.borderWidth = 2
        
        self.guzhangReason.layer.cornerRadius = 16
      
        weixiuPeijian.dataSource = self
        weixiuPeijian.delegate = self

        let parameters :[String : Any] = [
            "RepairID": String(repairid)//左边是接口
        ]
        
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepDetail", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    self.detaillist.loadData()
                    self.detaillist.detail.removeAll()
                    self.detaillist.saveData()
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["rep_list"] as?[[String: AnyObject]]{
                        for i in repvm
                        {
                            print(i)
                        }
                        self.detaillist.detail.append(DetailList(Appearance: (repvm[0]["Appearance"] as? String ?? "")! , ApplyUser: (repvm[0]["ApplyUser"] as? String ?? "")!, AssetsNumber: (repvm[0]["AssetsNumber"] as? String ?? "")!, BXUser: (repvm[0]["BXUser"] as? String ?? "")!, CancelReason: (repvm[0]["CancelReason"] as? String ?? "")!, DeptName: (repvm[0]["DeptName"] as? String ?? "")!, EqptName: (repvm[0]["EqptName"] as? String ?? "")!, FinishTime: (repvm[0]["FinishTime"] as? String ?? "")!, Laborcost: ((repvm[0]["Laborcost"] as? NSNumber)?.stringValue ?? "")!, Parameter: (repvm[0]["Parameter"] as? String ?? "")!, Reason: (repvm[0]["Reason"] as? String ?? "")!, RepairID: (repvm[0]["RepairID"] as? String ?? "")!, RepairState: (repvm[0]["RepairState"] as? String ?? "")!, RepairTime: (repvm[0]["RepairTime"] as? String ?? "")!, RepairUser: (repvm[0]["RepairUser"] as? String ?? "")!, Telphone: (repvm[0]["Telphone"] as? String ?? "")!, Total: ((repvm[0]["Total"] as? NSNumber)?.stringValue ?? "")!, Accepter: (repvm[0]["Accepter"] as? String ?? "")!))
                        self.detaillist.saveData()
                        
                        
                    }
                    self.xianshi()
                    
                    
                }
                catch{}
                
                
            }
            else
            {
                
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        weixiuPeijian.dataSource = self
        weixiuPeijian.delegate = self
        weixiuPeijian.reloadData()

    }
    
    @IBAction func viewclick(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func returnback(_ sender: Any) {
        rengongMoney.resignFirstResponder()
    }
    func xianshi()
    {
        detaillist.loadData()
        baoxiudanID.text = detaillist.detail[0].RepairID
        shebeiName.text =  detaillist.detail[0].EqptName
        zichanID.text = detaillist.detail[0].AssetsNumber
        xinghaoSander.text = detaillist.detail[0].Parameter
        baoxiuState.text = detaillist.detail[0].RepairState
        if detaillist.detail[0].Appearance == ""
        {
            guzhangSee.text = "无"
        }
        else
        {
            if detaillist.detail[0].Appearance.contains("<p>")
            {
                let index1 = detaillist.detail[0].Appearance.index(detaillist.detail[0].Appearance.startIndex, offsetBy: 3)
                let index2 = detaillist.detail[0].Appearance.index(detaillist.detail[0].Appearance.endIndex, offsetBy: -4)
                guzhangSee.text = String(detaillist.detail[0].Appearance[index1 ..< index2])
            }
            else
            {
                guzhangSee.text = detaillist.detail[0].Appearance
            }
        }
        
        baoxiuMan.text = detaillist.detail[0].BXUser
        baoxiuMent.text = detaillist.detail[0].DeptName
        styleContant.text = detaillist.detail[0].Telphone
        jiexiuMan.text = detaillist.detail[0].Accepter
        baoxiuTime.text = detaillist.detail[0].RepairTime
        
    }
    
    
    
    @IBAction func saveWeixiu(_ sender: Any) {
          peijianuselist.loadData()
        if rengongMoney.text == ""
        {
            let alerttController = UIAlertController(title: "Error！", message: "请填写人工费！", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
            return
        }
        if guzhangReason.text == ""
        {
            
            let alerttController = UIAlertController(title: "Error！", message: "请填写故障原因！", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
            return
        }
        let expression2 = "[0-9]{1,1000}"
        let regex2 = try! NSRegularExpression.init(pattern: expression2, options: .allowCommentsAndWhitespace)
        let numberOfMatches2 = regex2.numberOfMatches(in: rengongMoney.text!, options: .reportProgress, range: NSMakeRange(0, (rengongMoney.text! as NSString).length))
        if numberOfMatches2 == 0
        {
            let alerttController = UIAlertController(title: "Error！", message: "人工费填写错误！", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
            return
        }
        else
        {
            if selectLabel.isHidden == true
            {
                let requesting : Models_QiXiu.Requesting = Models_QiXiu.Requesting(type:"弃修" ,RenGonfei: rengongMoney.text!, QiXiuReason: guzhangReason.text!, RepairId: baoxiudanID.text!)
                QiXiuReposity().QiXiu(requesting: requesting) { (response, error) in
                    if error == nil, let response = response{
                        let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                        let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: {
                            action in
                            let destinationStoryboard = UIStoryboard(name:"WeiXiu",bundle:nil)
                            let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: SWRevealViewController())))
                                as! SWRevealViewController
                            self.present(controller, animated: true, completion: nil)
                        })
                        alerttController.addAction(okkAction)
                        self.present( alerttController, animated:  true, completion: nil)
                        return
                        
                    }
                }
            }
            else
            {
             
                if peijianuselist.pjuselist.isEmpty
                {
                    
                    let alerttController = UIAlertController(title: "Error！", message: "请选择配件！", preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                    return
                }
                else
                {
                let requesting : Models_QiXiu.Requesting = Models_QiXiu.Requesting(type:"完修" ,RenGonfei: rengongMoney.text!, QiXiuReason: guzhangReason.text!, RepairId: baoxiudanID.text!)
                QiXiuReposity().QiXiu(requesting: requesting) { (response, error) in
                    if error == nil, let response = response{
                        let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                        let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: {
                            action in
                            let destinationStoryboard = UIStoryboard(name:"WeiXiu",bundle:nil)
                            let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: SWRevealViewController())))
                                as! SWRevealViewController
                            self.present(controller, animated: true, completion: nil)
                        })
                        alerttController.addAction(okkAction)
                        self.present( alerttController, animated:  true, completion: nil)
                        return
                        
                    }
                }
                }
                
                
            }
            
            
        }
        
        
    }
    @IBAction func peijianChose(_ sender: Any) {
        let destinationStoryboard = UIStoryboard(name:"WeiXiu",bundle:nil)
        let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: PeiJianSearchTableViewController())))
            as! PeiJianSearchTableViewController
        controller.repairid = String(repairid)
        self.navigationController?.pushViewController(controller, animated: true)
        return
        
        
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
        peijianuselist.loadData()
        return peijianuselist.pjuselist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         peijianuselist.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "tianxiePiejianCell", for: indexPath) as! tianxiePeiJianTableViewCell
        cell.peijiandanjia.text = "单价:" + peijianuselist.pjuselist[indexPath.row].peijianmoney
        cell.peijianname.text = peijianuselist.pjuselist[indexPath.row].peijianminchen
        cell.peijianshuliang.text = "数量:" + peijianuselist.pjuselist[indexPath.row].peijiannum
        cell.peijiantotal.text = "小计:" + peijianuselist.pjuselist[indexPath.row].peijiantotal
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
