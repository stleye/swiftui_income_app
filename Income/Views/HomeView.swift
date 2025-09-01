//
//  ContentView.swift
//  Income
//
//  Created by Sebastian Tleye on 29/08/2025.
//

import SwiftUI

struct HomeView: View {

    @State private var transactions: [Transaction] = [
        
    ]

    private var expenses: String {
        let sumExpenses = transactions
            .filter { $0.type == .expense }
            .reduce(0, { $0 + $1.amount})
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "0.00"
    }

    private var income: String {
        let sumExpenses = transactions
            .filter { $0.type == .income }
            .reduce(0, { $0 + $1.amount})
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "0.00"
    }

    private var total: String {
        let sum = transactions
            .reduce(0, { $0 + ($1.type == .expense ? -$1.amount : $1.amount) })
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sum as NSNumber) ?? "0.00"
    }

    @State private var transactionToEdit: Transaction?

    fileprivate func FloatingView() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(transactionToEdit: $transactionToEdit,
                                   transactions: $transactions)
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 7)
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }

    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(income)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    private func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List {
                        ForEach(transactions) { transaction in
                            Button {
                                transactionToEdit = transaction
                            } label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingView()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit,
                                   destination: { _ in
                AddTransactionView(transactionToEdit: $transactionToEdit,
                                   transactions: $transactions)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }

                }
            }
        }
    }
}

#Preview {
    HomeView()
}


