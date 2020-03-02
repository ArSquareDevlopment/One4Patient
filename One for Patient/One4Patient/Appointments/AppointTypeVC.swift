//
//  AppointTypeVC.swift
//  One for Patient
//
//  Created by Idontknow on 22/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit


class AppointTypeVC: UIViewController {

    @IBOutlet weak var appointTypeSC: UISegmentedControl!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var reasonTxtV: UITextView!
    @IBOutlet weak var visitedLbl: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var userIMGView: UIImageView!
    
    
    @IBOutlet weak var emergencySC: UISegmentedControl!
    
    var appointmentType = ""
    var id = ""
    var emergency:Bool = false
    var symptoms = [[String:Any]]()
    var checked:Bool = false
    var picker = UIPickerView()
    var addedSymptoms:[String] = []
    var sendUser = "PatientUserId"
    var sendID = GlobalVariables.accountID
    override func viewDidLoad() {
        super.viewDidLoad()

       viewChanges()
        print("GSym = \(GlobalVariables.savedSymptoms)")
        print(" added Symp = \(GlobalVariables.addedSymptoms)")
    }
    
    
    func viewChanges() {
        profileView.elevate(elevation: 5.0)
        profileView.layer.cornerRadius = 10
        userIMGView.makeRound()
        profileView.layer.cornerRadius = 10
        bookBtn.layer.cornerRadius = 10
        reasonTxtV.layer.cornerRadius = 10
        reasonTxtV.layer.borderWidth = 0.5
        reasonTxtV.layer.borderColor = UIColor.black.cgColor
      
        picker.backgroundColor = .white
        picker.tintColor = .baseColor
        if BookingFor.isUserSelected == true {
        nameLbl.text = BookingFor.userName
        IDLbl.text = BookingFor.userEmail
        } else {
            nameLbl.text = GlobalVariables.userName
            IDLbl.text = GlobalVariables.userEmail
        }
    }
    
    
    
    @IBAction func typeAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
        appointmentType = "VIDEO"
        } else if sender.selectedSegmentIndex == 1 {
        appointmentType = "AUDIO"
        } else {
        appointmentType = "CHAT"
        }
    }
    
    func postData() {
        if GlobalVariables.savedSymptoms.isEmpty == false {
        for i in GlobalVariables.savedSymptoms {
        let symptomsList = ["id":i as Any, "Checked":true]
        print("symptomsList = \(symptomsList)")
        symptoms.append(symptomsList)
        print("SendSymptoms = \(symptoms)")
        }
        } else {
        print("No saved Symptoms")
        }
        
//        if GlobalVariables.addedSymptoms.isEmpty == false {
//            for i in GlobalVariables.addedSymptoms {
//                addedSymptoms.append(i)
//            }
//        }

        let slotMap = ["SpecialistWeeklyScheduleTimeSlotMapId":GlobalVariables.timeSlot  as Any, "Checked":true as Any] as [String:Any]
         playLottie(fileName: "heartBeat")

        if BookingFor.isUserSelected == true {
            sendUser = "MemberPatientUserId"
            sendID = BookingFor.userId
        } 
         
        let details = [sendUser:sendID as Any, "MedicalSpecialityId":GlobalVariables.specialityID as Any,  "SpecialistUserId":GlobalVariables.specialistID as Any,  "DateOfAppointment":GlobalVariables.appointmentDate as Any,  "TimeSlots":[slotMap] as Any, "IsEmergency":emergency as Any,  "ReasonForAppointment":reasonTxtV.text! as Any, "PreferredModeOfContact":appointmentType as Any, "MasterSymptoms":symptoms as Any ] as [String:Any]
        ApiService.callPostToken(url: ClientInterface.postAppoinmentUrl, params: details, methodType: "POST", tag: "BookAppointment", finish:finishPost)
        print("details = \(details)")

                
    }
    
            
    func finishPost (message:String, data:Data? , tag: String) -> Void {

    stopLottie()
        do {
    if let jsonData = data {
    let parsedData = try JSONDecoder().decode(AppointmentResponse.self, from: jsonData)
    print(parsedData)
    if parsedData.statusCode == 200 {
    reasonTxtV.text = ""
    appointTypeSC.selectedSegmentIndex = -1
    emergencySC.selectedSegmentIndex = -1
        
    GlobalVariables.appointmentID = "\(parsedData.result.AppointmentId!)"
    print("SavedAppID = \(GlobalVariables.appointmentID)")
    print("GotAppID = \(parsedData.result.AppointmentId)")
    
    
        GlobalVariables.viewAppointments = true
    let VC  = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetailsVC") as! AppointmentDetailsVC
        
    self.navigationController?.pushViewController(VC, animated: true)
        popUpAlert(title: "Success", message: "Appointment Created ", action: .alert)

    } else {
    popUpAlert(title: "Alert", message: "Error in Booking Appointment ", action: .alert)
    }
    } else {
    popUpAlert(title: "Alert", message: "Error in Booking Appointment ", action: .alert)
    }
    } catch {
    popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
    print("Parse Error: \(error)")
    }
    }
        
    

    @IBAction func backBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func emergencySC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
        emergency = true
        } else {
        emergency = false
        }
    }
    
    @IBAction func nextAxn(_ sender: UIButton) {
        
        if appointTypeSC.selectedSegmentIndex != 0 &&
        appointTypeSC.selectedSegmentIndex != 1 && appointTypeSC.selectedSegmentIndex != 2 {
        popUpAlert(title: "Alert", message: "Select Appoinment Type.!", action: .alert)
        } else if reasonTxtV.text.isEmpty == true {
        popUpAlert(title: "Alert", message: "Enter reason of appointment", action: .alert)
        } else if reach.isConnectedToNetwork() == true {
        postData()
           

        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
    }
    
    
    
    
    
    
}

    
    
    
    

