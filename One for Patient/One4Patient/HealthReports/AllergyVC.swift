//
//  AllergyVC.swift
//  One for Patient
//
//  Created by Idontknow on 01/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class AllergyVC: UIViewController {

 
    @IBOutlet var notifyView: UIView!
    @IBOutlet weak var timeTypeSC: UISegmentedControl!
    @IBOutlet weak var allergyTF: UITextField!
    @IBOutlet weak var allergyTypeSC: UISegmentedControl!
    
    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var severitySC: UISegmentedControl!
    
    @IBOutlet var addAllergyView: UIView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var infoTxtView: UITextView!
    
    var allergyPicker = UIPickerView()
    var dataArray:[AllergyResult] = []
    var allergyDataArray: [AllegyListResult] =  []
    var allergyList:[String] = []
    var allergyListID = "0"
    var seversityType = "0"
    var timeType = "Weeks"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
        getAllergyList()

    }
    
    func viewChanges() {
        dataTV.rowHeight = 145
        self.view.addSubview(addAllergyView)
        addAllergyView.frame = CGRect(x: 20, y: 100, width: Int(self.view.bounds.width) - 40, height: 350)
        addAllergyView.isHidden = true

        addAllergyView.layer.cornerRadius = 10
        addAllergyView.elevate(elevation: 10.0)
        addBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        allergyPicker.delegate = self
        allergyPicker.dataSource = self
        allergyTF.withImage(direction: .Right, image: #imageLiteral(resourceName: "down"))
        allergyPicker.backgroundColor = .groupTableViewBackground
        hideKeyboardWhenTappedAround()
        infoTxtView.layer.cornerRadius = 10
        self.view.addSubview(notifyView)
        notifyView.center = view.center
        notifyView.isHidden = true
        
    }

    @IBAction func severityAxn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            seversityType = "0"
        case 1:
        seversityType = "1"
        case 2:
        seversityType = "2"
        default:
        seversityType = "0"

        }
    }
    
    @IBAction func timeTypeAxn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
        timeType = "Weeks"
        case 1:
        timeType = "Months"
        case 2:
        timeType = "Years"
        default:
        timeType = "Weeks"

        }
    }
    
    
    @IBAction func allergyTFAxn(_ sender: UITextField) {
        sender.inputView = allergyPicker
    }
    
    
    
    @IBAction func plusAxn(_ sender: UIButton) {
        addAllergyView.isHidden = false
        notifyView.isHidden = true

        
    }
    
    @IBAction func cancelAxn(_ sender: UIButton) {
        
        addAllergyView.isHidden = true
        if dataTV.isHidden == true {
        notifyView.isHidden = false
        } else {
        notifyView.isHidden = true

        }
    }
    
    @IBAction func addAxn(_ sender: UIButton) {
        if allergyTF.text == "" || timeTF.text == "" || infoTxtView.text == "" {
            popUpAlert(title: "Alert", message: "Enter All Details", action: .alert)
        } else if allergyTypeSC.selectedSegmentIndex != 0 && allergyTypeSC.selectedSegmentIndex != 1 && allergyTypeSC.selectedSegmentIndex != 2 && allergyTypeSC.selectedSegmentIndex != 3 {
            popUpAlert(title: "Select Allergy Tyep", message: " Drug/Food/Environment ", action: .alert)
        } else if severitySC.selectedSegmentIndex == 0 && severitySC.selectedSegmentIndex == 1 && severitySC.selectedSegmentIndex == 2 {
            popUpAlert(title: "Alert", message: "Select Severity", action: .alert)
        } else if timeTypeSC.selectedSegmentIndex != 0 && timeTypeSC.selectedSegmentIndex != 1 && timeTypeSC.selectedSegmentIndex != 2 {
            popUpAlert(title: "Alert", message: "Select TimePeriod Type", action: .alert)
        } else  {
            postData()
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        allergyList.removeAll()

        getData()
    }
        
    func getAllergyList()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        allergyList.removeAll()

        ApiService.callPostToken(url: ClientInterface.allergyListurl, params: "", methodType: "GET", tag: "AllergyList", finish:finishPost)
           
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                      
        }
    }
        
   
    func getData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
            notifyView.isHidden = true
            
        ApiService.callPostToken(url: ClientInterface.allergyUrl, params: "", methodType: "GET", tag: "AllergyDetails", finish:finishPost)
           
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                      
        }
    }
        
    func postData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
            

        let details = ["PatientUserId":GlobalVariables.accountID as Any, "MasterAllergyId":allergyListID as Any,"Severity":seversityType as Any,"PeriodValue":timeTF.text! as Any,"PeriodUnit":timeType as Any,"Description":infoTxtView.text! as Any] as [String:Any]
        
        ApiService.callPostToken(url: ClientInterface.allergyUrl, params: details, methodType: "POST", tag: "AddAllergy", finish:finishPost)
           print("details = \(details)")
        } else {
           popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                      
           }
    }
              
              
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()
               
        if tag == "DelAllergy" || tag == "AddAllergy" {
                do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        if tag == "DelAllergy" {
        popUpAlert(title: "Alert", message: "Allergy Details Deleted", action: .alert)
        } else {
        popUpAlert(title: "Success", message: "Allergy Added ", action: .alert)
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
        } else if tag == "AllergyList" {
            
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(AllergyListResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.statusCode == 200 {
            if parsedData.result.isEmpty == false {
            allergyDataArray = parsedData.result
            print("allergyDataArray = \(allergyDataArray)")
            print("Got Allergy List")
            } else {
                dataTV.isHidden = true
                notifyView.isHidden = false
            }
        } else {
            print("Error in Getting List")

//        popUpAlert(title: "Alert", message: "Error in Getting Data ", action: .alert)
        }
        } else {
        popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
        }
        } catch {
        popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
                  print("Parse Error: \(error)")
        }
            
        }  else  {
            
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(AllergyResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.statusCode == 200 {
        print("Got Allergy Details")
        addAllergyView.isHidden = true
        dataArray = parsedData.result
        dataTV.reloadWithAnimation()
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

extension AllergyVC: UITableViewDataSource, UITableViewDelegate {
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArray.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllergyTC
            let cellPath = dataArray[indexPath.row]
        let allergyPath = allergyDataArray[indexPath.row]
        
        allergyList.append(allergyPath.name)
        print("allergyList = \(allergyList)")
        
        cell.nameLbl.text = cellPath.masterAllergy.name
        cell.infoLbl.text = "Info : \(cellPath.resultDescription)"
        cell.IDLbl.text = "\(cellPath.id)"
        cell.timeLbl.text = "\(cellPath.periodValue)"
        cell.timeTypeLbl.text = cellPath.periodUnit
            
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(onTappedBtn(_:)), for: .touchUpInside)
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.elevate(elevation: 5.0)
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
        cell.dataView.layer.borderWidth = 2.0
            
            return cell
        }
        
        
        
        
    @objc func onTappedBtn(_ sender: UIButton) {
        if reach.isConnectedToNetwork() == true {
        self.dataArray.remove(at: sender.tag)
        if let tableView = dataTV {
        let point = tableView.convert(sender.center, from: sender.superview!)
        if let wantedIndexPath = tableView.indexPathForRow(at: point) {
        let cell = tableView.cellForRow(at: wantedIndexPath) as! AllergyTC
        GlobalVariables.allergyID = cell.IDLbl.text!
        print("Global allergyID  = \(GlobalVariables.allergyID)")

        playLottie(fileName: "heartBeat")
    ApiService.callPostToken(url:ClientInterface.deleteAllergyUrl + "\(GlobalVariables.allergyID)", params: "", methodType: "GET", tag: "DelAllergy", finish:finishPost)
        }
        }
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
            
    }
}

extension AllergyVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return allergyList.count
        }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return allergyList[row]
        }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            allergyTF.text = allergyList[row]
        allergyListID = "\(row)"
        print("allergyListID = \(allergyListID)")
            
        }
        

   

}
