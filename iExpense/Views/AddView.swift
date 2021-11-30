//
//  AddView.swift
//  iExpense
//
//  Created by Amit Shrivastava on 29/11/21.
//

import SwiftUI

struct AddView: View {
    @State var itemName: String = ""
    @State var type: String = "Personal"
    @State var amount: Double = 0.0
    @State var localCurrency: String = ""
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    var itemType = ["Business", "Personal"]
    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $itemName)
                Picker("Type", selection: $type) {
                    ForEach(itemType, id: \.self){
                        id in
                        Text("\(id)")
                    }
                }
                TextField("Amount", value: $amount , format: .currency(code: localCurrency))
                    .keyboardType(.decimalPad)
                TextField("local currency code", text: $localCurrency)
                
            }
            .navigationTitle("Add Item")
            .toolbar {
                Button("Save Item") {
                    self.expenses.items.append(ExpenseItem(name: itemName, type: type, amount: amount, currencyType: localCurrency))
                    dismiss()
                }
            }
        }
        
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
