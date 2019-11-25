//
//  MemberController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/7/23.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Firebase

class MemberController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let label_type = ["更改密碼"]
    let image = ["password"]
    var screen_width : CGFloat!
    var screen_height : CGFloat!
    
    @IBOutlet weak var header_view: UIView!
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBAction func LogOutButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                dismiss(animated: true, completion: nil)
            }catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    @IBOutlet weak var Logoutbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_frame()
 
        
        // Do any additional setup after loading the view.
    }
    
    func view_frame(){
        screen_width = self.view.frame.size.width
        screen_height = self.view.frame.size.height
        self.header_view.frame.size.height = screen_height/3
        self.header_view.frame.size.width = screen_width
        self.name.text = Auth.auth().currentUser?.email!
        
        profile.layer.borderWidth = 0
        profile.layer.masksToBounds = false
        profile.layer.borderColor = UIColor.black.cgColor
        profile.layer.cornerRadius = profile.frame.height/2
        profile.clipsToBounds = true
        
        Logoutbutton.layer.cornerRadius = 8
        Logoutbutton.layer.masksToBounds = true
        Logoutbutton.layer.borderWidth = 0.4
        Logoutbutton.layer.borderColor = UIColor.orange.cgColor
        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = header_view.bounds
//        gradientLayer.colors = [UIColor(, UIColor.orange.cgColor]
//        gradientLayer.locations = [0.0,0.2]
//        self.header_view.layer.addSublayer(gradientLayer)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! MemberCell
        
        cell.type_icon.image = UIImage(named: image[indexPath.row])
        cell.type_label.text = label_type[indexPath.row]
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let passwordalert = UIAlertController(title: "忘記密碼", message: "確定要更改密碼?\n我們將會發送更改密碼的信件給您。", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "送出", style: .default) { (action) in
                self.sendPasswordReset(withEmail: self.name.text!)
                let OKalert = UIAlertController(title: "已發送信件", message: nil, preferredStyle: .alert)
                let OKbutton = UIAlertAction(title: "OK", style: .default, handler: nil)
                OKalert.addAction(OKbutton)
                self.present(OKalert, animated: true, completion: nil)
                }
        
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            passwordalert.addAction(OKAction)
            passwordalert.addAction(cancel)
            
            present(passwordalert, animated: true, completion: nil)

        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func sendPasswordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            callback?(error)
    }
    }
    
    //color change (hex)
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
