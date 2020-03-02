//
//  EducationVC.swift
//  One for Patient
//
//  Created by Idontknow on 19/12/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class EducationVC: UIViewController {
    
    
    @IBOutlet var notifyView: UIView!
    
    @IBOutlet weak var dataTV: UITableView!
    
    
    
    var dataArray:[EducationResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewChanges()

    }
    
    func viewChanges() {
        dataTV.delegate = self
        dataTV.dataSource = self
        dataTV.rowHeight = 185
        dataTV.reloadWithAnimation()
        notifyView.center = view.center
        view.addSubview(notifyView)
        notifyView.isHidden = true

    }
    
    
   
    @IBAction func addBtn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddEducationDetailsVC") as! AddEducationDetailsVC
        self.navigationController?.pushViewController(VC, animated: true)
        
        
    }
    
    
    
    func getDetails() {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        notifyView.isHidden = true
    ApiService.callPostToken(url:ClientInterface.getEducationUrl, params: "", methodType: "GET", tag: "GetEducationInfo", finish:finishPost)
        } else {
        popUpAlert(title: "ALert", message: "Check Internet Connection", action: .alert)
         }
    }
      
    override func viewWillAppear(_ animated: Bool) {
        getDetails()
    }
    

        
        
        
    
    
    
    
   func finishPost (message:String, data:Data? , tag: String) -> Void {

    stopLottie()
    if tag == "DelEducation" {
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(Deleteresponse.self, from: jsonData)
        print(parsedData)
        if parsedData.statusCode == 200 {
        getDetails()
        dataTV.reloadWithAnimation()
        print("Got Education Details")
        } else {
        print("Check Details")
        }
        }
        } catch {
                     
        print("Parse Error: \(error)")
        popUpAlert(title: "Alert", message: "Check Details and Try Again", action: .alert)
        }
        
    } else {
    do {
    if let jsonData = data {
    let parsedData = try JSONDecoder().decode(EducationResponse.self, from: jsonData)
    print(parsedData)
    if parsedData.statusCode == 200 {
        if parsedData.result.isEmpty == false {
            
    dataArray = parsedData.result
    dataTV.isHidden = false
    notifyView.isHidden = true
    dataTV.reloadWithAnimation()
    } else {
        dataTV.isHidden = true
        notifyView.isHidden = false
    }
    print("Got Education Details")
    } else {
    print("Check Details")
    }
    }
    } catch {
                 
    print("Parse Error: \(error)")
    popUpAlert(title: "Alert", message: "Check Details and Try Again", action: .alert)
    }
    }
    
    }

}


extension EducationVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EducationTC
        let cellItem = dataArray[indexPath.row]
        
        let dateFrom = cellItem.dtFrom.prefix(10)
            cell.fromLbl.text = "\(dateFrom)"
            let dateTO = cellItem.dtTo.prefix(10)
            cell.TOLbl.text = "\(dateTO)"
        
        
        cell.studyLbl.text = "\(cellItem.stillStudying)"
        cell.titleLbl.text = cellItem.title
        cell.collageLbl.text = cellItem.college
        cell.universityLbl.text = cellItem.institute
        cell.eduIDLbl.text = "\(cellItem.id)"
//        cell.gradeLbl.text = cellItem.grade
        cell.delBtn.tag = indexPath.row
        cell.delBtn.addTarget(self, action: #selector(onTappedBtn(_:)), for: .touchUpInside)
       
        
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
        cell.dataView.layer.borderWidth = 3.0
        cell.contentView.elevate(elevation: 3.0)
      return cell
    }
    
    
    @objc func onTappedBtn(_ sender: UIButton) {
        if reach.isConnectedToNetwork() == true {
        
         if let tableView = dataTV {
         self.dataArray.remove(at: sender.tag)
        let point = tableView.convert(sender.center, from: sender.superview!)

       if let wantedIndexPath = tableView.indexPathForRow(at: point) {
       let cell = tableView.cellForRow(at: wantedIndexPath) as! EducationTC
       GlobalVariables.educationID = cell.eduIDLbl.text!
          print("Global Ed ID = \(GlobalVariables.educationID)")
        playLottie(fileName: "heartBeat")
       ApiService.callPostToken(url:ClientInterface.delEducationUrl, params: "", methodType: "GET", tag: "DelEducation", finish:finishPost)
       }
       }
       } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
         
    }

    
    
    
    
    
    
   
    
    
    
    
}




