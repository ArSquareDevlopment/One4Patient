//
//  AddEducationDetailsVC.swift
//  One for Patient
//
//  Created by Idontknow on 16/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class AddEducationDetailsVC: UIViewController {
    
    @IBOutlet weak var toDateTF: UITextField!
    @IBOutlet weak var gradeTF: UITextField!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var collageTF: UITextField!
    @IBOutlet weak var studySC: UISegmentedControl!
    @IBOutlet weak var typeSC: UISegmentedControl!
    @IBOutlet weak var universityTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    var study:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewChanges()

    }
    func viewChanges() {
        saveBtn.layer.cornerRadius = 10
        titleTF.layer.cornerRadius = 10
        collageTF.layer.cornerRadius = 10
        universityTF.layer.cornerRadius = 10


        
    }
    
    
    @IBAction func dataAxn(_ sender: UITextField) {
        sender.pastDatePicker()
    }
    
    @IBAction func backAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func studySC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            study = false
        } else {
            study = true
        }
    }
    
    
    func postData(){
        
           if reach.isConnectedToNetwork() == true {
            playLottie(fileName: "heart")
            let details = ["ProfileId":GlobalVariables.profileID as Any, "Title":titleTF.text! as Any, "College":collageTF.text! as Any, "Institute":universityTF.text! as Any, "StillStudying":study as Any, "DtFrom":fromTF.text! as Any, "DtTo":toDateTF.text! as Any, "Grade":gradeTF.text! as Any ] as [String : Any]
        if typeSC.selectedSegmentIndex == 1 {
            ApiService.callPostToken(url:ClientInterface.postSpecilizationUrl, params: details, methodType: "POST", tag: "AddSpecialization", finish:finishPost)
            print("SPdetails = \(details)")
        } else {
        ApiService.callPostToken(url:ClientInterface.postEducationUrl, params: details, methodType: "POST", tag: "AddEducation", finish:finishPost)
            print("EDdetails = \(details)")

        }
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
        
    }
    
    @IBAction func saveAxn(_ sender: UIButton) {
        
        if fromTF.text?.isEmpty == true || toDateTF.text?.isEmpty == true ||  titleTF.text?.isEmpty == true || collageTF.text?.isEmpty == true || universityTF.text?.isEmpty == true || gradeTF.text?.isEmpty == true {
                      popUpAlert(title: "Alert", message: "Enter all Details", action: .alert)
        }else if typeSC.selectedSegmentIndex != 0  && typeSC.selectedSegmentIndex != 1 {
            popUpAlert(title: "Alert", message: "Select Education Type", action: .alert)
            
        } else {
            postData()
        }
    
    }
    
     
       func finishPost (message:String, data:Data? , tag: String) -> Void {

        stopLottie()
        
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(PostEduResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        fromTF.text = ""
        toDateTF.text = ""
        universityTF.text = ""
        collageTF.text = ""
        titleTF.text = ""
        gradeTF.text = ""
        popUpAlert(title: "Success", message: "Updated Successfully", action: .alert)
        } else {
        popUpAlert(title: "Alert", message: "Update Failed", action: .alert)
        }
        }
        } catch {
        print("Parse Error: \(error)")
        popUpAlert(title: "Alert", message: "Update Failed. Check Details", action: .alert)
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
}
                 

    


