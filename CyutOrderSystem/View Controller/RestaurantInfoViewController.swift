//
//  RestaurantInfoViewController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/13.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RestaurantInfoViewController: UIViewController {

    var mealData :[meal] = []
    
    var mealImage = ["meal1","meal2","meal3","meal4","meal5","meal6"]
    
    fileprivate var cart = Cart()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alamofiremeal()

        // Do any additional setup after loading the view.
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



extension RestaurantInfoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealcell", for: indexPath) as! RestaurantInfoCell
        
        // Configure the cell...
        
        cell.mealNameLabel.text = self.mealData[indexPath.row].name
        cell.costLabel.text = "$"+String(self.mealData[indexPath.row].price)
        cell.mealImage.image = UIImage(named: mealImage[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func alamofiremeal() {
        AF.request("http://163.17.9.46:8181/improject/rest/dishes/", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                json.array?.forEach({ (rest) in
                    let rest = meal(name: rest["name"].stringValue, price: rest["price"].intValue)
                    self.mealData.append(rest)
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

    
    
    
    
}
