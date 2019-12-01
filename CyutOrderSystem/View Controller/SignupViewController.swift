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
    
    var tint = ["學校信箱Email","密碼Password","名字Name","電話CellPhone"]
    
    var auth = member()
    
    var textfieldtag = 0
    
    var index : IndexPath?
    
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
            
            let id = emailcell.textfield.text?.split(separator: "@")[0]
            print(id!)
            
            self.auth = member(id: String(id!), password: passwordcell.textfield.text, student: detail(email: emailcell.textfield.text, name: namecell.textfield.text, phoneNumber: cellphonecell.textfield.text), userId: emailcell.textfield.text)
            
            //驗證格式
            //欄位不是空的
            if !(self.auth.id!.isEmpty) && (!self.auth.password!.isEmpty) && !(self.auth.student?.email!.isEmpty)! && !(self.auth.student?.name!.isEmpty)! && !(self.auth.student?.phoneNumber!.isEmpty)! {
                
                if (self.isValidEmail(emailStr: emailcell.textfield.text!) != false) && (self.isValidphone(cellphone: cellphonecell.textfield.text!) != false){
                    
                    if passwordcell.textfield.text!.count > 6 {
                        //post會員資料
                        AF.request("http://163.17.9.46:8181/improject/rest/users/post", method: .post, parameters: self.auth.ToDict(), encoding: JSONEncoding.default).validate().response{ response in
                            switch response.result{
                            case .success(_):
                                Auth.auth().createUser(withEmail: (self.auth.student?.email)!, password: self.auth.password!, completion: { (user, error) in
                                    if error == nil {
                                        let alert = UIAlertController(title: "註冊成功", message: "", preferredStyle: .alert)
                                        let okbtn = UIAlertAction(title: "確認", style: .default){(_) in
                                        self.dismiss(animated: true, completion: nil)
                                        }
                                        alert.addAction(okbtn)
                                        self.present(alert, animated: true, completion: nil)
                                    }

                                })
                            case .failure(_):
                                let failalert = UIAlertController(title: "註冊失敗!!", message: nil, preferredStyle: .alert)
                                let failbtn = UIAlertAction(title: "確認", style: .default, handler: nil)
                                failalert.addAction(failbtn)
                                self.present(failalert, animated: true, completion: nil)
                            }
                        }
                    }else{
                        let alert = UIAlertController(title: "註冊失敗!!", message: "密碼格式必須大於6字元", preferredStyle: .alert)
                        let failbtn = UIAlertAction(title: "確認", style: .default, handler: nil)
                        alert.addAction(failbtn)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }else {
                    let alert = UIAlertController(title: "註冊失敗!!", message: "欄位資料格式錯誤", preferredStyle: .alert)
                    let failbtn = UIAlertAction(title: "確認", style: .default, handler: nil)
                    alert.addAction(failbtn)
                    self.present(alert, animated: true, completion: nil)
                }
            //欄位有空的話
            }else {
                let failalert = UIAlertController(title: "註冊失敗!!", message: "欄位上有未填入資料", preferredStyle: .alert)
                let failbtn = UIAlertAction(title: "確認", style: .default, handler: nil)
                failalert.addAction(failbtn)
                self.present(failalert, animated: true, completion: nil)
            }
        }
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertcontorller.addAction(OKbutton)
        alertcontorller.addAction(cancel)
        
        present(alertcontorller, animated: true, completion: nil)
    }
    
    //信箱格式
     func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "s+[0-9]+@gm.cyut.edu.tw"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    //電話格式
    func isValidphone(cellphone:String) -> Bool {
        let cellphoneRegEx = "09+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"
        
        let cellphonePred = NSPredicate(format: "SELF MATCHES %@", cellphoneRegEx)
        return cellphonePred.evaluate(with: cellphone)
    }
    
    //限制字數
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.placeholder == "密碼Password" {
            let countOfWords = string.count + textField.text!.count - range.length

           if  countOfWords > 16 {
               return false
           }
            
        }else if textField.placeholder == "電話CellPhone" {
            
            let countOfWords = string.count + textField.text!.count - range.length

            if  countOfWords > 10 {
                return false
            }
        }
        
        return true

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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signupCell", for: indexPath)as! SignupTableViewCell
        
        cell.textfield.placeholder = tint[indexPath.row]
        
        if indexPath.row == 0{
            cell.textfield.keyboardType = .emailAddress
        }else if indexPath.row == 1 {
            cell.textfield.delegate = self
            cell.textfield.isSecureTextEntry = true
        }else if indexPath.row == 3 {
            cell.textfield.delegate = self
            cell.textfield.textContentType = .telephoneNumber
        }
        
        return cell
     }

}
