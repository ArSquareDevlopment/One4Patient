//
//  LoginVC.swift
//  One for Patient
//
//  Created by Idontknow on 25/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit



class LoginVC: UIViewController {
    
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var logoIMGView: UIImageView!
    @IBOutlet weak var getMeBox: UIImageView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var loginINBtn: UIButton!
    @IBOutlet weak var withPassword: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var codeLoginBtn: UIButton!
    @IBOutlet weak var passCodeTF: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var signinView: UIView!
    var ischecked: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
      viewChanges()
      getMe()
    }
    func viewChanges() {
    loginINBtn.makeRound()
    getMeBox.isUserInteractionEnabled = true
    let checkBoxTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCheckBoxTap(_:)))
    getMeBox.addGestureRecognizer(checkBoxTapGesture)
    view.addSubview(popupView)
    popupView.frame = signinView.frame
        popupView.isHidden = true
        sendBtn.makeRound()
        codeLoginBtn.makeRound()
    }
    
    //    MARK: Requesting PassCode

    @IBAction func sendAxn(_ sender: UIButton) {
        if nameTF.text?.isEmpty == true {
            popUpAlert(title: "Alert", message: "Enter UserName", action: .alert)
            
        } else if reach.isConnectedToNetwork() == true {
            playLottie(fileName: "heartBeat")
        let details = [UserName:nameTF.text as Any, ] as [String:Any]
        print("details = \(details)")
        ApiService.callPost(url:ClientInterface.requestPassCodeUrl, params: details, methodType: "POST", tag: "SendPassCode", finish:finishPost)
        } else {
            popUpAlert(title: "Alert", message: "Check Internet connection", action: .alert)
            
        }
    }
    
    
    //    MARK:  Lgoin With Code

    @IBAction func codeLoginAxn(_ sender: UIButton) {
        if nameTF.text!.isEmpty == true || passCodeTF.text!.isEmpty == true {
            popUpAlert(title: "Alert", message: "Enter all details", action: .alert)
            
        } else  if passCodeTF.text!.count != 6 {
            popUpAlert(title: "Alert", message: "Enter 6 digit PassCode", action: .alert)
            
        } else if reach.isConnectedToNetwork() == true {
        let details = [UserName:nameTF.text! as Any, PassCode:passCodeTF.text! as Any ] as [String:Any]
        print("details = \(details)")
        playLottie(fileName: "heartBeat")
    ApiService.callPost(url:ClientInterface.loginWithPassCodeUrl, params: details, methodType: "POST", tag: "LoginPassCode", finish:finishPost)
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
            
        }
            
    }
        
        

    
//MARK:  Show Popupview

    @IBAction func withCodeAxn(_ sender: UIButton) {
        signinView.isHidden = true
        popupView.frame = CGRect(x: 20, y: Int(view.bounds.height/2), width: Int(view.bounds.width - 20), height: 340)
        popupView.isHidden =  false
        passCodeTF.isHidden = true
        codeLoginBtn.isHidden =  true

    }
    
    
    @IBAction func withPasswordAxn(_ sender: UIButton) {
        popupView.isHidden = true
        signinView.isHidden = false
    }
    
    
    
    
    //    MARK: Forgot Password

    @IBAction func forgotPassAxn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        self.navigationController?.pushViewController(VC, animated: true)
        
        
    }
    
//    MARK: Login With UserName & Pasword
    
    @IBAction func loginAxn(_ sender: UIButton) {


        if userNameTF.text == "" || passTF.text == "" {
        popUpAlert(title: "Alert", message: "Enter all details", action: .alert)
        }  else {
            postData()
        }

        
        
    }
    
    func postData() {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        let details = [UserName:userNameTF.text as Any, Password:passTF.text as Any] as [String:Any]
    ApiService.callPost(url:ClientInterface.patientLoginUrl, params: details, methodType: "POST", tag: "register", finish:finishPost)
    } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
    }

    }

//MARK:Signup
    @IBAction func signupBtn(_ sender: UIButton) {
         let VC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        
        VC.modalPresentationStyle = .popover
        VC.modalTransitionStyle = .coverVertical
        present(VC, animated: true) {
            
        }

    }

    //    MARK: Remember Me Action

    @objc func handleCheckBoxTap(_ sender: UITapGestureRecognizer) {
        
        if ischecked == true  {
            ischecked = false
            getMeBox.image = #imageLiteral(resourceName: "uncb")
            print("ischecked = \(ischecked)")
            UserInfo.setGetMe(type: false)
        } else {
            UserInfo.setGetMe(type: true)
            ischecked = true
            getMeBox.image = #imageLiteral(resourceName: "chkb")
            print("ischecked = \(ischecked)")
        }
    }
    
    
    func getMe() {
        if UserInfo.getGetMe() == true {
        getMeBox.image = #imageLiteral(resourceName: "chkb")
        userNameTF.text = UserInfo.getUserEmail()
        passTF.text =  UserInfo.getUserPass()
        } else {
        getMeBox.image = #imageLiteral(resourceName: "uncb")
        print("No GetMe")
        }
    }
    
    //    MARK: Fetching API Response

    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
//        spinner.hideActivityIndicator(view: view)
        stopLottie()
        if tag == "SendPassCode" {
            
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(PasscodeResponse.self, from: jsonData)
            print(parsedData)
            if parsedData.StatusCode! == 200 {
            popUpAlert(title: "PassCode Sent to your Email", message: "Enter PassCode to Login", action: .alert)
                passCodeTF.isHidden = false
                codeLoginBtn.isHidden = false
                   
            } else {
             popUpAlert(title: "Login Failed", message: "Check Detaisl..!", action: .alert)
            }
            }
            } catch {
                popUpAlert(title: "Login Failed", message: "Check Detaisl..!", action: .alert)
            print("Parse Error: \(error)")
            }
            
            }  else {
          
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
            print(parsedData)
            if parsedData.StatusCode == 200 {
                if ischecked == true {
                    AccountInfo.setUserEmail(type: userNameTF.text!)
                    UserInfo.setUserEmail(type: userNameTF.text!)
                    UserInfo.setUserPass(type: passTF.text!)
                }
            print("ParesedToken = \(parsedData.Result.Token!)")
            Preferences.setUserToken(type: "\(parsedData.Result.Token!)")
            print("Token success")
            let profileUrl = "\(ClientConfig.BASE_URL)" + "\(String(describing: parsedData.Result.ProfilePic))"
            print("ProfileUrl = \(profileUrl)")
            GlobalVariables.token = parsedData.Result.Token!
            GlobalVariables.userName = parsedData.Result.UserName!
                print("GlobalUserName = \(GlobalVariables.userName)")
            GlobalVariables.profileID = "\(String(describing: parsedData.Result.Profile.Id!))"
                print("GlobalePID = \(GlobalVariables.profileID)")
            GlobalVariables.accountID = "\(String(describing: parsedData.Result.Id!))"
                print("GlobaleUID = \(GlobalVariables.accountID)")
                GlobalVariables.userEmail = parsedData.Result.Email!
                print("GlobalEmai = \(GlobalVariables.userEmail)")


                
                if parsedData.Result.Role! == "Specialist"{
            GlobalVariables.isDoctor = true
            let story = UIStoryboard(name: "Specialist", bundle: nil)
            let VC = story.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.navigationController?.pushViewController(VC, animated: true)
                    
            } else {
            GlobalVariables.isDoctor = false
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    
            self.navigationController?.pushViewController(VC, animated: true)
                
            }
                
            } else {
              popUpAlert(title: "Login Failed", message: "Check Detaisl..!", action: .alert)
            }
            }
                
            } catch {
            popUpAlert(title: "Login Failed", message: "Check Detaisl..!", action: .alert)
             print("Parse Error: \(error)")
            }
            }
 
    }
    

}
