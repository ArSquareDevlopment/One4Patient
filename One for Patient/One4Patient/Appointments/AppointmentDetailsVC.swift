//
//  AppointmentDetailsVC.swift
//  One for Patient
//
//  Created by Idontknow on 23/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class AppointmentDetailsVC: UIViewController {
    
    
    
    @IBOutlet weak var displayIDLbl: UILabel!
    
    @IBOutlet weak var activeLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var docIMGView: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var docTypeLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var docNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var symptomsCV: UICollectionView!
    @IBOutlet weak var specialistView: UIView!
    @IBOutlet weak var appTypeLbl1: UILabel!
    @IBOutlet weak var emergencyLbl: UILabel!
    
    @IBOutlet weak var connectSV: UIStackView!
    @IBOutlet weak var encountersLbl: UILabel!
    
    @IBOutlet weak var viewCountersBtn: UIButton!
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    
    @IBOutlet weak var cancelTF: UITextField!
    
    var dataArray:[AppointmentSymptomMap] = []
    var encounterList:[Encounter] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
        CVChanges()
        getData()
    }
    
    func viewChanges() {
        
        docIMGView.makeRound()
        statusLbl.makeRound()
        cancelBtn.layer.cornerRadius = 10
        specialistView.elevate(elevation: 3.0)
        specialistView.layer.cornerRadius = 10
        viewBtn.layer.cornerRadius = 10
        viewCountersBtn.layer.cornerRadius = 10
        connectBtn.layer.cornerRadius = 10
    }
        

    
     func postData() {
            
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        let details = ["AppointmentStatus":"3" as Any, "StatusMessage":cancelTF.text!] as [String:Any]
        ApiService.callPostToken(url: ClientInterface.EditAppStatusUrl, params: details, methodType: "POST", tag: "EditStatus", finish:finishPost)
        print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
            
   }
        
     func getData() {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        ApiService.callPostToken(url: ClientInterface.getAppbyIDUrl + "\(GlobalVariables.appointmentID)", params: "", methodType: "GET", tag: "GetAppointment", finish:finishPost)
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
    }
        
        
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        stopLottie()
        if tag == "EditStatus" {
                       
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(EditAppStatusResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        popUpAlert(title: "Success", message: "Appoinment Status Updated successfully", action: .alert)
        cancelTF.text = ""
        symptomsCV.reloadData()
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
                encounterList = parsedData.result.encounters
                
                for list in encounterList {
                    if list.EncounterStatus == 1 {
                        activeLbl.text = list.DisplayId!
                    } else {
                        activeLbl.text = "0"

                    }
                }
                
                encountersLbl.text = "\(encounterList.count)"
                if  encounterList.last?.Zoom_id != nil {
                ZoomDetails.ZoomID = "\((encounterList.last?.Zoom_id!)!)"
                print("Zoom Id = \(ZoomDetails.ZoomID)")
                } else {
                    print("No Zoom ID")
                }
                if  encounterList.last?.Zoom_join_url != nil {
                ZoomDetails.ZoomUrl = (encounterList.last?.Zoom_join_url!)!
                print("ZoomUrl = \(ZoomDetails.ZoomUrl)")
                } else {
                    print("No Zoom Url")
                }
                GlobalVariables.patientName = parsedData.result.patient.userName!
                GlobalVariables.appointmentStatus = parsedData.result.currentStatus
                print("current Appointemt status = \(GlobalVariables.appointmentStatus)")
                displayIDLbl.text = parsedData.result.displayID
                dataArray = parsedData.result.appointmentSymptomMaps
                docNameLbl.text = parsedData.result.specialist.userName!
                GlobalVariables.SPName = docNameLbl.text!
                
                if parsedData.result.isEmergency == true {
                emergencyLbl.text = "YES"
                emergencyLbl.textColor = .red
                } else {
                 emergencyLbl.text = "NO"
                }
                
            switch parsedData.result.currentStatus {
            case 0:
            statusLbl.text = "Queued"
            connectSV.isHidden = true
            cancelBtn.isHidden = false
            case 1:
                statusLbl.text = "Accepted"
                connectSV.isHidden = false
                cancelBtn.isHidden = false

            case 2:
                        
                statusLbl.text = "Declined"
                connectSV.isHidden = true
                cancelBtn.isHidden = true
            case 3:
                statusLbl.text = "Cancelled"
                connectSV.isHidden = true
                cancelBtn.isHidden = true
            case 4:
                statusLbl.text = "Closed"
                connectSV.isHidden = true
                cancelBtn.isHidden = true
            case 5:
                statusLbl.text = "FollowUp"
                connectSV.isHidden = true
                cancelBtn.isHidden = false
            case 6:
                statusLbl.text = "Pooled"
                connectSV.isHidden = true
                cancelBtn.isHidden = false
            case 7:
                statusLbl.text = "PopFromPool"
                connectSV.isHidden = true
                cancelBtn.isHidden = false
                               
            case 8:
                statusLbl.text = "PushToPool"
                connectSV.isHidden = true
                cancelBtn.isHidden = true
            default:
                statusLbl.backgroundColor = .baseColor
            }
                if parsedData.result.currentStatus != 0 {
                    cancelBtn.isHidden = true
                    cancelTF.isHidden = true
                } 
            appTypeLbl1.text = parsedData.result.preferredModeOfContact
                let date =  parsedData.result.dateOfAppointment.prefix(10)
            dateLbl.text = "\(date)"
                let time = parsedData.result.startTimeOfAppointment.suffix(8)
            timeLbl.text = "\(time)"
                if parsedData.result.reasonForAppointment.isEmpty == false {
                     reasonLbl.text = parsedData.result.reasonForAppointment
                } else {
                     reasonLbl.text = "No Reason "
                }
           
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
        symptomsCV.reloadData()
    }
        
        
    @IBAction func viewENCAxn(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "EncountersVC") as! EncountersVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
        
    @IBAction func backBtnAxn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
        
    }
        

    @IBAction func cancelBtn(_ sender: UIButton) {
        cancelTF.isHidden = false
        if cancelTF.text?.isEmpty == true {
        popUpAlert(title: "Alert", message: "Specify Reason for Cancel", action: .alert)
        } else {
        postData()
            
        }
        
    }
    
    
    
    @IBAction func viewBtnAxn(_ sender: UIButton) {
        let VC  = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func meetingBtnAxn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MeetingRoomVC") as! MeetingRoomVC
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
    
    
    
}

extension AppointmentDetailsVC :  UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataArray.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SymptomsCVC
            cell.contentView.backgroundColor = .baseColor
            cell.deleteBtn.makeRound()
            cell.layer.cornerRadius = 5
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.5
            let cellItem = dataArray[indexPath.row]
            cell.textLbl.text = cellItem.symptom.name
            
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(onBtnTapped(_:)), for: UIControl.Event.touchUpInside)
            
            return cell
    }
        
    @objc func onBtnTapped(_ sender: UIButton){
           print("tag = \(sender.tag)")
           let btnPosition = sender.convert(CGPoint(), to: symptomsCV)
           let index = symptomsCV.indexPathForItem(at: btnPosition)
    //        let indexPath = symptomsCV.indexPathForRow(at:btnPosition)
            
            let currentCell = symptomsCV.cellForItem(at: index!) as! SymptomsCVC
            print("Name = \(String(describing: currentCell.textLbl.text!))")
            dataArray.remove(at: sender.tag)
            symptomsCV.reloadData()
           
            
    }
        
        
        
        
}

   

