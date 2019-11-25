//
//  RestaurantViewController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/10/8.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    let food = [restaurant(title: "一餐", image: ["restaurant1","restaurant2","restaurant3","restaurant4"], name: ["lslo","eijr","eret","orprl"], type: ["coffee","tea","coelkt","elrmt"]),restaurant(title: "二餐", image: ["restaurant5","restaurant6","restaurant7","restaurant8"], name: ["太初","認識","拉馬","隨便"], type: ["cofa","candy","noodle","orplt"]),restaurant(title: "三餐", image: ["restaurant9","restaurant10","restaurant11","restaurant12"], name: ["仙炙軒","湖庭","帕戈義大利餐廳","望湘園"], type: ["coffee","甜點 蛋糕","義大利麵","海鮮"])]
    
    var index: IndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //去除分隔線
        self.tableView.separatorStyle = .none
        
        //創建重用的單元格
        self.tableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        //設置estimatedRowHeight属性默认值
        self.tableView!.estimatedRowHeight = 44.0
        //rowHeight属性設置為UITableViewAutomaticDimension
        self.tableView!.rowHeight = UITableView.automaticDimension
       
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.food.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! RestaurantCell
        
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        
        cell.reloadData(title: food[indexPath.row].title, images: food[indexPath.row].image, name: food[indexPath.row].name, type: food[indexPath.row].type)
        
        cell.selectedBackgroundView?.backgroundColor = .white

        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)as! RestaurantCell
        cell.selectedBackgroundView?.backgroundColor = .white
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restinfo" {
            let controller = segue.destination as! RestaurantInfo
            
            }
    }
    
    
}
