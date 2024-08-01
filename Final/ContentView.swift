//
//  ContentView.swift
//  Final
//
//  Created by Nicholas M Hieb on 7/30/24.
//

import SwiftUI
import Charts

struct income: Identifiable, Equatable, Hashable {
  var id = UUID()
  var type: String
  var amount: Double
}

struct expense: Identifiable, Equatable, Hashable {
  var id = UUID()
  var type: String
  var amount: Double
}

struct ContentView: View {
  @State var incomeItems: [income] = []
  @State var expenseItems: [expense] = []
  @State var totalCashValue: Double = 0.0
  @State var tempIncomeValue: Double = 0.0
  @State var tempExpenseValue: Double = 0.0
  @State var hasCalculated: Bool = false
  
  var body: some View {
    VStack(spacing: 20) {
      NavigationStack {
        
        NavigationLink(destination: Checking(incomeItems: $incomeItems, salesType: "", salesValue: 0.0, tempIncomeValue: $tempIncomeValue, hasCalculated: $hasCalculated)) {
          Text("Income")
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.green.opacity(0.8))
              .foregroundColor(.black)
              .cornerRadius(20)
              .shadow(radius: 5)
        }
        .padding(.horizontal)
        
        
        NavigationLink(destination: Expenses(expenseItems: $expenseItems, salesType: "", salesValue: 0.0, tempExpenseValue: $tempExpenseValue, hasCalculated: $hasCalculated)) {
          Text("Expenses")
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.red.opacity(0.8))
              .foregroundColor(.black)
              .cornerRadius(20)
              .shadow(radius: 5)
        }
        .padding(.horizontal)
        
        NavigationLink(destination: Analysis(incomeItems: $incomeItems, expenseItems: $expenseItems, totalCashValue: $totalCashValue, tempIncomeValue: $tempIncomeValue, tempExpenseValue: $tempExpenseValue, hasCalculated: $hasCalculated)) {
          Text("Analysis")
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.blue.opacity(0.8))
              .foregroundColor(.black)
              .cornerRadius(20)
              .shadow(radius: 5)
        }
        .padding(.horizontal)
        
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
