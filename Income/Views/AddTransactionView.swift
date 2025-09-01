//
//  AddTransactionView.swift
//  Income
//
//  Created by Sebastian Tleye on 29/08/2025.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Binding var transactionToEdit: Transaction?
    @Binding var transactions: [Transaction]
    
    @State private var amount = 0.0
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @Environment(\.dismiss) private var dismiss
    
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        //numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }

    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Divider()
                .padding(.horizontal)
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { type in
                    Text(type.title)
                        .tag(type)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            Button {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 or more characters long"
                    showAlert = true
                    return
                }

                let transaction = Transaction(title: transactionTitle,
                                              amount: amount,
                                              date: Date.now,
                                              type: selectedTransactionType)

                if let transactionToEdit = transactionToEdit {
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit) else {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                } else {
                    transactions.append(transaction)
                }

                dismiss()

            } label: {
                Text(transactionToEdit == nil ? "Create" : "Edit")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.top)
            .padding(.horizontal, 30)

            Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransactionType = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert("", isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("OK")
            }

        } message: {
            Text(alertMessage)
        }

    }
    
}

#Preview {
    AddTransactionView(transactionToEdit: .constant(nil),
                       transactions: .constant([]))
}

#Preview {
    AddTransactionView(transactionToEdit: .constant(Transaction(title: "Salary",
                                                      amount: 500.00,
                                                      date: Date.now,
                                                      type: .income)),
                       transactions: .constant([]))
}
