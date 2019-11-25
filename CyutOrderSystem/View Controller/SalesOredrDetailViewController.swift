//
//  SalesOredrDetailViewController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/18.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SalesOredrDetailViewController: UIViewController {
    
    var header = orderheader()
    
    var workitem : [workorderitem] = []
    
    
    @IBOutlet weak var orderNoLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workorder()

        view_text()
        self.tbView.layer.masksToBounds = true
        self.tbView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func view_text() {
        
        //表頭格式
        let date = header.orderTime!.prefix(10)
        orderNoLabel.text = "\(header.orderNo!)"
        datetimeLabel.text = "\(date)"
        userLabel.text = "\(header.customerName!)"
        emailLabel.text = "\(header.email!)"
        totalLabel.text = "NT$ \(header.totalPrice!)"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tbView.reloadData()
    }
    
    func workorder() {
        for i in 0..<(header.workorderno.count){
            AF.request("http://163.17.9.46:8181/improject/rest/orders/wo/\(self.header.orderNo!)0"+"\(i+1)",method: .get).validate().responseJSON(){
                response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    for i in 0..<(json["lines"].count){
                        let item = workorderitem(name: json["lines"][i]["item"]["name"].stringValue, quantity: json["lines"][i]["quantity"].intValue, price: json["lines"][i]["item"]["price"].intValue, state: json["state"].stringValue)
                        self.workitem.append(item)
                    }
                    self.tbView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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

extension SalesOredrDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workitem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! OrderItemCell
        
        
        let workline = workitem[indexPath.row]
        cell.mealNameLabel.text = workline.name
        cell.mealquantity.text = "x\(String(workline.quantity))"
        cell.mealpriceLabel.text = "NT$ \(String(workline.price))"
        cell.subtotalLabel.text = "NT$ \(String(workline.quantity*workline.price))"
        if workline.state == "未開工"{
            cell.statusLabel.text = "🔴"
        }else if workline.state == "完成"{
            cell.statusLabel.text = "完成"
        }
        return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
