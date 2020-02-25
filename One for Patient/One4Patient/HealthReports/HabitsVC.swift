//
//  HabitsVC.swift
//  One for Patient
//
//  Created by Idontknow on 01/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class HabitsVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet var addHView: UIView!
    
    @IBOutlet weak var timeSC: UISegmentedControl!
    
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var infoTxtView: UITextView!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var habitsTypeSC: UISegmentedControl!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    
    
    @IBOutlet var notifyView: UIView!
    
    var habitsType = "0"
    var timeType = "Week"
    
    var dataArray:[HabitsResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
       
    }
    
    func viewChanges() {
        dataTV.rowHeight = 120
        self.view.addSubview(addHView)
        addHView.frame = CGRect(x: 20, y: 100, width: Int(self.view.bounds.width) - 40, height: 330)
        
        addHView.isHidden = true
        addHView.elevate(elevation: 10.0)
        addHView.layer.cornerRadius = 10
        saveBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        hideKeyboardWhenTappedAround()
        infoTxtView.layer.cornerRadius = 10
        self.view.addSubview(notifyView)
        notifyView.center = view.center
        notifyView.isHidden =  true 
    }
    
      
    
    @IBAction func timeTypeSCAxn(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex  {
        case 0:
        timeType = "Week"
        case 1:
        timeType = "Months"
        case 2:
        timeType = "Years"
        
        default:
        timeType = "Week"

        }
    }
    
    @IBAction func plusAxn(_ sender: UIButton) {
        addHView.isHidden = false
        notifyView.isHidden = true 
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        addHView.isHidden = true
        
        if dataTV.isHidden == true {
        notifyView.isHidden = false
        } else {
        notifyView.isHidden = true

        }
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
   
    
    @IBAction func habitsTypeSCAxn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
        habitsType = "1"
        case 2:
        habitsType = "2"
        case 3:
        habitsType = "3"
        case 0:
        habitsType = "0"
        
        default:
            habitsType = "0"
        }
    }
    
    
    @IBAction func saveBtnAxn(_ sender: UIButton) {
        if titleTF.text == "" || infoTxtView.text == "" || fromTF.text == "" {
        popUpAlert(title: "Alert", message: "Enter All Details", action: .alert)
        } else if habitsTypeSC.selectedSegmentIndex != 0 && habitsTypeSC.selectedSegmentIndex != 1 &&  habitsTypeSC.selectedSegmentIndex != 2 && habitsTypeSC.selectedSegmentIndex != 3 {
        popUpAlert(title: "Alert", message: "Select Habits Type", action: .alert)
        } else if timeSC.selectedSegmentIndex != 0 && timeSC.selectedSegmentIndex != 1 && timeSC.selectedSegmentIndex != 2  {
        popUpAlert(title: "Select Time Type", message: "Weeks/Months/Years", action: .alert)
            
        } else {
            postData()
        }
        
    }
    
    
    
        
    func getData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
            notifyView.isHidden = true

        ApiService.callPostToken(url: ClientInterface.habitsUrl, params: "", methodType: "GET", tag: "MedicationDetails", finish:finishPost)
           
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                      
        }
    }
        
    func postData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")

            let details = ["PatientUserId":GlobalVariables.accountID as Any,"Name":titleTF.text! as Any, "Type":habitsType as Any,"PeriodValue":fromTF.text! as Any,"PeriodUnit":timeType as Any,"ExtraInfo":infoTxtView.text! as Any] as [String:Any]
        ApiService.callPostToken(url: ClientInterface.habitsUrl, params: details, methodType: "POST", tag: "AddHabits", finish:finishPost)
        print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                      
        }
    }
              
              
    func finishPost (message:String, data:Data? , tag: String) -> Void {
               
        stopLottie()
               
        if tag == "DelHabits" || tag == "AddHabits" {
            do {
                
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
            print(parsedData)
            if parsedData.StatusCode == 200 {
               if tag == "DelMedication" {
                popUpAlert(title: "Alert", message: "Habit Details Deleted", action: .alert)
                } else {
                popUpAlert(title: "Success", message: "Habit Details Added ", action: .alert)
                }
                titleTF.text = ""
                habitsTypeSC.selectedSegmentIndex = -1
                fromTF.text = ""
                timeSC.selectedSegmentIndex = -1
                infoTxtView.text = ""
                addHView.isHidden = true
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
               let parsedData = try JSONDecoder().decode(HabitsResponse.self, from: jsonData)
               print(parsedData)
               if parsedData.statusCode == 200 {
                print("Got Medication Details")
                
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

extension HabitsVC: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitsTC
            let cellPath = dataArray[indexPath.row]
            
           
            cell.nameLbl.text = cellPath.name
            cell.infoLbl.text = "Info : \(cellPath.extraInfo)"
            cell.IDLbl.text = "\(cellPath.id)"
            cell.timeTypeLbl.text = cellPath.periodUnit
            cell.timeLbl.text = "\(cellPath.periodValue)"
            
            switch cellPath.type {
            case 0:
            cell.habitTypeLbl.text = "Smoke"
            case 1:
            cell.habitTypeLbl.text = "Drinks"
            case 2:
            cell.habitTypeLbl.text = "Food"
            case 3:
            cell.habitTypeLbl.text = "Social"
            default:
            cell.habitTypeLbl.text = "Smoke"

            }
           
            
            cell.delBtn.tag = indexPath.row
            cell.delBtn.addTarget(self, action: #selector(onTappedBtn(_:)), for: .touchUpInside)
            
            
            cell.dataView.elevate(elevation: 5.0)
            cell.dataView.layer.cornerRadius = 10
          
            return cell
        }
        
        
        
        
        @objc func onTappedBtn(_ sender: UIButton) {
            if reach.isConnectedToNetwork() == true {
            self.dataArray.remove(at: sender.tag)
            if let tableView = dataTV {
            let point = tableView.convert(sender.center, from: sender.superview!)
            if let wantedIndexPath = tableView.indexPathForRow(at: point) {
            let cell = tableView.cellForRow(at: wantedIndexPath) as! HabitsTC
              GlobalVariables.habitID = cell.IDLbl.text!
                  print("Global habitID  = \(GlobalVariables.habitID)")

            playLottie(fileName: "heartBeat")
            ApiService.callPostToken(url:ClientInterface.deleteHabitUrl + "\(GlobalVariables.habitID)", params: "", methodType: "GET", tag: "DelHabits", finish:finishPost)
             }
             }
             } else {
                popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
            }
            
        }

        
   

}
