//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Amit Shrivastava on 29/11/21.
//

import Foundation

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let name: String
    let type: String
    let amount: Double
    let currencyType: String
    var id = UUID()
}
