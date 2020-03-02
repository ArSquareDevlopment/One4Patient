//
//  MConditionsVC.swift
//  One for Patient
//
//  Created by Idontknow on 01/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class MConditionsVC: UIViewController {
    
    
    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var stateSC: UISegmentedControl!
    
    @IBOutlet weak var infoTxtView: UITextView!
    @IBOutlet weak var fromTF: UITextField!
    
    @IBOutlet weak var timeTypeSC: UISegmentedControl!
    
    @IBOutlet var notifyView: UIView!
    @IBOutlet var addMCView: UIView!
    var dataArray:[MConditionResult] = []
    var MConditionType = "0"
    var sendUserType = "PatientUserId"
    var timeType = "Weeks"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    func viewChanges() {
        dataTV.rowHeight = 120
        self.view.addSubview(addMCView)
       
        addMCView.frame = CGRect(x: 20, y: 100, width: Int(self.view.bounds.width) - 40, height: 300)
        addMCView.isHidden = true
        addMCView.elevate(elevation: 10.0)
        addMCView.layer.cornerRadius = 10
        saveBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        hideKeyboardWhenTappedAround()
        infoTxtView.layer.cornerRadius = 10
        self.view.addSubview(notifyView)
        notifyView.center = view.center
        notifyView.isHidden =  true 
    }
    
    
    @IBAction func plusAxn(_ sender: UIButton) {
        
        addMCView.isHidden = false
        notifyView.isHidden = true
    }
    
    @IBAction func cancelBtnAxn(_ sender: UIButton) {
        addMCView.isHidden = true
        if dataTV.isHidden == true {
        notifyView.isHidden = false
        } else {
        notifyView.isHidden = true

        }
        
    }
    
    
    
    @IBAction func saveAxn(_ sender: UIButton) {
         if titleTF.text == "" || fromTF.text == "" || infoTxtView.text == "" {
            popUpAlert(title: "Alert", message: "Enter All Details", action: .alert)
        } else if stateSC.selectedSegmentIndex == 0 && stateSC.selectedSegmentIndex == 1  {
            popUpAlert(title: "Alert", message: "Select Medical Condition Type ", action: .alert)
        } else if timeTypeSC.selectedSegmentIndex == 0 && timeTypeSC.selectedSegmentIndex == 1 && timeTypeSC.selectedSegmentIndex == 2 {
        popUpAlert(title: "Alert", message: "Select TimePeriod Type", action: .alert)
        } else  {
        postData()
        }
        
 }
    
    @IBAction func timeTypeSC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            timeType = "Months"
        } else if sender.selectedSegmentIndex == 2 {
            timeType = "Years"
        } else{
            timeType = "Weeks"
        }
    }
    
    @IBAction func stateTypeSC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            MConditionType = "1"
        } else {
            MConditionType = "0"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()

        }
        
    
    func getData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
            notifyView.isHidden = true
        
        ApiService.callPostToken(url: ClientInterface.MConditionUrl, params: "", methodType: "GET", tag: "MConditionDetails", finish:finishPost)
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                          
        }
    }
            
    func postData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")

    let details = [sendUserType:GlobalVariables.accountID as Any,"Condition":titleTF.text! as Any, "Type":MConditionType as Any,"PeriodValue":fromTF.text! as Any,"PeriodUnit":timeType as Any,"Description":infoTxtView.text! as Any] as [String:Any]
     
    ApiService.callPostToken(url: ClientInterface.MConditionUrl, params: details, methodType: "POST", tag: "AddMCondition", finish:finishPost)
            print("details = \(details)")
    } else {
    popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                          
        }
    }
                  
                  
    func finishPost (message:String, data:Data? , tag: String) -> Void {
                   
        stopLottie()
                   
        if tag == "DelMCondition" || tag == "AddMCondition" {
        
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
                print(parsedData)
            if parsedData.StatusCode == 200 {
                if tag == "DelMCondition" {
                popUpAlert(title: "Alert", message: "Medical Condition Deleted", action: .alert)
                } else {
                popUpAlert(title: "Success", message: "Medical Condition Added ", action: .alert)
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
                let parsedData = try JSONDecoder().decode(MConditionResponse.self, from: jsonData)
                print(parsedData)
                if parsedData.statusCode == 200 {
                print("Got Medication Details")
                    titleTF.text = ""
                    stateSC.selectedSegmentIndex = -1
                    timeTypeSC.selectedSegmentIndex = -1
                    fromTF.text = ""
                    infoTxtView.text = ""
                    addMCView.isHidden = true
                    if parsedData.result.isEmpty == true {
                        dataTV.isHidden = true
                        notifyView.isHidden = false
                    } else {
                dataTV.isHidden = false
                notifyView.isHidden = true 
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

extension MConditionsVC: UITableViewDataSource, UITableViewDelegate {
           
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return dataArray.count
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MConditionTC
                let cellPath = dataArray[indexPath.row]
                
               
        
        cell.nameLbl.text = cellPath.condition
        cell.InfoLbl.text = "Info: \( cellPath.Description)"
        cell.IDLbl.text = "\(cellPath.id)"
        cell.timeTypeLbl.text = cellPath.periodUnit
        cell.fromLbl.text = "\(cellPath.periodValue)"
                
        switch cellPath.type {
        case 0:
            cell.MConditionTypeLbl.text = "Past"
            
        case 1:
            cell.MConditionTypeLbl.text = "Present"
            
       
        default:
            cell.MConditionTypeLbl.text = "Past"

        }
               
                
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(onTappedBtn(_:)), for: .touchUpInside)
                
                
        cell.dataView.elevate(elevation: 5.0)
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.layer.borderWidth = 1.0
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
       
        return cell
        
    }
            
            
        @objc func onTappedBtn(_ sender: UIButton) {
        
            if reach.isConnectedToNetwork() == true {
            self.dataArray.remove(at: sender.tag)
            if let tableView = dataTV {
            let point = tableView.convert(sender.center, from: sender.superview!)
            if let wantedIndexPath = tableView.indexPathForRow(at: point) {
            let cell = tableView.cellForRow(at: wantedIndexPath) as! MConditionTC
            
            GlobalVariables.MConditionID = cell.IDLbl.text!
            print("Global MConditionID  = \(GlobalVariables.MConditionID)")
             playLottie(fileName: "heartBeat")
        ApiService.callPostToken(url:ClientInterface.deleteMConditionUrl + "\(GlobalVariables.MConditionID)", params: "", methodType: "GET", tag: "DelMCondition", finish:finishPost)
            }
            }
            } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
            }
                
            }

    }


