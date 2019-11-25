//
//  SearchController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/11/24.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    var searchController : UISearchController!
    
    var searchResult : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        
        self.navigationItem.searchController = searchController
    }

    func filterContent(for searchtext: String) {
        
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
