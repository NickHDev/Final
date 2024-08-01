//
//  ExpensesPage.swift
//  Final
//
//  Created by Nicholas M Hieb on 7/31/24.
//

import SwiftUI

struct Expenses: View {
  @Binding var expenseItems: [expense]
  @State var salesType: String
  @State var salesValue: Double
  @Binding var tempExpenseValue: Double
  @Binding var hasCalculated: Bool
  
  enum salesTypes: String, CaseIterable{
    case food,shopping,bills,misc
    
    var displayName: String {
      switch self {
      case .food: return "Food/Drink"
      case .shopping: return "Shopping"
      case .bills: return "Bills"
      case .misc: return "Misc"
      }
    }
  }
  
  func totalCash() {
    tempExpenseValue = expenseItems.reduce(0) {
      $0 - $1.amount
    }
    hasCalculated = false
  }
  
  var body: some View {
    Text("Expenses")
      .font(.title)
    VStack(alignment: .leading) {
      HStack {
        Text("Sales Type:")
        Menu("Type") {
          ForEach(salesTypes.allCases, id: \.self) { sales in
            Button(sales.displayName) {
              salesType = sales.displayName
            }
          }
        }.buttonStyle(.bordered)
        Text("Type Selected: \(salesType)")
      }
      
      Divider()
        .background(.black)
      
      TextField("Enter Amount",
                value: $salesValue,
                format: .number)
        .textFieldStyle(.roundedBorder)
        .padding(5)
      
      Button(action: {
        let newItem = expense(type: salesType, amount: salesValue)
        expenseItems.append(newItem)
      }, label: {
        Text("Add Item")
          .padding(5)
          .border(Color.blue, width: 2)
      })
      
      List {
        ForEach(expenseItems, id: \.self) { item in
          HStack {
            
            Button(role: .destructive, action: {
              let index = expenseItems.firstIndex(of: item)
              expenseItems.remove(at: index ?? 0)
            }, label: {
              Image(systemName: "trash")
                .foregroundStyle(.red)
            })
            .buttonStyle(PlainButtonStyle())
            
            Divider()
              .background(.black)
            
            Text("\(item.type)")
            Spacer()
            Text("$\(item.amount, specifier: "%.2f")")
              .foregroundStyle(.red)
          }
        }
      }
      .onChange(of: expenseItems) {
        totalCash()
      }
      Text("$ \(tempExpenseValue, specifier: "%.2f")")
        .foregroundStyle(.red)
    }
  }
}
