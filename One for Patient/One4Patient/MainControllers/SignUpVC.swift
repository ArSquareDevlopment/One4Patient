//
//  SignUpVC.swift
//  One for Patient
//
//  Created by Idontknow on 24/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit
import NetworkExtension
import AMPopTip

class SignUpVC: UIViewController {
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var DOBTF: UITextField!
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var conformTF: UITextField!
    @IBOutlet weak var userSC: UISegmentedControl!
    @IBOutlet weak var genderSC: UISegmentedControl!
   
    @IBOutlet weak var registerSV: UIStackView!
    @IBOutlet weak var genderView: UIView!
    var genderType = "1"
    
    @IBOutlet weak var firstNameConst: NSLayoutConstraint!
    
    @IBOutlet weak var userNameConst: NSLayoutConstraint!
    
    @IBOutlet weak var DOBConst: NSLayoutConstraint!
    @IBOutlet weak var emailConst: NSLayoutConstraint!
    @IBOutlet weak var lastNameConst: NSLayoutConstraint!
    
    @IBOutlet weak var phoneConst: NSLayoutConstraint!
    
    
    @IBOutlet weak var conformConst: NSLayoutConstraint!
    @IBOutlet weak var passwordConst: NSLayoutConstraint!
    @IBOutlet weak var viewConst: NSLayoutConstraint!
    
    
    @IBOutlet weak var signConst: NSLayoutConstraint!
    @IBOutlet weak var gendetConst: NSLayoutConstraint!
    
    @IBOutlet weak var regiserConst: NSLayoutConstraint!
    
    @IBOutlet weak var dataView: UIView!
    var popup = PopTip()
    let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 150))

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
//       hideTextFields()

  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
//        animate(animieType: .curveEaseIn)
}
    
    @objc func handlePicker(sender: UIDatePicker) {
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        DOBTF.text = dateFormatter.string(from: sender.date)


    }
    
    
    
    func viewChanges() {
    signUpBtn.makeRound()
    hideKeyboardWhenTappedAround()
    picker.maximumDate = Date()
    picker.backgroundColor = .baseColor
    picker.addTarget(self, action: #selector(handlePicker(sender:)), for: .valueChanged)
    picker.setValue(UIColor.white, forKey: "textColor")

    picker.datePickerMode = .date
    popup.bubbleColor = .baseColor
    
    }

    @IBAction func genderSC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
        genderType = "0"
        } else {
        genderType = "1"
        }
    }
    
    
   

   @IBAction func DOBTFAxn(_ sender: UITextField) {
//    sender.resignFirstResponder()
//    popup.show(customView: picker, direction: .up, in: view, from: sender.frame)
    sender.pastDatePicker()
    }
    
    
    
    @IBAction func backBtnAxn(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
//    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passTFAXN(_ sender: UITextField) {
        if sender.text?.isValidPassword() == false {
            sender.shake()
            popUpAlert(title: "The Password must contain", message: " Minimum 6 letters [1 Capital Letter, 1 Small Letter,1 Symbol, 1 Number]", action: .alert)
        }
    }
    
    @IBAction func loginBtnAxn(_ sender: UIButton) {

        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func signUPAxn(_ sender: UIButton) {
    if firstNameTF.text == "" || lastNameTF.text == "" || userNameTF.text == "" ||
    emailTF.text == "" || DOBTF.text == "" ||
    phoneNoTF.text == "" || passwordTF.text == "" || conformTF.text == "" {
    signUpBtn.shake()
    popUpAlert(title: "Alert", message: "Please Enter all details..!", action: .alert)
            
    } else if firstNameTF.text!.count < 5 || lastNameTF.text!.count < 5 || userNameTF.text!.count < 5 {
    popUpAlert(title: "Name", message: "Not lessthan 5 letters ", action: .alert)
    } else if emailTF.text?.isValidEmail(email: emailTF.text!) != true  {
    popUpAlert(title: "Eamil", message: "Enter valid Email", action: .alert)
        
    } else if phoneNoTF.text?.count != 10 {
    popUpAlert(title: "Mobile", message: "should be 10 numbers", action: .alert)
        
    }  else if passwordTF.text?.isValidPassword() == false {
    
    popUpAlert(title: "Alert", message: "The Password must contain Min 6 letters[1 Capital , 1 Small ,1 Symbol, 1 Number]", action: .alert)
          
    } else if conformTF.text != passwordTF.text {
    popUpAlert(title: "Password doesn't match", message: "Please conform password", action: .alert)
    } else if genderSC.selectedSegmentIndex != 0 && genderSC.selectedSegmentIndex != 1  {
        popUpAlert(title: "Alert", message: "Select Gender ", action: .alert)
    }  else  {
        postData()
        }
    }
    
    
    func postData() {
    if reach.isConnectedToNetwork() == true {
           
    if userSC.selectedSegmentIndex == 0 {
    let registration : Dictionary = [FName : firstNameTF.text!, LName : lastNameTF.text!, UserName : userNameTF.text!, Email : emailTF.text!, ConfirmPassword : conformTF.text!, PhoneNumber: phoneNoTF.text!, DOB: DOBTF.text!, Gender: genderType, MasterSubscriptionId:"1", MasterSubscriptionPlanId: "1",Password:passwordTF.text!] as [String : Any]
        
    playLottie(fileName: "heartBeat")
    ApiService.callPost(url: ClientInterface.patientRegisterUrl, params: registration, methodType: "POST", tag: "register", finish:finishPost)
    print("details = \(registration)")
    
    } else {
                
    let registration : Dictionary = [FName : firstNameTF.text!, LName : lastNameTF.text!, UserName : userNameTF.text!, Email : emailTF.text!, ConfirmPassword : conformTF.text!, PhoneNumber: phoneNoTF.text!, DOB: DOBTF.text!, Gender: genderType, Password:passwordTF.text!] as [String : Any]
                
    playLottie(fileName: "heartBeat")

    ApiService.callPost(url: ClientInterface.splRegisterUrl, params: registration, methodType: "POST", tag: "SplRegister", finish:finishPost)
                    print("spldetails = \(registration)")
    }
    } else {
    popUpAlert(title: "Internet", message: "Check Connection", action: .alert)
    }
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(RegisterResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
            popUpAlert(title: "Success", message: "Registration Completed", action: .alert)
            firstNameTF.text = ""
            lastNameTF.text = ""
            userNameTF.text = ""
            DOBTF.text = ""
            phoneNoTF.text = ""
            passwordTF.text = ""
            conformTF.text = ""
        } else {
            popUpAlert(title: "Registration Failed", message: "Check Details", action: .alert)
        }
        }
        } catch {
        popUpAlert(title: "Registration Failed", message: "Check Details", action: .alert)
            print("Parse Error: \(error)")
        }
        }
        
    
    
    
}


extension SignUpVC {
    
   
   
    
    func hideTextFields() {
        firstNameTF.isHidden = true
        lastNameTF.isHidden = true
        userNameTF.isHidden = true
        emailTF.isHidden = true
        DOBTF.isHidden = true
        phoneNoTF.isHidden = true
        passwordTF.isHidden = true
        conformTF.isHidden = true
        genderView.isHidden = true
        signUpBtn.isHidden = true
        registerSV.isHidden = true 
        firstNameConst.constant -= view.bounds.width
        lastNameConst.constant -= view.bounds.width
        userNameConst.constant -= view.bounds.width
        emailConst.constant -= view.bounds.width
        DOBConst.constant -= view.bounds.width
        phoneConst.constant -= view.bounds.width
        passwordConst.constant -= view.bounds.width
        conformConst.constant -= view.bounds.width
        gendetConst.constant -= view.bounds.width
        signConst.constant -= view.bounds.width
        regiserConst.constant -= view.bounds.width

     }
   
    
    
    func showAnimation(timeDelay:Double) {
        UIView.animate(withDuration: 0.5, delay: timeDelay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            }, completion: nil)

    }
    
    
    func animateTextFiled(duration:Double,delayTime:Double, type:UIView.AnimationOptions,item:UITextField,constType:NSLayoutConstraint) {
        
        UIView.animate(withDuration: duration, delay: delayTime, options: type, animations: {
            item.isHidden =  false
            constType.constant = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func animate(animieType:UIView.AnimationOptions) {
        animateTextFiled(duration: 0.5, delayTime: 0.0, type:animieType, item: firstNameTF, constType: firstNameConst)
        animateTextFiled(duration: 0.5, delayTime: 0.2, type: animieType, item: lastNameTF, constType: lastNameConst)
        animateTextFiled(duration: 0.5, delayTime: 0.4, type: animieType, item: userNameTF, constType: userNameConst)
        animateTextFiled(duration: 0.5, delayTime: 0.6, type:animieType, item: emailTF, constType: emailConst)
        animateTextFiled(duration: 0.5, delayTime: 0.8, type:animieType, item: DOBTF, constType: DOBConst)
        UIView.animate(withDuration: 0.5 , delay: 1.0 , options: animieType, animations: {
            self.genderView.isHidden =  false
            self.gendetConst.constant = 0
                   self.view.layoutIfNeeded()
                   }, completion: nil)
        animateTextFiled(duration: 0.5, delayTime: 1.2, type:animieType, item: phoneNoTF, constType: phoneConst)
        animateTextFiled(duration: 0.5, delayTime: 1.4, type:animieType, item: passwordTF, constType: passwordConst)
        
        animateTextFiled(duration: 0.5, delayTime: 1.6, type:animieType, item: conformTF, constType: conformConst)
        
        UIView.animate(withDuration: 0.5 , delay: 1.8 , options: animieType, animations: {
       
            self.signUpBtn.isHidden = false
            self.signConst.constant = 0
               self.view.layoutIfNeeded()
               }, completion: nil)
        UIView.animate(withDuration: 0.5 , delay: 2.0 , options: animieType, animations: {
               self.registerSV.isHidden =  false
            self.regiserConst.constant = 0
                      self.view.layoutIfNeeded()
                      }, completion: nil)
        
    }
    
}
