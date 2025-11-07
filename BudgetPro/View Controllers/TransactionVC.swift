import UIKit


class TransactionVC: UIViewController {

    // MARK: - Properties
    var sections: [TransactionSection] = [
        TransactionSection(title: "Week", isExpanded: true, transactions: [
            Transaction(name: "Starbucks Coffee", date: "6 Sept, 2022 • 7:20", amount: -350, icon: "Coffee"),
            Transaction(name: "Netflix Subscription", date: "24 Sept, 2022 • 4:20", amount: -650, icon: "Net"),
            Transaction(name: "Shopping", date: "10 Sept, 2022 • 4:20", amount: 1500, icon: "Shopping"),
            Transaction(name: "Spotify Premium", date: "28 Oct, 2022 • 7:20", amount: -950, icon: "Music"),
            Transaction(name: "Amazon Prime", date: "1 Nov, 2022 • 7:20", amount: 750, icon: "Amazon"),
            Transaction(name: "Gas Station", date: "1 Nov, 2022 • 7:20", amount: -500, icon: "Gas"),
            Transaction(name: "Grocery Shopping", date: "1 Nov, 2022 • 7:20", amount: 1200, icon: "Grocery Shopping"),
        ]),
        
        TransactionSection(title: "Months", isExpanded: true, transactions: [
            Transaction(name: "Gas Bills", date: "6 Oct, 2022 • 7:20", amount: -750, icon: "Gas"),
            Transaction(name: "Water Bills", date: "8 Oct, 2022 • 7:20", amount: -550, icon: "Water Bills"),
            Transaction(name: "Mobile Bills", date: "1 Nov, 2022 • 7:20", amount: 550, icon: "Mobile Bills"),
            Transaction(name: "Electricity Bills", date: "15 Dec, 2022", amount: -950, icon: "Electricity Bills")
        ])
    ]

    // MARK: - Outlets
    @IBOutlet weak var transactionTblView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        transactionTblView.delegate = self
        transactionTblView.dataSource = self
        transactionTblView.register(UINib(nibName: "TransactionCell", bundle: nil),
                                    forCellReuseIdentifier: "TransactionCell")
        transactionTblView.separatorStyle = .none
        transactionTblView.backgroundColor = .black
    }
}

// MARK: - TableView Delegate & DataSource
extension TransactionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].isExpanded ? sections[section].transactions.count : 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        let transaction = sections[indexPath.section].transactions[indexPath.row]
        cell.configure(with: transaction)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    // MARK: - Section Header (Expandable)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerButton = UIButton(type: .system)
        headerButton.tag = section
        headerButton.backgroundColor = .clear  // ⬅️ transparent background
        headerButton.contentHorizontalAlignment = .left
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white   // text + icon color
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.title = sections[section].title
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // dropdown arrow icon (no background)
        let arrow = sections[section].isExpanded ? "chevron.up" : "chevron.down"
        config.image = UIImage(systemName: arrow)
        config.imagePlacement = .trailing
        config.imagePadding = 8
        
        headerButton.configuration = config
        headerButton.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
        
        return headerButton
    }


    @objc private func toggleSection(_ sender: UIButton) {
        let section = sender.tag
        sections[section].isExpanded.toggle()
        transactionTblView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

