//
//  Expenses.swift
//  iExpense
//
//  Created by Mitch on 10/21/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
