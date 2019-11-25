//
//  SignupViewController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/11/24.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import SwiftyJSON

class SignupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var tint = ["Email","Password","Name","CellPhone"]
    
    var auth = member()
    
    @IBOutlet weak var tableview: UITableView!
    //註冊送出
    @IBAction func signupButton(_ sender: UIButton) {
        let alertcontorller = UIAlertController(title: "確定送出?", message: "送出後無法更改資料", preferredStyle: .alert)
        
        let OKbutton = UIAlertAction(title: "送出", style: .default){ (_) in
            
            let emailindex = NSIndexPath(row: 0, section: 0)
            let passwordindex =  NSIndexPath(row: 1, section: 0)
            let nameindex =  NSIndexPath(row: 2, section: 0)
            let Cellphoneindex =  NSIndexPath(row: 3, section: 0)
            
            let emailcell = self.tableview.cellForRow(at: emailindex as IndexPath)as! SignupTableViewCell
            let passwordcell = self.tableview.cellForRow(at: passwordindex as IndexPath)as! SignupTableViewCell
            let namecell = self.tableview.cellForRow(at: nameindex as IndexPath)as! SignupTableViewCell
            let cellphonecell = self.tableview.cellForRow(at: Cellphoneindex as IndexPath)as! SignupTableViewCell
            
            self.auth = member(id: emailcell.textfield.text, password: passwordcell.textfield.text, student: detail(email: emailcell.textfield.text, name: namecell.textfield.text, phoneNumber: cellphonecell.textfield.text), userId: emailcell.textfield.text)
            
            if !self.auth.id!.isEmpty && !self.auth.password!.isEmpty && !(self.auth.student?.email!.isEmpty)! && !(self.auth.student?.name!.isEmpty)! && !(self.auth.student?.phoneNumber!.isEmpty)! {
                
                //post會員資料
                AF.request("http://163.17.9.46:8181/improject/rest/users/post", method: .post, parameters: self.auth.ToDict(), encoding: JSONEncoding.default).validate().response{ response in
                    switch response.result{
                    case .success(_):
                        Auth.auth().createUser(withEmail: (self.auth.student?.email)!, password: self.auth.password!, completion: nil)
                        let okalert = UIAlertController(title: "註冊成功", message: nil, preferredStyle: .alert)
                        let okbtn = UIAlertAction(title: "OK", style: .default){(_) in
                            self.dismiss(animated: true, completion:nil)
                        }
                        okalert.addAction(okbtn)
                        self.present(okalert, animated: true, completion: nil)
                    case .failure(_):
                        let failalert = UIAlertController(title: "註冊失敗", message: nil, preferredStyle: .alert)
                        let failbtn = UIAlertAction(title: "確認", style: .default, handler: nil)
                        failalert.addAction(failbtn)
                        self.present(failalert, animated: true, completion: nil)
                    }
                }
                
            }else {
                let checkalert = UIAlertController(title: "錯誤!!", message: "欄位資料有異", preferredStyle: .alert)
                let checkbtn = UIAlertAction(title: "確認", style: .default, handler: nil)
                
                checkalert.addAction(checkbtn)
                self.present(checkalert, animated: true, completion: nil)
            }
            
            
            //post 會員資料
                
            
            
            
        }
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertcontorller.addAction(OKbutton)
        alertcontorller.addAction(cancel)
        
        present(alertcontorller, animated: true, completion: nil)

        
        
        
    }
    
    @IBOutlet weak var signupbutton: UIButton!{
        didSet{
            signupbutton.layer.cornerRadius = 6
            signupbutton.layer.masksToBounds = true
        }
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var cancelbtn: UIButton!{
        didSet{
            cancelbtn.layer.cornerRadius = 6
            cancelbtn.layer.masksToBounds = true
            cancelbtn.layer.borderColor = UIColor.blue.cgColor
            cancelbtn.layer.borderWidth = 0.4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signupCell", for: indexPath)as! SignupTableViewCell
        
        cell.textfield.placeholder = tint[indexPath.row]
        
        if indexPath.row == 1{
            cell.textfield.isSecureTextEntry = true
        }
        
        return cell
     }


}
