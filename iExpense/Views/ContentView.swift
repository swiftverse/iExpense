
//  ContentView.swift
//  iExpense
//
//  Created by Amit Shrivastava on 28/11/21.


import SwiftUI


class Expenses: ObservableObject {

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {

                items = decodedItems
                return

            }
        }

        items = []
    }
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State var showAdd = false
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items){
                    item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)")
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        if(item.amount < 10) {
                            Text(item.amount, format: .currency(code: item.currencyType))
                                .font(.title)
                                .foregroundColor(.green)
                        }

                        else if (item.amount > 10 && item.amount < 100){
                            Text(item.amount, format: .currency(code: item.currencyType))
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        else {
                            Text(item.amount, format: .currency(code: item.currencyType))
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                .onDelete(perform: removeItems)
                .sheet(isPresented: $showAdd) {
                        AddView(expenses: expenses)
                    }
        }
        .toolbar {
            Button{
                self.showAdd = true
            }
        label: {
            Image(systemName: "plus")

            }
        }
        .navigationTitle("iExpense")

        }
    }




    func removeItems(offset: IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}



