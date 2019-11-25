//
//  SearchViewController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/11/24.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    
    var mealdata : [meal] = []
    
    var searchResult : [meal] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        getmealdata()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true



        }
    
    func getmealdata() {
        AF.request("http://163.17.9.46:8181/improject/rest/dishes/", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for (_, subJson) in json {
                        let data = meal(id: subJson["id"].intValue, name: subJson["name"].stringValue, price: subJson["price"].intValue)
                        self.mealdata.append(data)
                    }
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }

        }
    }
    
    // search method
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        searchResult = mealdata.filter{ (name) -> Bool in
            return name.name.contains(searchString)
        }
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navigationItem.searchController?.isActive == true {
            return searchResult.count
        }else {
            return mealdata.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)as! SearchTableViewCell

        if navigationItem.searchController?.isActive == true {
            cell.mealname.text = searchResult[indexPath.row].name
            cell.mealcost.text = "NT$ \(String(searchResult[indexPath.row].price))"
        }else {
            cell.mealname.text = mealdata[indexPath.row].name
            cell.mealcost.text = "NT$ \(String(mealdata[indexPath.row].price))"
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
