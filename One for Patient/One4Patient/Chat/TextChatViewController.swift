//
//  TextChatViewController.swift
//  One for Patient
//
//  Created by Idontknow on 25/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit
class TextChatViewController: UIViewController {
    
    @IBOutlet weak var msgTF: UITextField!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var chatTxtView: UITextView!
    
    @IBOutlet weak var sendView: UIView!
    
    @IBOutlet weak var attachBtn: UIButton!
    
    
//    var chatHub: Hub!
//    var connection: SignalR!
//    var name: String!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        connection = SignalR("http://localhost:55830")
//        connection.useWKWebView = true
//        connection.signalRVersion = .v2_2_0
//
//        chatHub = Hub("chatHub")
//        chatHub.on("broadcastMessage") { [weak self] args in
//                if let name = args?[0] as? String, let message = args?[1] as? String, let text = self?.chatTxtView.text {
//                    self?.chatTxtView.text = "\(text)\n\n\(name): \(message)"
//                }
//            }
//            connection.addHub(chatHub)
//
//             // SignalR events
//
//            connection.starting = { [weak self] in
//                self?.statusLbl.text = "Starting..."
//                self?.startBtn.isEnabled = false
//                self?.startBtn.isEnabled = false
//            }
//
//            connection.reconnecting = { [weak self] in
//                self?.statusLbl.text = "Reconnecting..."
//                self?.startBtn.isEnabled = false
//                self?.sendBtn.isEnabled = false
//            }
//
//            connection.connected = { [weak self] in
//                print("Connection ID: \(self!.connection.connectionID!)")
//                self?.statusLbl.text = "Connected"
//                self?.startBtn.isEnabled = true
//                self?.startBtn.setTitle("Stop", for: .normal)
//                self?.sendBtn.isEnabled = true
//            }
//
//            connection.reconnected = { [weak self] in
//                self?.statusLbl.text = "Reconnected. Connection ID: \(self!.connection.connectionID!)"
//                self?.startBtn.isEnabled = true
//                self?.startBtn.setTitle("Stop", for: .normal)
//                self?.sendBtn.isEnabled = true
//            }
//
//            connection.disconnected = { [weak self] in
//                self?.statusLbl.text = "Disconnected"
//                self?.startBtn.isEnabled = true
//                self?.startBtn.setTitle("Start", for: .normal)
//                self?.sendBtn.isEnabled = false
//            }
//
//            connection.connectionSlow = { print("Connection slow...") }
//
//            connection.error = { [weak self] error in
//                print("Error: \(String(describing: error))")
//
//                // Here's an example of how to automatically reconnect after a timeout.
//                //
//                // For example, on the device, if the app is in the background long enough
//                // for the SignalR connection to time out, you'll get disconnected/error
//                // notifications when the app becomes active again.
//
//                if let source = error?["source"] as? String, source == "TimeoutException" {
//                    print("Connection timed out. Restarting...")
//                    self?.connection.start()
//                }
//            }
//
//            connection.start()
//        }
//
//        override func viewDidAppear(_ animated: Bool) {
//            self.navigationController?.navigationBar.isHidden = true
//            let alertController = UIAlertController(title: "Name", message: "Please enter your name", preferredStyle: .alert)
//
//            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
//                self?.name = alertController.textFields?.first?.text
//
//                if let name = self?.name , name.isEmpty {
//                    self?.name = "Anonymous"
//                }
//
//                alertController.textFields?.first?.resignFirstResponder()
//            }
//
//            alertController.addTextField { textField in
//                textField.placeholder = "Your Name"
//            }
//
//            alertController.addAction(okAction)
//            present(alertController, animated: true, completion: nil)
//        }
//
//
//        @IBAction func send(_ sender: AnyObject?) {
//            if let hub = chatHub, let message = msgTF.text {
//                do {
//                    try hub.invoke("send", arguments: [name!, message])
//                    msgTF.text = ""
//                } catch {
//                    print(error)
//                }
//            }
//            msgTF.resignFirstResponder()
//        }
//
    
    @IBAction func startStopAxn(_ sender: UIButton) {
//        if sender.titleLabel?.text == "Start" {
//            connection.start()
//        } else {
//            connection.stop()
//
//        }
//        
    }
    
    
        

       

    }

    
    
    
    
    
   
    
    
    
    
    
    
    
    
   

