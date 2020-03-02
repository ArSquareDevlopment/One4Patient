//
//  SPAppointmentDetailsVC.swift
//  One for Patient
//
//  Created by Idontknow on 20/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SPAppointmentDetailsVC: UIViewController {
    
    @IBOutlet weak var contactLbl: UILabel!
    @IBOutlet weak var appDisplayID: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userIMGView: UIImageView!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var emergencyLbl: UILabel!
    @IBOutlet weak var reasonTF: UITextField!
    @IBOutlet weak var symptomsCV: UICollectionView!
    @IBOutlet weak var viewEncounters: UIButton!
    @IBOutlet weak var encountersList: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var connectSV: UIStackView!
    @IBOutlet weak var encountersSV: UIStackView!
    @IBOutlet weak var buttonsSV: UIStackView!
    
    @IBOutlet weak var activeEncounterLbl: UILabel!
    
    @IBOutlet weak var connectBtn: UIButton!
    
    
    
    var dataArray:[AppointmentSymptomMap] = []
    
    var sendStatus = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        getData()
        profileView.layer.cornerRadius = 10
        profileView.elevate(elevation: 3.0)
        userIMGView.makeRound()
        CVChanges()
        statusLbl.layer.cornerRadius = 10
       
        acceptBtn.layer.cornerRadius = 10
        declineBtn.layer.cornerRadius = 10
        closeBtn.layer.cornerRadius = 10
        followBtn.layer.cornerRadius = 10
        connectBtn.layer.cornerRadius = 10
        reasonTF.isHidden = true
        viewEncounters.layer.cornerRadius = 10
       
    }
    
    
    
    @IBAction func connectAxn(_ sender: UIButton) {
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingRoomVC") as! MeetingRoomVC
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
    
    @IBAction func viewEncountersAxn(_ sender: UIButton) {
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EncountersVC") as! EncountersVC
        
        self.navigationController?.pushViewController(VC, animated: true)
        
        
    }
    
    
    
    
    @IBAction func updateAxn(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sendStatus = "1"
            postData()
            
        case 1:
            reasonTF.isHidden = false
            if reasonTF.text?.isEmpty == true {
            popUpAlert(title: "Alert", message: "Please Specify Reason", action: .alert)
            } else {
                sendStatus = "2"
                 postData()
            }
            
        case 2:
            reasonTF.isHidden = false
            if reasonTF.text?.isEmpty == true {
            popUpAlert(title: "Alert", message: "Please Specify Reason", action: .alert)
            } else {
                sendStatus = "4"
                 postData()
            }
            
        case 3:
            reasonTF.isHidden = false
            if reasonTF.text?.isEmpty == true {
            popUpAlert(title: "Alert", message: "Please Specify Reason", action: .alert)
            } else {
                sendStatus = "5"
                 postData()
            }
        default:
            break
        }
    }
    
    
    @IBAction func backAxn(_ sender: UIButton) {
      self.navigationController?.popViewController(animated: true)
    }
    
//    MARK: API Call
    func getData() {
    if reach.isConnectedToNetwork() == true {
        dataArray.removeAll()

    playLottie(fileName: "heartBeat")
        
    ApiService.callPostToken(url: ClientInterface.getAppbyIDUrl + "\(GlobalVariables.appointmentID)", params: "", methodType: "GET", tag: "GetAppointment", finish:finishPost)
    } else {
    popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
    }
    }
    
    func postData() {
        
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        let details = ["AppointmentStatus":sendStatus as Any, "StatusMessage":reasonTF.text!] as [String:Any]
        ApiService.callPostToken(url: ClientInterface.EditAppStatusUrl, params: details, methodType: "POST", tag: "EditStatus", finish:finishPost)
        print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
    }
    
       
//       MARK: API Response
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()

        if tag == "EditStatus" {
            
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(EditAppStatusResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        popUpAlert(title: "Success", message: "Appoinment Status Updated successfully", action: .alert)
        reasonTF.text = ""
        reasonTF.isHidden = true
        getData()
            
        } else {
        popUpAlert(title: "Alert", message: "Error in Updating Appointment. Check Details.!", action: .alert)
        }
        } else {
        popUpAlert(title: "Alert", message: "Error in Updating Appointment. Check Details.!", action: .alert)
        }
        } catch {
          popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
                print("Parse Error: \(error)")
        }
            
        } else {
                
           do {
           if let jsonData = data {
                               
           let parsedData = try JSONDecoder().decode(SingleAppoinmentResponse.self, from: jsonData)
           print(parsedData)
           if parsedData.statusCode == 200 {
            appDisplayID.text = parsedData.result.displayID
            statusLbl.makeRound()

            symptomsCV.reloadData()
            print("AppID = \(parsedData.result.id)")
            dataArray = parsedData.result.appointmentSymptomMaps
            nameLbl.text = parsedData.result.patient.userName!
            contactLbl.text = "Mode of Contact:  \(parsedData.result.preferredModeOfContact)"
            if parsedData.result.isEmergency == true {
                emergencyLbl.text = "IS Emergency : YES"
            } else {
                emergencyLbl.text = "IS Emergency : NO"
             }
            
            GlobalVariables.patientName = parsedData.result.patient.userName!
            
            GlobalVariables.appointmentStatus = parsedData.result.currentStatus
             print("Appointment Status = \(String(describing: GlobalVariables.appointmentStatus))")
            
            encountersList.text = "\(parsedData.result.encounters.count)"
           
            for list in parsedData.result.encounters {
                if  list.EncounterStatus == 1 {
                    activeEncounterLbl.text = list.DisplayId!
                    connectBtn.isHidden = false
                    ZoomDetails.ZoomID = "\(list.Zoom_id!)"
                    ZoomDetails.ZoomUrl = list.Zoom_join_url!
                    
                } else {
                    ZoomDetails.ZoomID = ""
                    ZoomDetails.ZoomUrl = ""
                    activeEncounterLbl.text = "00"
                    activeEncounterLbl.textColor = .red
                    connectBtn.isHidden = true

                    
                }
            }
            
            switch parsedData.result.currentStatus {
            case 0:
                statusLbl.text = "Queued"
                acceptBtn.isHidden = false
                declineBtn.isHidden = false
                
                closeBtn.isHidden = true
                followBtn.isHidden = true
                encountersSV.isHidden = true
                connectSV.isHidden = true
            case 1:
                statusLbl.text = "Accepted"
                
                acceptBtn.isHidden = true
                declineBtn.isHidden = true
                closeBtn.isHidden = false
                followBtn.isHidden = false 

                encountersSV.isHidden = false
                connectSV.isHidden = false
            case 2:
                statusLbl.text = "Declined"
                encountersSV.isHidden = false
                closeBtn.isHidden = false
                followBtn.isHidden = true

                connectSV.isHidden = true
                acceptBtn.isHidden = true
                declineBtn.isHidden = true
            case 3:
                statusLbl.text = "Cancelled"
                encountersSV.isHidden = false
                closeBtn.isHidden = false
                followBtn.isHidden = true

                connectSV.isHidden = true
                acceptBtn.isHidden = true
                declineBtn.isHidden = true
            case 4:
                statusLbl.text = "Closed"
                encountersSV.isHidden = false
                buttonsSV.isHidden = true
            case 5:
                statusLbl.text = "FollowUp"
                encountersSV.isHidden = false
                closeBtn.isHidden = false
                followBtn.isHidden = true

                connectSV.isHidden = true
                acceptBtn.isHidden = true
                declineBtn.isHidden = true
            case 6:
                statusLbl.text = "Pooled"
                encountersSV.isHidden = false
                closeBtn.isHidden = false
                followBtn.isHidden = false

                connectSV.isHidden = true
                acceptBtn.isHidden = true
                declineBtn.isHidden = true
            case 7:
                statusLbl.text = "PopFromPool"
                encountersSV.isHidden = false
                closeBtn.isHidden = false
                followBtn.isHidden = false

                connectSV.isHidden = true
                acceptBtn.isHidden = true
                declineBtn.isHidden = true

            case 8:
                statusLbl.text = "PushToPool"
                encountersSV.isHidden = false
                closeBtn.isHidden = false
                followBtn.isHidden = false

                connectSV.isHidden = true
                acceptBtn.isHidden = true
                declineBtn.isHidden = true
            default:
                break
        }
            
            let dateStr = parsedData.result.dateOfAppointment.prefix(10)
               dateLbl.text = "\(dateStr)"
            let timeStr = parsedData.result.startTimeOfAppointment.suffix(8)
               timeLbl.text = "\(timeStr)"
               reasonLbl.text = parsedData.result.reasonForAppointment
               symptomsCV.reloadData()
               print("Got Appointment Details")
            
        } else {
           popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
           }
            
       } else {
           popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
           }
       } catch {
           popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
           print("Parse Error: \(error)")
           }
        }
           
    }
       
      
//      MARK: SymptomCV Changes
    func CVChanges() {
       let cellSize = CGSize(width:130 , height:25)
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal //.horizontal
       layout.itemSize = cellSize
       layout.sectionInset = UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 1)
       layout.minimumLineSpacing = 5.0
           layout.minimumInteritemSpacing = 1.0
       symptomsCV.setCollectionViewLayout(layout, animated: true)
       symptomsCV.delegate = self
       symptomsCV.dataSource = self
    }
    
    
    
    

}

extension SPAppointmentDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SymptomsCVC
        let cellPath = dataArray[indexPath.row]
        cell.textLbl.text = cellPath.symptom.name
        
//        let titleLbl = UILabel(frame: CGRect(x: 5, y: 0, width: cell.bounds.size.width, height: 25))
//        titleLbl.textColor = .white
//        titleLbl.text = "\(cellPath.symptom.name)"
//        titleLbl.font = UIFont(name: "Baskerville", size: 14)
//        cell.contentView.addSubview(titleLbl)
        cell.contentView.layer.cornerRadius = 10
        return cell
    }
    
    
    
    
    
    
    
}
