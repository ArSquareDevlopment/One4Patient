//
//  NewViewController.swift
//  One for Patient
//
//  Created by Idontknow on 07/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit
import AMPopTip

class NewViewController: UIViewController {

    @IBOutlet weak var starBtn: UIButton!
    
    @IBOutlet weak var IMGView: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    var titleArray = ["Doctors","Prescriptions","Appointments"]
    var contentArray = ["Find expert Doctors for a particular problem on one tap","All prescriptions medicines can bought from here on One tap","Book appointments and  get best treatment on One tap"]
    
    @IBOutlet weak var titleLbl: UILabel!
    
    let manager = LocalNotificationManager()
    var firstImageView = UIImageView()
    var popup = PopTip()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  self.navigationController?.navigationBar.isHidden = true
        starBtn.layer.cornerRadius = 10
        firstImageFadeIn(imageView: IMGView)
        
    }
    
    
    @IBAction func startAxn(_ sender: UIButton) {

       print("Is UserAuthe = \(ZoomService.sharedInstance.isUserAuthenticated)")
        
       print("IS APi Authe = \(ZoomService.sharedInstance.isAPIAuthenticated)")
    let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    self.navigationController?.pushViewController(VC, animated: true)

    }
    


    func firstImageFadeIn(imageView: UIImageView) {
     let secondImageView = UIImageView(image: UIImage(named: "img2"))
      secondImageView.frame = view.frame
        secondImageView.alpha = 0.0
        view.insertSubview(secondImageView, aboveSubview: imageView)
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
                secondImageView.alpha = 1.0
         }, completion: {_ in
        imageView.image = secondImageView.image
        self.titleLbl.text = self.titleArray[1]
        self.contentLbl.text = self.contentArray[1]
        self.secondImageFadeIn(imageView: secondImageView)
            })

    }
   
    func secondImageFadeIn(imageView: UIImageView) {
        let secondImageView = UIImageView(image: UIImage(named: "img3"))
        secondImageView.frame = view.frame
        secondImageView.alpha = 0.0
        view.insertSubview(secondImageView, aboveSubview: imageView)

        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            secondImageView.alpha = 1.0
            }, completion: {_ in
            imageView.image = secondImageView.image

            self.titleLbl.text = self.titleArray[2]
            self.contentLbl.text = self.contentArray[2]
            self.nextImageFadeIn(imageView: secondImageView)

            })

    }
    
    func nextImageFadeIn(imageView: UIImageView) {
         let secondImageView = UIImageView(image: UIImage(named: "img1"))
        secondImageView.frame = view.frame
        secondImageView.alpha = 0.0
        view.insertSubview(secondImageView, aboveSubview: imageView)

        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            secondImageView.alpha = 1.0
        }, completion: {_ in
            imageView.image = secondImageView.image
            self.titleLbl.text = self.titleArray[0]
            self.contentLbl.text = self.contentArray[0]
            self.firstImageFadeIn(imageView: secondImageView)

            })

    }
    
    
}
