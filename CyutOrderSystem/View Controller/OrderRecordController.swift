//
//  OrderDetailController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/18.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

class OrderRecordController: UITableViewController {

    var record : [orderrecord] = []

    var index : IndexPath?
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBAction func segment_act(_ sender: AnyObject) {
        
        tableView.reloadData()
    }
    
    
    //方法未完成
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        refreshControl?.beginRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        



        getOrderDetail()

        
        self.tableView.showsVerticalScrollIndicator = false

        //增加下拉式更新畫面
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    //取得訂單資料
    func getOrderDetail() {
        AF.request("http://163.17.9.46:8181/improject/rest/orders/so", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_, subJson) in json {
                    var data = orderrecord(orderNo: subJson["orderNo"].intValue, orderTime: subJson["orderTime"].stringValue, customerName: subJson["customerName"].stringValue, email: subJson["email"].stringValue, phoneNumber: subJson["phoneNumber"].stringValue, total: subJson["total"].intValue, workorderno: [])
                    for i in 0..<subJson["lines"].count{
                        if !data.workorderno.contains(subJson["lines"][i]["item"]["supplier"]["name"].stringValue){
                            data.workorderno.append(subJson["lines"][i]["item"]["supplier"]["name"].stringValue)
                        }
                    }
                    if data.email == Auth.auth().currentUser?.email! {
                        self.record.append(data)
                    }
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    
    
    
    //下拉式更新tableview
    @objc func loadData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
            self.refreshControl?.endRefreshing()
            self.record.removeAll()
            self.getOrderDetail()
            self.tableView.reloadData()
             
            }
            
            
        }
    
    
    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return record.count
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)as! OrderRecordCell
       
        // Configure the cell...
        let orderline = record[indexPath.row]
        
        //date
        let date = orderline.orderTime.prefix(10)
        //time
        let index = orderline.orderTime.index(orderline.orderTime.startIndex, offsetBy: 11)
        let time = index..<orderline.orderTime.endIndex
        //今日日期
        
        cell.orderNoLabel.text = "\(orderline.orderNo)"
        cell.costLabel.text = "NT$ \(orderline.total)"
        cell.timeLabel.text = "\(orderline.orderTime[time])"
        cell.dateLabel.text = "\(date)"
            
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.layer.borderColor = UIColor.orange.cgColor
        cell.layer.borderWidth = 0.2
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = self.tableView.indexPathForSelectedRow
        self.performSegue(withIdentifier: "orderdetailsegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "orderdetailsegue" {
            let controller = segue.destination as! SalesOredrDetailViewController
            
            
            controller.header.orderNo = self.record[index!.row].orderNo
            controller.header.orderTime = self.record[index!.row].orderTime
            controller.header.customerName = self.record[index!.row].customerName
            controller.header.email = self.record[index!.row].email
            controller.header.phoneNumber = self.record[index!.row].phoneNumber
            controller.header.workorderno = self.record[index!.row].workorderno
            controller.header.totalPrice = self.record[index!.row].total
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
