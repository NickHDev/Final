//
//  Analysis.swift
//  Final
//
//  Created by Nicholas M Hieb on 7/31/24.
//

import SwiftUI
import Charts

struct Analysis: View {
  @Binding var incomeItems: [income]
  @Binding var expenseItems: [expense]
  @Binding var totalCashValue: Double
  @Binding var tempIncomeValue: Double
  @Binding var tempExpenseValue: Double
  @Binding var hasCalculated: Bool

  struct ChartStruct {
    var type: String
    var value: Double
  }
  
  func changeTotal() {
    totalCashValue = tempIncomeValue + tempExpenseValue
    hasCalculated = true
  }
  

  var body: some View {
    
    
    VStack(alignment: .trailing) {
      
      Text("Total Net Cash: \(totalCashValue, specifier: "%.2f")")
        .font(.title2)
        .foregroundColor(.primary)
        .padding(.bottom, 10)
      
      VStack {
        Text("Income")
          .font(.headline)
        Chart(incomeItems, id: \.self) { item in
          BarMark(
            x: .value("Category", item.type),
            y: .value("Value", item.amount)
          )
          .foregroundStyle(Color.green)
        }
        .frame(height: 200)
      }
      
      VStack {
        Text("Expenses")
          .font(.headline)
        Chart(expenseItems, id: \.self) { item in
          BarMark(
            x: .value("Category", item.type),
            y: .value("Value", item.amount)
          )
          .foregroundStyle(Color.red)
        }
        .frame(height: 200)
      }
      
      
    }
    .padding()
    .onAppear {
      if(hasCalculated == false) {
        changeTotal()
      }
    }
    
    
  }
}
