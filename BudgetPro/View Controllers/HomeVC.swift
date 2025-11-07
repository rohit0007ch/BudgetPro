//
//  HomeVC.swift
//  BudgetPro
//
//  Created by ROHIT on 28/10/25.
//

import UIKit

class HomeVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var OthersBtn: UIButton!
    @IBOutlet weak var internetBtn: UIButton!
    @IBOutlet weak var ElectricityBtn: UIButton!
    @IBOutlet weak var VouchersBtn: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unselected text color
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
                .font: UIFont(name: "HelveticaNeue-Medium", size: 14)!

        ]

        // Selected text color
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
                .font: UIFont(name: "HelveticaNeue-Bold", size: 16)
        ]

        // Apply colors
        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        notificationView.layer.cornerRadius = 12
        notificationView.layer.masksToBounds = true
        statsView.layer.cornerRadius = 12
        statsView.layer.masksToBounds = true
        
        collectionView.clipsToBounds = false
        collectionView.layer.masksToBounds = false

        let layout = CarouselFlowLayout()
           // layout.itemSize = CGSize(width: view.frame.width * 0.75, height: 300)
        layout.itemSize = CGSize(width: view.frame.width * 0.75, height: view.frame.height * 0.18)

        layout.minimumLineSpacing = 40       // space between each cell (horizontal)
       // layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

            collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "CardCell", bundle: nil)
             collectionView.register(nib, forCellWithReuseIdentifier: "CardCell")    }
    

   
}
