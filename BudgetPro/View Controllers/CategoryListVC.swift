//
//  CategoryListVC.swift
//  BudgetPro
//
//  Created by ROHIT on 30/10/25.
//

import UIKit
struct Category {
    let name : String
    let budget : Float
    let spent : Float
    let icon : String
}
class CategoryListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  

    @IBOutlet weak var CategoryTblView: UITableView!
    var categories: [Category] = [
          Category(name: "Electricity", budget: 600, spent: 400, icon: "Electricity"),
          Category(name: "Internet", budget: 500, spent: 400, icon: "Internet"),
          Category(name: "Shopping", budget: 600, spent: 300, icon: "Merchants"),
          Category(name: "Stocks", budget: 800, spent: 600, icon: "Stocks"),
          Category(name: "Travel", budget: 1000, spent: 800, icon: "Travel"),
          Category(name: "Bills", budget: 900, spent: 400, icon: "Bills"),
          Category(name: "Netflix", budget: 700, spent: 500, icon: "netflix"),
          Category(name: "Credit Cards", budget: 400, spent: 200, icon: "Credit Card")
      ]
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryTblView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)

        let nib = UINib(nibName: "CategoryListCell", bundle: nil)
        CategoryTblView.register(nib, forCellReuseIdentifier: "CategoryListCell")
        CategoryTblView.delegate = self
        CategoryTblView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryTblView.dequeueReusableCell(withIdentifier: "CategoryListCell") as! CategoryListCell
        let category = categories[indexPath.row]
        cell.iconView.image = UIImage(named: category.icon)
              cell.titleLabel.text = category.name
              cell.budgetLabel.text = "Budget: $\(Int(category.budget))"
              cell.spentLabel.text = "Spent: $\(Int(category.spent))"
              cell.progressView.progress = category.spent / category.budget
            //  cell.containerView.backgroundColor = UIColor(named: "CardBackground") ?? .secondarySystemBackground
              
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 // Space between cells
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear // or use groupTableViewBackground for subtle separation
        return spacer
    }



  
}
