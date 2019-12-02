//
//  LoginController.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/7/2.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    @IBOutlet weak var emailtextfiled: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgetpassword: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    var memberdata = firebasemember()
        
    //忘記密碼按鈕
    @IBAction func forget(_ sender: Any) {
        let forgetalert = UIAlertController(title: "重設密碼", message: "請輸入忘記密碼的帳號信箱\n我們將會發送重置密碼的信件給您。", preferredStyle: .alert)
        let action = UIAlertAction(title: "發送", style: .default) { (action) in
            let email = forgetalert.textFields![0]
            Auth.auth().sendPasswordReset(withEmail: email.text!){ error in
                if error == nil{
                    let alert = UIAlertController(title: "已發送信件", message: "請至郵件信箱重置密碼", preferredStyle: .alert)
                    let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okaction)
                    self.present(alert, animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "錯誤!!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultaction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultaction)
                    self.present(alert, animated: true, completion: nil)
                }
            }

        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        forgetalert.addTextField{ (email) in
            email.placeholder = "請輸入Email"
        }
        
        forgetalert.addAction(action) 
        forgetalert.addAction(cancel)
        
        self.present(forgetalert, animated: true, completion: nil)
    }
    
    //註冊alert
    @IBAction func signup(_ sender: Any) {
        self.performSegue(withIdentifier: "signup", sender: nil)
        
//        let signalert = UIAlertController(title: "註冊", message: "", preferredStyle: .alert)
//        let saveAction = UIAlertAction(title: "送出", style: .default) { (action) in
//            let emailtextfiled = signalert.textFields![0]
//            let password = signalert.textFields![1]
//            Auth.auth().createUser(withEmail: emailtextfiled.text!, password: password.text!, completion: { (user, error) in
//                if error == nil {
//                    let alert = UIAlertController(title: "註冊成功", message: "", preferredStyle: .alert)
//                    let okaction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alert.addAction(okaction)
//                    self.present(alert, animated: true, completion: nil)
//                }else {
//                    let alert = UIAlertController(title: "錯誤!!", message: error?.localizedDescription, preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alert.addAction(defaultAction)
//                    self.present(alert, animated: true, completion: nil)
//                }
//            })
//        }
//
//        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//
//        signalert.addTextField{ (accounttextfiled) in
//            accounttextfiled.placeholder = "請輸入帳號"
//        }
//
//        signalert.addTextField{ (emailtextfiled) in
//            emailtextfiled.placeholder = "請輸入Email"
//        }
//        signalert.addTextField{ (password) in
//            password.placeholder = "請輸入密碼"
//            password.isSecureTextEntry = true
//        }
//
//        signalert.addAction(saveAction)
//        signalert.addAction(cancel)
//
//        present(signalert, animated: true, completion: nil)

    }
    
    //登入按鈕
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailtextfiled.text!, password: password.text!) { (user, error) in
            if (error != nil){
                let alert = UIAlertController(title: "錯誤!!", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultaction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
                alert.addAction(defaultaction)
                self.present(alert,animated: true,completion: nil)
            }else {
                let alert = UIAlertController(title: "登入成功", message: "請按確認後繼續", preferredStyle: .alert)
                let okbtn = UIAlertAction(title: "確認", style: .default){(_) in
                    self.performSegue(withIdentifier: "LoginToRestaurant", sender: nil)
                }
                alert.addAction(okbtn)
                self.present(alert,animated: true,completion: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addBackground()
        buttonDesign()
                // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user != nil {
//                self.performSegue(withIdentifier: "LoginToRestaurant", sender: nil)
//            }
//        }

    }
    func buttonDesign() {
        loginButton.layer.cornerRadius = 4
        signUp.layer.cornerRadius = 4
        forgetpassword.layer.cornerRadius = 4
    }

    
}

extension UIView{
    func addBackground() {
        //set背景的圖片尺寸
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageviewBackground = UIImageView(frame: CGRect(x: 0,y: 0,width: width,height: height))
        imageviewBackground.image = UIImage(named: "loginbackground")
        
        imageviewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.addSubview(imageviewBackground)
        self.sendSubviewToBack(imageviewBackground)
    }
    
}
