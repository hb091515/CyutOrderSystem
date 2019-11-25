//
//  ShopCartViewController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/15.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

class ShopCartViewController: UIViewController {

    var cart : Cart? = nil
    
    var auth = member()
    
    fileprivate var order = salesorder()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLable: UILabel!
    
    @IBOutlet weak var button: UIButton!
    @IBAction func CheckoutButton(_ sender: UIButton) {
        
        
        let optionMenu = UIAlertController(title: "確定送出?", message: "送出後資料無法變更", preferredStyle: .alert)
        
        //點選OK,post訂單資料
        let okbutton = UIAlertAction(title: "送出", style: .default){(_) in
            
            
            //產生訂單資料
            
            self.order = salesorder(customerName: self.auth.student?.name!, phoneNumber: self.auth.student?.phoneNumber!, email: Auth.auth().currentUser?.email!, lines: [])
            
            for i in 0..<(self.cart!.items.count) {
                self.order.lines.append(orderline.init(item: item.init(id: self.cart?.items[i].meal.id, quantity: self.cart?.items[i].quantity)))
            }
            //post訂單資料
            AF.request("http://163.17.9.46:8181/improject/rest/orders/so/post", method: .post ,parameters:  self.order.ToDict(),encoding: JSONEncoding.default).validate().responseJSON{ response in
                switch response.result{
                case .success( _):
                    print(response.result)
                    let alertcontroller = UIAlertController(title: "送出成功", message: "", preferredStyle: .alert)
                    let okbtn = UIAlertAction(title: "OK", style: .default){ (_) in
                        
                    }
                    alertcontroller.addAction(okbtn)
                    self.present(alertcontroller, animated: true, completion: nil)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
                        
            self.cart?.items.removeAll()
            self.tableView.reloadData()
            self.totalLable.text = "NT$ "+(self.cart?.total.description)!
            
     }
        
        optionMenu.addAction(okbutton)
        
        let cancelbutton = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        optionMenu.addAction(cancelbutton)
        
        present(optionMenu, animated: true, completion: nil)
        
        
    }
    @IBOutlet weak var navigationbar: UINavigationItem!
    
    @IBOutlet weak var clearbutton: UIButton!
    //清空購物車
    @IBAction func clear_button(_ sender: UIButton) {
        self.cart?.items.removeAll()
        self.totalLable.text = "NT$ "+(self.cart?.total.description)!
        
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getauthdata()
        
        view_design()
        
        self.tableView.allowsMultipleSelectionDuringEditing = true
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.totalLable.text = "NT$ "+(self.cart?.total.description)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func view_design(){
        self.button.layer.cornerRadius = 7
        self.button.layer.masksToBounds = true
        
        self.tableView.layer.masksToBounds = true
        self.tableView.layer.cornerRadius = 10
        navigationbar.title = "購物車"
        
        self.clearbutton.layer.cornerRadius = 7
        self.clearbutton.layer.masksToBounds = true
        self.clearbutton.layer.borderWidth = 0.4
        self.clearbutton.layer.borderColor = UIColor.blue.cgColor

    }
    
    func getauthdata() {
            AF.request("http://163.17.9.46:8181/improject/rest/users", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for (_, subJson) in json {
                        let data = member(id: subJson["id"].stringValue, password: subJson["password"].stringValue, student: detail(email: subJson["student"]["email"].stringValue, name: subJson["student"]["name"].stringValue, phoneNumber: subJson["student"]["phoneNumber"].stringValue), userId: subJson["userId"].stringValue)
                        if (data.student?.email)! == Auth.auth().currentUser?.email{
                            self.auth = data
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

extension ShopCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cart?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCartCell", for: indexPath)as! ShopCartCell
        
        // Configure the cell...
        if let cartItem = cart?.items[indexPath.item] {
            cell.delegate = self as CartItemDelegate
            
            cell.cartName.text = cartItem.meal.name
            cell.cartPrice.text = "$"+cartItem.meal.displayPrice()
            cell.cartQuantity.text = String(describing: cartItem.quantity)
            cell.quantity = cartItem.quantity
            
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    
    
    
    //滑動刪除購物車物品
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "刪除", handler: {(
            action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            
            
            self.cart?.items.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.totalLable.text = "NT$ "+(self.cart?.total.description)!

        })
        return [deleteAction]
    }
   
}

extension ShopCartViewController: CartItemDelegate {
    
    // MARK: - CartItemDelegate
    func updateCartItem(cell: ShopCartCell, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let cartItem = cart?.items[indexPath.row] else { return }
        
        //更新購物車內商品數量
        cartItem.quantity = quantity
        
        //更新購物車內商品總價(數量*單價)
        guard let total = cart?.total else { return }
        totalLable.text = "NT$ "+String(total)
    }
    
}
