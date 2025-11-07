//
//  TransactionSection.swift
//  BudgetPro
//
//  Created by ROHIT on 03/11/25.
//

import Foundation

struct Transaction {
    let name: String
    let date: String
    let amount: Double     // ✅ make this String to match your VC data
    let icon: String
}

struct TransactionSection {
    let title: String
    var isExpanded: Bool
    var transactions: [Transaction]
}

