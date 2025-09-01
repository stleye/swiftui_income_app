//
//  TransactionModel.swift
//  Income
//
//  Created by Sebastian Tleye on 29/08/2025.
//

import Foundation

struct Transaction: Identifiable, Hashable {

    let id = UUID()
    let title: String
    let amount: Double
    let date: Date
    let type: TransactionType

    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    var displayAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00"
    }

}
