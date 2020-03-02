//
//  MedicationVC.swift
//  One for Patient
//
//  Created by Idontknow on 31/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class MedicationVC: UIViewController {
    @IBOutlet weak var strengthTF: UITextField!
    @IBOutlet weak var powerSC: UISegmentedControl!
    @IBOutlet weak var scheduleTF: UITextField!
    @IBOutlet weak var MTypeSC: UISegmentedControl!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet var addMView: UIView!
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var infoTxtView: UITextView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet var notifyView: UIView!
    var scheduleList = ["Before BreakFast","After BreakFast","Before Lunch","After Lunch","Before Dinner","After Dinner",]
    var scheduleId = ""
    var schedulePicker = UIPickerView()
    var dataArray:[MedicationResult] = []
    var MType = "0"
    var unitType = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       viewChanges()
    }
    
    func viewChanges() {
        dataTV.rowHeight = 140
        self.view.addSubview(addMView)
        addMView.frame = CGRect(x: 20, y: 100, width: Int(self.view.bounds.width) - 40, height: 380)
        addMView.isHidden = true
        addMView.elevate(elevation: 10.0)
        addMView.layer.cornerRadius = 10
        addBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        schedulePicker.delegate = self
        schedulePicker.dataSource = self
        scheduleTF.withImage(direction: .Right, image: #imageLiteral(resourceName: "down"))
        schedulePicker.backgroundColor = .groupTableViewBackground
        hideKeyboardWhenTappedAround()
        infoTxtView.layer.cornerRadius = 10
        
        self.view.addSubview(notifyView)
        notifyView.center = self.view.center
        notifyView.isHidden = true
    }

    

    
    @IBAction func scheduleAxn(_ sender: UITextField) {
        sender.inputView = schedulePicker
    }
    
    
    @IBAction func unitTypeAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            unitType = "1"
        } else {
            unitType = "0"
        }
    }
    
    @IBAction func MTypeAxn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
        MType = "0"
            
        case 1:
        MType = "1"
            
        case 2:
        MType = "2"
        default:
            break
        }
        
    }
    
    @IBAction func cancelAxn(_ sender: UIButton) {
        addMView.isHidden = true
        if dataTV.isHidden == true {
            notifyView.isHidden = false
        } else {
            notifyView.isHidden = true

        }
    }
    
    
    @IBAction func addAxn(_ sender: UIButton) {
        if titleTF.text?.isEmpty == true || scheduleTF.text == "" || strengthTF.text == "" || infoTxtView.text == "" {
            popUpAlert(title: "Alert", message: "Enter All Details", action: .alert)
            
        } else {
            postData()
        }
        
    }
    
    
    
    @IBAction func plusAxn(_ sender: UIButton) {
        
        addMView.isHidden = false
        notifyView.isHidden = true

    }
    
  
    
    
    
    override func viewWillAppear(_ animated: Bool) {
                getData()

    }
    
    
    func getData()  {
       if reach.isConnectedToNetwork() == true {
       playLottie(fileName: "heartBeat")
        notifyView.isHidden = true

       ApiService.callPostToken(url: ClientInterface.medicationUrl, params: "", methodType: "GET", tag: "MedicationDetails", finish:finishPost)
       
       } else {
       popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                  
       }
    }
    
    func postData()  {
       if reach.isConnectedToNetwork() == true {
       playLottie(fileName: "heartBeat")

        let details = ["PatientUserId":GlobalVariables.accountID as Any,"Name":titleTF.text! as Any, "Schedule":scheduleId as Any,"MedicineNature":MType as Any,"StrengthValue":strengthTF.text! as Any,"StrengthUnit":unitType as Any,"ExtraInfo":infoTxtView.text! as Any] as [String:Any]
       ApiService.callPostToken(url: ClientInterface.medicationUrl, params: details, methodType: "POST", tag: "AddMedication", finish:finishPost)
       print("details = \(details)")
       } else {
       popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                  
       }
    }
          
          
       func finishPost (message:String, data:Data? , tag: String) -> Void {
           
           stopLottie()
           
        if tag == "DelMedication" || tag == "AddMedication" {
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
            print(parsedData)
            if parsedData.StatusCode == 200 {
                if tag == "DelMedication" {
                popUpAlert(title: "Alert", message: "Medication Details Deleted", action: .alert)
                } else {
                    popUpAlert(title: "Success", message: "Medication Added ", action: .alert)
                }
                getData()

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
            
        } else {
        
        
           do {
           if let jsonData = data {
           let parsedData = try JSONDecoder().decode(MedicationResponse.self, from: jsonData)
           print(parsedData)
           if parsedData.statusCode == 200 {
            print("Got Medication Details")
            if parsedData.result.isEmpty == true {
                dataTV.isHidden = true
                notifyView.isHidden = false
            } else {
            addMView.isHidden = true
                dataTV.isHidden = false
            dataArray = parsedData.result
            dataTV.reloadWithAnimation()
            }
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
    
    
    
    
    
   
}

extension MedicationVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MedicationTC
        let cellPath = dataArray[indexPath.row]
        
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
        cell.titleLbl.text = cellPath.name
        cell.descriptionLbl.text = "Info : \(cellPath.extraInfo ?? "")"
        cell.IDLbl.text = "\(cellPath.id)"
        cell.MStrengthLbl.text = cellPath.strengthValue
        if cellPath.strengthUnit == "1" {
            cell.MUnitLbl.text = "ml"
            
        } else {
        cell.MUnitLbl.text = "mg"

        }
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(onTappedBtn(_:)), for: .touchUpInside)
        
        switch cellPath.schedule {
        case 0:
        cell.scheduleLbl.text = scheduleList[0]
        case 1:
        cell.scheduleLbl.text = scheduleList[1]
        case 2:
        cell.scheduleLbl.text = scheduleList[2]
        case 3:
        cell.scheduleLbl.text = scheduleList[3]
        case 4:
        cell.scheduleLbl.text = scheduleList[4]
        case 5:
        cell.scheduleLbl.text = scheduleList[5]
       
        default:
            
        cell.scheduleLbl.text = scheduleList[0]
        }
        
        switch cellPath.medicineNature {
        case 0:
            cell.MTypeLbl.text = "Capsule"
        case 1:
            cell.MTypeLbl.text = "Tonic"
        case 2:
            cell.MTypeLbl.text = "Powder"
        default:
            break
        }
        cell.dataView.elevate(elevation: 5.0)
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.layer.borderWidth = 1.0
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor

        
        cell.deleteBtn.addTarget(self, action: #selector(onTappedBtn(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    
    
    @objc func onTappedBtn(_ sender: UIButton) {
        if reach.isConnectedToNetwork() == true {
        self.dataArray.remove(at: sender.tag)
        if let tableView = dataTV {
        let point = tableView.convert(sender.center, from: sender.superview!)
        if let wantedIndexPath = tableView.indexPathForRow(at: point) {
        let cell = tableView.cellForRow(at: wantedIndexPath) as! MedicationTC
          GlobalVariables.medicationID = cell.IDLbl.text!
              print("Global medicationID  = \(GlobalVariables.medicationID)")

            playLottie(fileName: "heartBeat")
        ApiService.callPostToken(url:ClientInterface.deleteMedicationUrl + "\(GlobalVariables.medicationID)", params: "", methodType: "GET", tag: "DelMedication", finish:finishPost)
         }
         }
         } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
    }

    
    
    
    
    
    
    
    
}

extension MedicationVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scheduleList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return scheduleList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scheduleTF.text = scheduleList[row]
        switch row {
        case 0:
            scheduleId = "0"
            print("selected Schedule = \(scheduleId)")
        case 1:
        scheduleId = "1"
            print("selected Schedule = \(scheduleId)")

        case 2:
        scheduleId = "2"
            print("selected Schedule = \(scheduleId)")

        case 3:
        scheduleId = "3"
            print("selected Schedule = \(scheduleId)")

        case 4:
        scheduleId = "4"
            print("selected Schedule = \(scheduleId)")

        case 5:
        scheduleId = "5"
            print("selected Schedule = \(scheduleId)")

        default:
            break
        }
    }
    
    
    
}
