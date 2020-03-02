//
//  AppointmentsViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit
import AMPopTip

class AppointmentsViewController: UIViewController {
    @IBOutlet weak var bookingSC: UISegmentedControl!
    
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var userIMGView: UIImageView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var appTypeSC: UISegmentedControl!
    @IBOutlet var bookView: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var membersTV: UITableView!
    @IBOutlet weak var notifyLbl: UILabel!
    @IBOutlet weak var notifyIMGView: UIImageView!
    @IBOutlet var notifyView: UIView!
   
    var refreshControl = UIRefreshControl()
    var isRefreshing:Bool = false
    var isUserSelected:Bool = false
    var timeList = ["11:40","04:30"]
    var datelist = ["12-10-2019","12-11-2019" ]
    var nameList1 = ["Hina Sharma", "John Cena"]
    var nameList2 = ["Asha Bonsle", "Harbajan Singh"]
    var degreeList = ["M.S","MBBS"]
    var appType = ["Appointment Type1","Appointment Type2"]
    var doctorType = ["General Physician","Cheif Surgeon"]
    var imgArr = ["doctor2","doctor3"]
    var dataArray:[AppointmentListResult] = []
    var membersArray : [MemberResult] = []
    var mySubscriptonDetails:[MemberResult] = []
    var sendUser = "PatientUserId"
    var sendQuery = "Today"
    var sendID = GlobalVariables.accountID
    var isNotified:Bool = false
    var popup = PopTip()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewCahnges()
        getData()
    }
    
    func viewCahnges() {
        userIMGView.makeRound()
        profileBtn.layer.cornerRadius = 10
        bookBtn.layer.cornerRadius = 10
        dataTV.reloadData()
        dataTV.delegate  = self
        dataTV.dataSource = self
        dataTV.rowHeight = 135
        profileView.elevate(elevation: 3.0)
        membersTV.rowHeight = 60
        notifyFunc()
        if BookingFor.isUserSelected == true {
            nameLbl.text = BookingFor.userName
            emailLbl.text = BookingFor.userEmail
            IDLbl.text = BookingFor.userId
        } else {
            nameLbl.text = GlobalVariables.userName
            emailLbl.text = GlobalVariables.userEmail
            IDLbl.text = GlobalVariables.accountID
        }
        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
//        dataTV.refreshControl = refreshControl
        self.view.addSubview(bookView)
        bookView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        bookView.isHidden = true
        popup.bubbleColor = .baseColor
        popup.edgeMargin = 5
        popup.offset = 2
        popup.bubbleOffset = 0
        popup.edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        popup.shadowOpacity = 0.4
        popup.shadowRadius = 3
        popup.shadowOffset = CGSize(width: 1, height: 1)
        popup.shadowColor = .black
        popup.shouldDismissOnTap = false

    }
    func notifyFunc() {
        self.view.addSubview(notifyView)
        notifyView.isHidden = true
        notifyView.center = self.view.center
        notifyView.layer.cornerRadius = 10
    }
    
    @objc func refreshing() {
        refreshControl.beginRefreshing()
        isRefreshing = true
        print("Refres Started")
        if appTypeSC.selectedSegmentIndex == 1 {
            if BookingFor.isUserSelected == true {
            sendID = BookingFor.userId
            } else {
            sendID = GlobalVariables.accountID
                
            }
            sendQuery = "Upcoming"
            getData()
        } else if appTypeSC.selectedSegmentIndex == 2 {
            if BookingFor.isUserSelected == true {
            sendID = BookingFor.userId
            } else {
            sendID = GlobalVariables.accountID
            }
            sendQuery = "Past"
            getData()

                   
        }  else {
            if BookingFor.isUserSelected == true {
            sendID = BookingFor.userId
        } else {
          sendID = GlobalVariables.accountID
        }
          sendQuery = "Today"
          getData()


        }
    }
    
    
    @IBAction func bookingSCAxn(_ sender: UISegmentedControl) {
        getMembersData()
        
    }
    
    
    
    
    @IBAction func typeSCAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            if BookingFor.isUserSelected == true {
            sendID = BookingFor.userId
            } else {
            sendID = GlobalVariables.accountID

            }
           sendQuery = "Upcoming"
           getData()
        } else if sender.selectedSegmentIndex == 2 {
           if BookingFor.isUserSelected == true {
            sendID = BookingFor.userId
            } else {
            sendID = GlobalVariables.accountID
            }
            sendQuery = "Past"
            getData()

            
        }  else {
           if BookingFor.isUserSelected == true {
            sendID = BookingFor.userId
        } else {
            sendID = GlobalVariables.accountID

        }
            sendQuery = "Today"
            getData()


        }
        
        
    }
    
    
    
    @IBAction func filterAxn(_ sender: UIButton) {
        bookView.isHidden = true
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
    @IBAction func bookBtnAct(_ sender: UIButton) {

    let VC = self.storyboard?.instantiateViewController(withIdentifier: "SymptomsVC") as! SymptomsVC
    self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func showBookingView() {
        bookView.isHidden = false
        popup.show(customView: bookView, direction: .down, in: view, from: profileView.frame)
//        self.view.addSubview(bookView)
//        bookView.showPopupAnimation()
//        bookView.elevate(elevation: 10.0)
//        bookView.center = self.view.center
//        bookView.layer.cornerRadius = 10
        bookingSC.selectedSegmentIndex = 0
        getMembersData()
    }
    
    
    @IBAction func backAxn(_ sender: UIButton) {
        popup.hide()
//        bookView.removeFromSuperview()
    }
    
    
    @IBAction func selectProfileAxn(_ sender: UIButton) {
        showBookingView()

    }
    
    
    
    
    func getMembersData() {
        if reach.isConnectedToNetwork() == true {
            notifyView.isHidden = true

            playLottie(fileName: "heartBeat")
            membersTV.isHidden = false


        if bookingSC.selectedSegmentIndex == 1 {
              
        ApiService.callPostToken(url: ClientInterface.GetFamilyUrl, params: "", methodType: "GET", tag: "MembersDetails", finish:finishPost)
        } else {
        ApiService.callPostToken(url: ClientInterface.mySubscriptionUrl, params: "", methodType: "GET", tag: "MyDetails", finish:finishPost)
        }
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
        
        
    }
    
    
    func getData() {
        if reach.isConnectedToNetwork() == true {
            
        notifyView.isHidden = true
          playLottie(fileName: "heartBeat")
          let  details = [sendUser:sendID as Any,"CurrentStatus":"-1", "CustomQuery":sendQuery as Any ] as [String:Any]
          bookView.isHidden = true
          ApiService.callPostToken(url: ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "GetAppointment", finish:finishPost)
          print("details = \(details)")
          } else {
          popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
          }
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        stopLottie()
        
        if tag == "MyDetails" {
            
            do {
            if let jsonData = data {
                                    
            let parsedData = try JSONDecoder().decode(MySubscriptionResponse.self, from: jsonData)
            print(parsedData)
            
            if parsedData.statusCode == 200 {
                mySubscriptonDetails = [parsedData.result]
                membersTV.reloadWithAnimation()
            } else {
            popUpAlert(title: "Alert", message: "Error in getting  Details.. ", action: .alert)
            }
            } else {
            popUpAlert(title: "Alert", message: "Error in getting  details ", action: .alert)
            }
            } catch {
            popUpAlert(title: "Alert", message: "Error in getting  details ", action: .alert)
            print("Parse Error: \(error)")
            }
            
        }  else if tag == "MembersDetails" {
            
            do {
            if let jsonData = data {
                                    
            let parsedData = try JSONDecoder().decode(MembersResponse.self, from: jsonData)
            print(parsedData)
            
            if parsedData.statusCode == 200 {
            if parsedData.result.isEmpty == false {
                membersTV.isHidden = false 

            membersArray = parsedData.result
            membersTV.reloadWithAnimation()
            print("Got Family Members Details")
            } else {
                
            membersTV.isHidden = true
            popUpAlert(title: "Alert", message: "No Family Members Details.", action: .alert)
            }
            } else {
            popUpAlert(title: "Alert", message: "Error in getting  Details.. ", action: .alert)
            }
            } else {
            popUpAlert(title: "Alert", message: "Error in getting  details ", action: .alert)
            }
            } catch {
            popUpAlert(title: "Alert", message: "Error in getting  details ", action: .alert)
            print("Parse Error: \(error)")
            }
                
            } else {
        
            do {
            if let jsonData = data {
                            
            let parsedData = try JSONDecoder().decode(AppointmentListResponse.self, from: jsonData)
            print(parsedData)
           if parsedData.statusCode == 200 {
            if isRefreshing == true {
            refreshControl.endRefreshing()
            }
           if parsedData.result.isEmpty == false {
           
           dataArray = parsedData.result
           dataTV.isHidden = false
            dataTV.reloadWithAnimation()
           print("Got Appointment Details")
            } else {
            dataTV.isHidden = true
            notifyView.isHidden = false
            
            }
           } else {
           popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
           }
           } else {
           popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
           }
           } catch {
            popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
            print("Parse Error: \(error)")
           }
        
           }
             print("Second Commit Changes")
        print("Second Commit Changes")

           }
    
    
    
}
extension AppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == membersTV {
        if bookingSC.selectedSegmentIndex == 0 {
        return mySubscriptonDetails.count
        } else {
        print("Members TV")
        return membersArray.count
        }
        } else  {
        print("Appointments TV")
        return dataArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var currentCell = UITableViewCell()
        if tableView == membersTV {
            print("Members TV")

            let cell = membersTV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookingTC
            cell.userIMGView.makeRound()
            cell.dataView.layer.cornerRadius = 10
            cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
            cell.dataView.layer.borderWidth = 2.0
           
            
            if bookingSC.selectedSegmentIndex == 0 {
            let cellItem = mySubscriptonDetails[indexPath.row]
            cell.nameLbl.text = cellItem.user.userName
            cell.relationLbl.text = cellItem.user.email
            cell.userIDLbl.text = "\(cellItem.userID)"
            } else {
            let cellItem = membersArray[indexPath.row]
            cell.nameLbl.text = cellItem.user.userName
            cell.relationLbl.text = cellItem.user.email
            cell.userIDLbl.text = "\(cellItem.userID)"
            }
            
            currentCell = cell
        } else {
            print("Appoinements TV")

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AppointListTVC
        let cellItem = dataArray[indexPath.row]
            if cellItem.reasonForAppointment == nil {
                cell.appTypeLbl.text = "Reason : Empty"
            } else {
                cell.appTypeLbl.text = "Reason : \(cellItem.reasonForAppointment)"
            }
        if cellItem.specialist.userName == nil {
        cell.nameLbl.text = "Empty Doctor"
        } else {
        print("Username = \(cellItem.specialist.userName!)")
        cell.nameLbl.text = "Dr.\(cellItem.specialist.userName!)"
        }
        
            if cellItem.displayID.isEmpty ==  false {
                cell.displayIDLbl.text = cellItem.displayID
            } else {
                print("No diaply ID")
                cell.displayIDLbl.text = "No diaply ID"

            }
        cell.appID.text = "\(cellItem.id)"
        cell.ImgView.makeRound()
        cell.statusLbl.makeRound()
        cell.dataView.elevate(elevation: 3.0)
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.layer.borderWidth = 1.0
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
            
        let appointmentDate = cellItem.dateOfAppointment.prefix(10)
        cell.dateLbl.text = "\(appointmentDate)"
        
        let time = cellItem.startTimeOfAppointment.suffix(8)
        cell.timeLbl.text = "\(time)"
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
            
        switch cellItem.currentStatus {
        case 0:
            cell.statusLbl.text = "Queued"
            

        case 1:
            cell.statusLbl.text = "Accepted"
           

        case 2:
            cell.statusLbl.text = "Declined"
            
        case 3:
            cell.statusLbl.text = "Cancelled"
           

        case 4:
            cell.statusLbl.text = "Closed"
            
        default:
            cell.statusLbl.text = "Queued"
            
        }

        
            currentCell = cell
        }
        return currentCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == membersTV {
            print("MEmebers TV")
            

            let cell = tableView.cellForRow(at: indexPath) as! BookingTC
            BookingFor.userId = cell.userIDLbl.text!
            BookingFor.userName = cell.nameLbl.text!
            BookingFor.userEmail = cell.relationLbl.text!
            print("Selceted Id =\(BookingFor.userId)")
            print("Selected User = \(BookingFor.userName)")
            

            if bookingSC.selectedSegmentIndex == 1 {
                BookingFor.isUserSelected = true

                nameLbl.text = BookingFor.userName
                emailLbl.text = BookingFor.userEmail
                IDLbl.text = BookingFor.userId
                userIMGView.image = cell.userIMGView.image!
                sendID = BookingFor.userId
                appTypeSC.selectedSegmentIndex = 0
                getData()
            } else {
                BookingFor.isUserSelected = false

                print("Self is Selcted")
                nameLbl.text = GlobalVariables.userName
                emailLbl.text = GlobalVariables.userEmail
                sendID = GlobalVariables.accountID
                appTypeSC.selectedSegmentIndex = 0

                getData()
            }
            bookView.removeFromSuperview()

            
        
        } else {
            print("Appoinment TV")
        let cell = tableView.cellForRow(at: indexPath) as! AppointListTVC
        GlobalVariables.appointmentID = cell.appID.text!
        print("App Id =\(GlobalVariables.appointmentID)")
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetailsVC") as! AppointmentDetailsVC
        self.navigationController?.pushViewController(VC, animated: true)
        
        }
        
    }
    

    
    
    
}
