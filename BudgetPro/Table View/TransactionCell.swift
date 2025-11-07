import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(with transaction: Transaction) {
        nameLabel.text = transaction.name
        dateLabel.text = transaction.date
        iconImageView.image = UIImage(named: transaction.icon)

        // Format amount with + or –
        let amountValue = transaction.amount
        let sign = amountValue >= 0 ? "+" : "–"
        amountLabel.text = "\(sign)$\(abs(Int(amountValue)))"

        // Color green if received, red if deducted
        amountLabel.textColor = amountValue >= 0 ? .systemGreen : .systemRed
    }
}

