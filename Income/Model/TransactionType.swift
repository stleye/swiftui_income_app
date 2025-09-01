//
//  TransactionType.swift
//  Income
//
//  Created by Sebastian Tleye on 29/08/2025.
//

import Foundation

enum TransactionType: String, CaseIterable, Identifiable  {
    
    var id: Self { self }
    
    case income
    case expense
    
    var title: String {
        switch self {
        case .income:
            "Income"
        case .expense:
            "Expense"
        }
    }
}
