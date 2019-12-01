//
//  RestaurantInfo.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/4/26.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class RestaurantInfo: UITableViewController {
    
    @IBOutlet weak var img: UIImageView!
        
    func alamofiremeal() {
          AF.request("http://163.17.9.46:8181/improject/rest/dishes/", method: .get).validate().responseJSON { response in
              switch response.result {
              case .success(let value):
                  let json = JSON(value)
                  for (_, subJson) in json {
                    let data = meal(imageurl: subJson["imgName"].stringValue ,id: subJson["id"].intValue, name: subJson["name"].stringValue, price: subJson["price"].intValue)
                      self.mealData.append(data)
                  }
                  self.tableView.reloadData()
              case .failure(let error):
                  print(error.localizedDescription)
              }

      }
      }
    
    
    var mealData :[meal] = []
        
    fileprivate var cart = Cart()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.image = UIImage(named: "orderhere")

        alamofiremeal()
        self.tableView.showsVerticalScrollIndicator = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        cart.updateCart()
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mealData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealcell", for: indexPath) as! RestaurantInfoCell
        
        // Configure the cell...
        let product = mealData[indexPath.row]
        
        cell.delegate = self
        cell.mealNameLabel.text = product.name
        cell.costLabel.text = "$"+product.displayPrice()
        let url = URL(string: "http://163.17.9.46:8181/improject/resources/img/\(mealData[indexPath.row].imageurl)")
        cell.mealImage.kf.setImage(with: url)
        
        cell.setButton(state: self.cart.contains(meal: product))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShopCart" {
            if let cartViewController = segue.destination as? ShopCartViewController {
                cartViewController.cart = self.cart
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
extension RestaurantInfo: CartDelegate {
    
    // MARK: - CartDelegate
    func updateCart(cell: RestaurantInfoCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = mealData[indexPath.row]
        
        //更新購物車內商品
        cart.updateCart(with: product)
        
}

}
