//
//  CategoryListCell.swift
//  BudgetPro
//
//  Created by ROHIT on 30/10/25.
//

import UIKit

import UIKit

class CategoryListCell: UITableViewCell {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        backgroundColor = .clear // show table’s background through gaps

        // Rounded corners
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        // Optional: Card shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 6
        layer.masksToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add spacing (top, left, bottom, right)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
    }
   
}
