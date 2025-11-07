//
//  CatergoryVC.swift
//  BudgetPro
//
//  Created by ROHIT on 29/10/25.
//

import UIKit

class CatergoryVC: UIViewController {

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    // MARK: - Outlets
    @IBOutlet weak var CatergoryCollectionView: UICollectionView!

    // MARK: - Data
    let categories: [(name: String, image: String)] = [
        ("Electricity", "Electricity"),
        ("Internet", "Internet"),
        ("Vouchers", "Vouchers"),
        ("Assurance", "assurance"),
        ("Merchants", "Merchants"),
        ("Mobile", "Mobile"),
        ("Bills", "Bills"),
        ("Wallet", "Wallet"),
        ("Goal", "Goal"),
        ("Travel", "Travel"),
        ("Clothes", "Clothes"),
        ("Netflix", "netflix"),
        ("Credit cards", "Credit Card"),
        ("Loan", "Loan"),
        ("TV", "Tv"),
        ("Donation", "Donation"),
        ("Hospital", "Hospital"),
        ("Apartments", "Appartment"),
        ("Subscription", "Subscription"),
        ("Education", "Education"),
        ("Spotify", "Spotify"),
        ("Cylinder", "Cylinder"),
        ("Stocks", "Stocks"),
        ("Movies", "Movies")
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
       // updateCollectionViewHeight()
    }
   /* private func updateCollectionViewHeight() {
        self.CatergoryCollectionView.layoutIfNeeded()
        self.collectionViewHeightConstraint.constant = self.CatergoryCollectionView.collectionViewLayout.collectionViewContentSize.height
    }*/
    // MARK: - Setup
    private func setupCollectionView() {
        let nib = UINib(nibName: "CatergoryCell", bundle: nil)
        CatergoryCollectionView.register(nib, forCellWithReuseIdentifier: "CatergoryCell")

        CatergoryCollectionView.delegate = self
        CatergoryCollectionView.dataSource = self
        CatergoryCollectionView.backgroundColor = .clear
        CatergoryCollectionView.alwaysBounceVertical = true // ensures smooth scroll

        if let layout = CatergoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0    // space between columns
            layout.minimumLineSpacing = 0        // space between rows
           // layout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
            let screenWidth = CatergoryCollectionView.bounds.width
            let itemsPerRow: CGFloat = screenWidth < 350 ? 3 : 4

        }
    }

    // MARK: - Actions
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - Collection View Delegate & Data Source
extension CatergoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CatergoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CatergoryCell", for: indexPath) as! CatergoryCell
        let category = categories[indexPath.row]
        cell.titleLabel.text = category.name
        cell.IconBtn.setImage(UIImage(named: category.image), for: .normal)
        return cell
    }

    // 4 columns layout — responsive across iPhones
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

       let itemsPerRow: CGFloat = 4
        let layout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpacing = layout.sectionInset.left +
                           layout.sectionInset.right +
                           (layout.minimumInteritemSpacing * (itemsPerRow - 1))

        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        let height = width
        return CGSize(width: width, height: height)
    }
}

