//
//  ShopCartTableViewController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/4/20.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class ShopCartTableViewController: UITableViewController {

    var cart : Cart? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (cart?.items.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCartCell", for: indexPath)as! ShopCartCell

        // Configure the cell...
            if let cartItem = cart?.items[indexPath.item] {
                cell.delegate = self as CartItemDelegate
                
                cell.cartName.text = cartItem.meal.name
                cell.cartPrice.text = "$"+cartItem.meal.displayPrice()
                cell.cartQuantity.text = String(describing: cartItem.quantity)
            //    cell.quantity = cartItem.quantity
            }
    
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ShopCartTableViewController: CartItemDelegate {
    
    // MARK: - CartItemDelegate
    func updateCartItem(cell: ShopCartCell, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let cartItem = cart?.items[indexPath.row] else { return }
        
        //Update cart item quantity
        cartItem.quantity = quantity
        
        //Update displayed cart total

    }
    
}
