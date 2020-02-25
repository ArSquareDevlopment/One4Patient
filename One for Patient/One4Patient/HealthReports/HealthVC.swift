//
//  HealthVC.swift
//  One for Patient
//
//  Created by Idontknow on 30/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class HealthVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    @IBOutlet weak var vitalsCont: UIView!
    
    @IBOutlet weak var allergyCont: UIView!
    
    @IBOutlet weak var MCCont: UIView!
    @IBOutlet weak var habitsCont: UIView!
    @IBOutlet weak var medicationCont: UIView!
    var titleList = ["VITALS","MEDICATIONS","ALLERGY","HABITS","M-CONDITIONS","ADVISE","ENCOUNTERS","PROGRESS NOTES"]

    
    
    
    
    
    @IBOutlet weak var dataCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

    viewChanges()
    CVChanges()
    }
    
    func viewChanges(){
        vitalsCont.isHidden = false
        medicationCont.isHidden = true
        allergyCont.isHidden = true
        MCCont.isHidden = true
        habitsCont.isHidden = true
    }
    func CVChanges() {
        let cellSize = CGSize(width:150 , height:40)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 1)
        layout.minimumLineSpacing = 5.0
            layout.minimumInteritemSpacing = 1.0
        dataCV.setCollectionViewLayout(layout, animated: true)
        dataCV.delegate = self
        dataCV.dataSource = self
        dataCV.reloadData()
    }
        
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HealthCVC
    
        cell.nameLbl.tag = indexPath.row
        cell.nameLbl.text = titleList[indexPath.row]
        cell.dataView.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HealthCVC
        
        switch indexPath.item {
            
        case 0:
           
        vitalsCont.isHidden = false
        medicationCont.isHidden = true
        allergyCont.isHidden = true
        MCCont.isHidden = true
        habitsCont.isHidden = true
        cell.nameLbl.pulse()
        case 1:
           
        vitalsCont.isHidden = true
        medicationCont.isHidden = false
        allergyCont.isHidden = true
        MCCont.isHidden = true
        habitsCont.isHidden = true

            
        case 2:
          
        vitalsCont.isHidden = true
        medicationCont.isHidden = true
        allergyCont.isHidden = false
        MCCont.isHidden = true
        habitsCont.isHidden = true

        case 3:
         
        vitalsCont.isHidden = true
        medicationCont.isHidden = true
        allergyCont.isHidden = true
        MCCont.isHidden = true
        habitsCont.isHidden = false

        case 4:
        vitalsCont.isHidden = true
        medicationCont.isHidden = true
        allergyCont.isHidden = true
        MCCont.isHidden = false
        habitsCont.isHidden = true
        case 5:
        print("Advise")
        case 6:
        print("Emcounters")

        case 7:
        print("ProgressNotes")

        default:
          break
        }
    }
    
    

}
