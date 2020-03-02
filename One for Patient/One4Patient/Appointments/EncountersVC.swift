//
//  EncountersVC.swift
//  One for Patient
//
//  Created by AnnantaSource on 17/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class EncountersVC: UIViewController {
    
    @IBOutlet weak var dataTV: UITableView!
    
    
    
    @IBOutlet weak var backBtn: UIButton!
    
    
    
    var dataArray:[EncounterResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        dataTV.rowHeight = 120
        getData()
    }
    
    
    @IBAction func backAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    func getData() {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        ApiService.callPostToken(url: ClientInterface.getEncountersList + "\(GlobalVariables.appointmentID)", params: "", methodType: "GET", tag: "GetAppointment", finish:finishPost)
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
    }
        
        
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        stopLottie()
       
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(EncountersListResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.statusCode == 200 {
            if parsedData.result.isEmpty == false {
            dataArray = parsedData.result
            dataTV.reloadWithAnimation()
            } else {
                print("No List")
            }
        } else {
        popUpAlert(title: "Alert", message: "Error in Getting  EncountersList. Check Details.!", action: .alert)
        }
        } else {

        popUpAlert(title: "Alert", message: "Error in Getting  EncountersList. Check Details.!", action: .alert)        }
        } catch {
        popUpAlert(title: "Alert", message: "Error in Getting  EncountersList. Check Details.!", action: .alert)
            print("Parse Error: \(error)")
        }
                       
       }
    
    
    
}
extension EncountersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EncountersListTC
        let cellItem = dataArray[indexPath.row]
        cell.statusLbl.makeRound()
        
        switch cellItem.encounterStatus {
        case 1:
            if GlobalVariables.appointmentStatus == 1 {
                cell.statusLbl.text = "Active"
                cell.roomBtn.isHidden = false

            } else {
                cell.statusLbl.text = "Closed"
                cell.roomBtn.isHidden = true 

            }
        case 2:
        cell.statusLbl.text = "Closed"
        cell.roomBtn.isHidden = true 

        default:
            break
        }
        
        cell.titleLbl.text = cellItem.displayID
        if GlobalVariables.isDoctor == true {
            cell.SPNameLbl.text = GlobalVariables.userName
            cell.patientNameLbl.text = GlobalVariables.patientName
        } else {
            cell.patientNameLbl.text = GlobalVariables.userName
            cell.SPNameLbl.text = GlobalVariables.SPName

        }
        cell.IDLbl.text = "\(cellItem.id)"
        cell.chatDetailsBtn.tag = indexPath.row
        cell.notesDetailsBtn.tag = indexPath.row
        cell.roomBtn.tag = indexPath.row

        cell.chatDetailsBtn.addTarget(self, action: #selector(onChatBtnTapped), for: .touchUpInside)
        cell.notesDetailsBtn.addTarget(self, action: #selector(onNotesBtnTapped(_:)), for: .touchUpInside)
        cell.roomBtn.addTarget(self, action: #selector(onRoomBtnTapped(_:)), for: .touchUpInside)
        cell.dataView.layer.cornerRadius = 10
        cell.contentView.layer.borderColor = UIColor.baseColor.cgColor
        cell.contentView.layer.borderWidth = 1.0
        cell.roomBtn.layer.cornerRadius = 10
        cell.chatDetailsBtn.layer.cornerRadius = 10
        cell.notesDetailsBtn.layer.cornerRadius = 10

        
        
        return cell
    }
    
    
    
    
    
    @objc func onChatBtnTapped(_ sender: UIButton){
           print("tag = \(sender.tag)")
        if let tableView = dataTV {
        let point = tableView.convert(sender.center, from: sender.superview!)
        if let wantedIndexPath = tableView.indexPathForRow(at: point) {
        let cell = tableView.cellForRow(at: wantedIndexPath) as! EncountersListTC
            print(cell.titleLbl.text!)
    }
    }
    }
    @objc func onNotesBtnTapped(_ sender: UIButton){
              print("tag = \(sender.tag)")
           if let tableView = dataTV {
           let point = tableView.convert(sender.center, from: sender.superview!)
           if let wantedIndexPath = tableView.indexPathForRow(at: point) {
           let cell = tableView.cellForRow(at: wantedIndexPath) as! EncountersListTC
               print(cell.titleLbl.text!)
    }
    }
    }
    @objc func onRoomBtnTapped(_ sender: UIButton){
              print("tag = \(sender.tag)")
           if let tableView = dataTV {
           let point = tableView.convert(sender.center, from: sender.superview!)
           if let wantedIndexPath = tableView.indexPathForRow(at: point) {
           let cell = tableView.cellForRow(at: wantedIndexPath) as! EncountersListTC
               print(cell.titleLbl.text!)
            print("Meeting Room")
            if cell.statusLbl.text == "Active" {
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "MeetingRoomVC") as! MeetingRoomVC
        self.navigationController?.pushViewController(VC, animated: true)
            } else {
                popUpAlert(title: "Alert", message: "This Meeting is Not Active", action: .alert)
            }
    }
    }
    }
    
    
    
    
}
