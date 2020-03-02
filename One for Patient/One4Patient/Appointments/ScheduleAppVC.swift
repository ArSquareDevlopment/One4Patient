//
//  ScheduleAppVC.swift
//  One for Patient
//
//  Created by Idontknow on 22/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit


class ScheduleAppVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var visitedLbl: UILabel!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var time0Btn: UIButton!
    @IBOutlet weak var time1Btn: UIButton!
    @IBOutlet weak var slotSC: UISegmentedControl!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var time2Btn: UIButton!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var time8Btn: UIButton!
    @IBOutlet weak var time7Btn: UIButton!
    @IBOutlet weak var time6Btn: UIButton!
    @IBOutlet weak var time5Btn: UIButton!
    @IBOutlet weak var time4Btn: UIButton!
    @IBOutlet weak var time3Btn: UIButton!
    var selectedTime = String()
    var selectedButton: UIButton? = nil
    var dataArray:[TimeResult] = []
    let todaydate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

       ViewChanges()
        print("GSym = \(GlobalVariables.savedSymptoms)")

    }
    func ViewChanges(){
        profileView.elevate(elevation: 5.0)
        userImgView.makeRound()
        profileView.layer.cornerRadius = 10
        nextBtn.layer.cornerRadius = 10
        view.backgroundColor = .baseColor
        dateTF.withImage(direction: .Right, image: UIImage(named: "down")!)
        time0Btn.layer.cornerRadius = 10
        time1Btn.layer.cornerRadius = 10
        time2Btn.layer.cornerRadius = 10
        time3Btn.layer.cornerRadius = 10
        time4Btn.layer.cornerRadius = 10
        time5Btn.layer.cornerRadius = 10
        time6Btn.layer.cornerRadius = 10
        time7Btn.layer.cornerRadius = 10
        time8Btn.layer.cornerRadius = 10
        slotSC.layer.cornerRadius = 20
        dateTF.layer.cornerRadius = 10
      if BookingFor.isUserSelected == true {
           nameLbl.text = BookingFor.userName
           IDLbl.text = BookingFor.userEmail
       } else {
           nameLbl.text = GlobalVariables.userName
           IDLbl.text = GlobalVariables.userEmail
       }
        
        
        dateTF.text = "\(getCurrentDateString())"
    }

    @IBAction func dateTFAct(_ sender: UITextField) {
        sender.futureDatePicker()


    }
    
   
    
    @IBAction func timeBtnAxn(_ sender: UIButton) {
    selectedTime = "\(sender.tag)"
    print("selectedTime = \(selectedTime)")
        
    if(selectedButton == nil){
    // No previous button was selected
      updateButtonSelection(sender)
       
    }else {
    // User have already selected a button
     if(selectedButton != sender) {
    // Not the same button
     selectedButton?.backgroundColor = .clear
     updateButtonSelection(sender)
         }
       }
    }
    
    func updateButtonSelection(_ sender: UIButton){
        selectedButton = sender
        selectedButton?.backgroundColor = .baseColor
        selectedButton?.tintColor = .white
        }
    
    @IBAction func nextAxn(_ sender: UIButton) {
        if dateTF.text?.isEmpty ==  true   {
            popUpAlert(title: "Alert", message: "Select Date", action: .alert)
        } else if slotSC.selectedSegmentIndex != 0 && slotSC.selectedSegmentIndex != 1 && slotSC.selectedSegmentIndex != 2   || selectedTime.isEmpty == true {
            popUpAlert(title: "Alert", message: "Select Slot and Time", action: .alert)
        } else if reach.isConnectedToNetwork() == true {
            AppointmentInfo.setAppDate(type: dateTF.text!)
            AppointmentInfo.setAppTime(type: selectedTime)
            GlobalVariables.timeSlot = selectedTime
            GlobalVariables.appointmentDate = dateTF.text!
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AppointTypeVC") as! AppointTypeVC
            
        self.navigationController?.pushViewController(VC, animated: true)
        
        }
        
        
    }
    
    
    
    @IBAction func backBtnAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getData()  {
             ApiService.callPostToken(url: ClientInterface.getSplbySpltyUrl, params: "", methodType: "GET", tag: "SplDoc", finish:finishPost)
         }
    
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        do {
        if let jsonData = data {
                
        let parsedData = try JSONDecoder().decode(getTimeslotResponse.self, from: jsonData)
                print(parsedData)
                
        if parsedData.StatusCode == 200 {
        dataArray = parsedData.Result
                    
//                    self.dataTV.reloadWithAnimation()
        } else {
        popUpAlert(title: "Alert", message: "Error in Getting Data ", action: .alert)
        }
        } else {
        popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
        }
        } catch {
        popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)

            print("Parse Error: \(error)")
        }
    }

    
}
