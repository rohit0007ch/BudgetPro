//
//  AdddCategoryVC.swift
//  BudgetPro
//
//  Created by ROHIT on 31/10/25.
//

import UIKit

class AdddCategoryVC: UIViewController {

    @IBOutlet weak var iconContainerView: DesignableView!
    @IBOutlet weak var uploadView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        iconContainerView.clipsToBounds = false
       // iconContainerView.layer.cornerRadius = 8
      //  iconContainerView.layer.masksToBounds = true
        iconContainerView.layer.borderWidth = 1
        iconContainerView.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
    }
  
    

}
