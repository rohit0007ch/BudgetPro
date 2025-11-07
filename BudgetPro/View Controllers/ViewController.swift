//
//  ViewController.swift
//  BudgetPro
//
//  Created by ROHIT on 04/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var budgetLbl: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    let images = ["first", "first  ", "first"]   // Add these in Assets.xcassets
    var timer: Timer?
    var currentIndex = 0
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .systemIndigo
        pc.pageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // CollectionView setup
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        if let layout = CollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        CollectionView.isPagingEnabled = true
        CollectionView.showsHorizontalScrollIndicator = false
        
        // Register custom cell
        CollectionView.register(ImageSlideCell.self, forCellWithReuseIdentifier: "ImageSlideCell")
        
        // PageControl setup
        pageControl.numberOfPages = images.count
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: CollectionView.bottomAnchor, constant: -10)
        ])
        
        // Start auto sliding
        startAutoSlide()
        
        // Slide to Unlock Button
        let slideBtn = SlideToUnlockButton(frame: .zero)
        slideBtn.onUnlock = {
            print("Unlocked! 🚀 Navigate or trigger action here")
           

                // Create and navigate to your next VC
                let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
                self.navigationController?.pushViewController(nextVC, animated: true)
        }
        slideBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slideBtn)
       
        NSLayoutConstraint.activate([
            slideBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            slideBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            slideBtn.topAnchor.constraint(equalTo: budgetLbl.bottomAnchor, constant: 20),
            slideBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            slideBtn.heightAnchor.constraint(equalToConstant: 60)
        ])

    }
    // view did load end

    
    // Auto slide logic
    func startAutoSlide() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    @objc func slideToNext() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        CollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
    
    deinit {
        timer?.invalidate()
    }
}



// MARK: - CollectionView DataSource & Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSlideCell", for: indexPath) as! ImageSlideCell
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
    }
    
    // Full screen width per cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // Sync pageControl when user scrolls manually
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentIndex = page
        pageControl.currentPage = page
    }
}

