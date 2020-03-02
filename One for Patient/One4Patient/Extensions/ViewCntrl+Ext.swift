//
//  ViewCntrl+Ext.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import Network
import AMPopTip


public var selectedDate = ""
extension UIViewController {
    
//MARK: Camera Alert
    func cameraAlert() {
        
        let alert = UIAlertController(title: "Profile Picture", message: "Choose Image", preferredStyle: .alert)
                    
        alert.setBackgroundColor(color: .groupTableViewBackground)
        alert.setTitlet(font: UIFont(name: "OpenSans", size: 15.0), color: .red)
        alert.setMessage(font: UIFont(name: "OpenSans", size: 15.0), color: .black)
        alert.setTint(color: .black)
                    
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
        self.openGallery()
                }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func openGallery(){
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
    let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    imagePicker.allowsEditing = true
    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
    self.present(imagePicker, animated: true, completion: nil)
    } else {
    popUpAlert(title: "Alert", message: "User denied accesses Gallery", action: .alert)
      }
        
    }
//    MARK: Hide Key Board on tap
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
// MARK: POP-UP Alerts
    func popUpAlert(title:String, message:String, action:UIAlertController.Style) {
    let alert = UIAlertController(title: title , message: message, preferredStyle: action)
    alert.setTitlet(font: UIFont(name: "Baskerville", size: 14), color: .red)
    alert.setMessage(font: UIFont(name: "Baskerville", size: 14), color: .black)
    alert.setBackgroundColor(color: .white)
    self.present(alert, animated: true, completion: nil)
    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)
    }
    )
    }
    
    
    func showInternetAlert() {
    let alert = UIAlertController(title: "Alert" , message: "Check Internet Connection", preferredStyle: .alert)
    alert.setTitlet(font: UIFont(name: "Baskerville-SemiBold", size: 14), color: .red)
    alert.setMessage(font: UIFont(name: "Baskerville-SemiBold", size: 14), color: .black)
    alert.setBackgroundColor(color: .white)
    self.present(alert, animated: true, completion: nil)
    }

//    MARK: LOTTIE ANIMATION
    
    func playLottie(fileName:String) {
    let animView = AnimationView(name: fileName)
    animView.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
    animView.center  = self.view.center
    animView.backgroundColor = .clear
    self.view.addBlurEffect()
    self.view.addSubview(animView)
    animView.tag = 99
    animView.loopMode = .loop
    animView.sizeToFit()
    animView.animationSpeed = 1.0
    animView.play()
    
    }
           
           
    func stopLottie() {
    let animieView = self.view.viewWithTag(99) as! AnimationView
    self.view.removeBlurEffect()
    animieView.stop()
    animieView.removeFromSuperview()
    
    }
    
//    MARK: POPover ViewController
    
    
    func getCurrentDateString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = "dd-MMM-yyyy" //"dd.MM.yy"                // 21.10.17
    let date = Date()
         
        // US English Locale (en_US)
    dateFormatter.locale = Locale(identifier: "en_US")
    print("Current Date = \(dateFormatter.string(from: date))")
    return dateFormatter.string(from: date)
        
    }
    
    
    func showNotificationView(fileName:String,text:String) {
    let notifyView = UIView()
    notifyView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    notifyView.center  = self.view.center
    notifyView.backgroundColor = .clear
    self.view.addSubview(notifyView)
    let imgView = UIImageView()
        imgView.center = notifyView.center
        imgView.frame = CGRect(x: 0, y: 5, width: 70, height: 70)
        imgView.image = UIImage(named: fileName)
        notifyView.addSubview(imgView)
    let txtLbl = UILabel()
        txtLbl.frame = CGRect(x: 0, y: 80, width: notifyView.frame.width, height: 20)
        txtLbl.text = text
        notifyView.addSubview(txtLbl)
    notifyView.tag = 999
    notifyView.sizeToFit()
    notifyView.isHidden = false
    
    }
           
           
    func hideNotificationView() {
    let notifyView = self.view.viewWithTag(999)
    notifyView?.isHidden = true
    notifyView?.removeFromSuperview()
    
    }
    

    func showTip(Txt:String,dir:PopTipDirection, from:CGRect) {
        
        let msgTip = PopTip()
        msgTip.edgeMargin = 5
        msgTip.offset = 2
        msgTip.bubbleOffset = 0
        msgTip.edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        msgTip.bubbleColor = .baseColor
        msgTip.font = .italicSystemFont(ofSize: 13)
        msgTip.arrowRadius = 0
        msgTip.shadowOpacity = 0.4
        msgTip.shadowRadius = 3
        msgTip.shadowOffset = CGSize(width: 1, height: 1)
        msgTip.shadowColor = .black
        
        msgTip.actionAnimation = .bounce(5)
        msgTip.show(text: Txt, direction: dir, maxWidth: view.frame.width, in: self.view, from: from)
    }
    
    
    
    func showPopDate(tag:Int, direction:PopTipDirection, from:CGRect) {
        let datePickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 180))
        datePickerView.datePickerMode = .date
        if tag == 0 {
            datePickerView.maximumDate = Date()
        } else {
            datePickerView.minimumDate = Date()

        }

        datePickerView.setValue(UIColor.white, forKey: "textColor")
        datePickerView.backgroundColor = UIColor.baseColor
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        let msgTip = PopTip()
        
        msgTip.edgeMargin = 5
        msgTip.offset = 2
        msgTip.bubbleOffset = 0
        msgTip.edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        msgTip.bubbleColor = .baseColor
        msgTip.font = .italicSystemFont(ofSize: 13)
        msgTip.arrowRadius = 0
        msgTip.shadowOpacity = 0.4
        msgTip.shadowRadius = 3
        msgTip.shadowOffset = CGSize(width: 1, height: 1)
        msgTip.shadowColor = .black

           msgTip.tapHandler = { _ in
             print("tap")
           }

           msgTip.tapOutsideHandler = { _ in
             print("tap outside")
           }

           msgTip.swipeOutsideHandler = { _ in
             print("swipe outside")
           }

           msgTip.dismissHandler = { _ in
             print("dismiss")
            
           }
       
        msgTip.actionAnimation = .bounce(5)
    
        msgTip.show(customView: datePickerView, direction: direction, in: view, from: from)
    }
    
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        selectedDate = dateFormatter.string(from: sender.date)
        print("text = \(selectedDate)")

        }
    
    

}








//MARK: UIcolor

extension UIColor {
    static let baseColor = UIColor(red: 68.0/255.0, green: 138.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let activeColor = UIColor(red: 168/255, green: 211/255, blue: 149/255, alpha: 1.0)
    static let pendingColor = UIColor(red: 224/255, green: 207/255, blue: 117/255, alpha: 1.0)
}
