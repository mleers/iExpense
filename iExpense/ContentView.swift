//
//  ContentView.swift
//  iExpense
//
//  Created by Mitch on 10/20/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal Items")) {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(item.amount < 10 ? .green: item.amount < 100 ? .orange: .red)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section(header: Text("Business Items")) {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(item.amount < 10 ? .green: item.amount < 100 ? .orange: .red)
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
//    old generic remove item function
//    func removeItems(at offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
//    }
    
    func removePersonalItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalItems[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.businessItems[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
