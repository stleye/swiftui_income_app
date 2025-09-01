//
//  TransactionView.swift
//  Income
//
//  Created by Sebastian Tleye on 29/08/2025.
//


import SwiftUI

struct TransactionView: View {
    
    let transaction: Transaction
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(transaction.displayDate)
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.vertical, 5)
            .background(Color.lightGrayShade.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            HStack {
                Image(systemName: transaction.type == .expense ? "arrow.down.forward" : "arrow.up.forward")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(transaction.type == .income ? Color.green : Color.red)
                VStack(alignment: .leading) {
                    HStack {
                        Text(transaction.title)
                            .font(.system(size: 15, weight: .bold))
                        Spacer()
                        Text(String(transaction.displayAmount))
                            .font(.system(size: 15, weight: .bold))
                    }
                    Text("Completed")
                        .font(.system(size: 14))
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}


#Preview {
    TransactionView(transaction: Transaction(title: "Apples",
                                             amount: 5.00,
                                             date: Date.now,
                                             type: .expense),)
}
