//
//  MeetingRoomVC.swift
//  One for Patient
//
//  Created by AnnantaSource on 17/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit
import WebKit

class MeetingRoomVC: UIViewController {
    
    @IBOutlet weak var menuBtn: UIButton!
    
    
    @IBOutlet weak var videoBtn: UIButton!
    
    var zoomPass = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomPassword()
       

    }
    
    func zoomPassword() {
        if ZoomDetails.ZoomUrl.isEmpty == false {
     let splitStr = ZoomDetails.ZoomUrl.split(separator: "=")
        zoomPass = String(splitStr[1])
        print("splitStr = \(splitStr)")
        print("zoomPass = \(zoomPass)")
        print("ZoomId = \(ZoomDetails.ZoomID)")
        } else {
            print("No Url ")
        }
    }
    
    @IBAction func videoBtnAxn(_ sender: UIButton) {
        if ZoomDetails.ZoomUrl.isEmpty == false {
        ZoomService.sharedInstance.joinMeeting(name: GlobalVariables.userName, number: Int(ZoomDetails.ZoomID)!, password: zoomPass)
        } else {
            popUpAlert(title: "Alert", message: "Can't MAke Connection. Check Details", action: .actionSheet)
        }
    }
    
    
    
    @IBAction func backBtnAxn(_ sender: UIButton) {
        
    self.navigationController?.popViewController(animated: true)
    }
    
    


}
