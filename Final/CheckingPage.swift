//
//  CheckingPage.swift
//  Final
//
//  Created by Nicholas M Hieb on 7/30/24.
//

import SwiftUI

struct Checking: View {
  @Binding var incomeItems: [income]
  @State var salesType: String
  @State var salesValue: Double
  @Binding var tempIncomeValue: Double
  @Binding var hasCalculated: Bool
  
  enum salesTypes: String, CaseIterable{
    case wages,investments,rental,misc
    
    var displayName: String {
      switch self {
      case .wages: return "Wages"
      case .investments: return "Investments"
      case .rental: return "Rental"
      case .misc: return "Misc"
      }
    }
  }
  
  func totalCash() {
    tempIncomeValue = incomeItems.reduce(0) {
      $0 + $1.amount
    }
    hasCalculated = false
  }
  
  var body: some View {
    Text("Income")
      .font(.title)
    VStack(alignment: .leading) {
      HStack {
        Text("Income Type:")
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
        let newItem = income(type: salesType, amount: salesValue)
        incomeItems.append(newItem)
      }, label: {
        Text("Add Item")
          .padding(5)
          .border(Color.blue, width: 2)
      })
      
      List {
        ForEach(incomeItems, id: \.self) { item in
          HStack {
            
            Button(role: .destructive, action: {
              let index = incomeItems.firstIndex(of: item)
              incomeItems.remove(at: index ?? 0)
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
              .foregroundStyle(.green)
          }
          
        }
      }
      .onChange(of: incomeItems) {
        totalCash()
      }
      Text("Total Income: $ \(tempIncomeValue, specifier: "%.2f")")
        .foregroundStyle(.green)
    }.padding(5)
    
    
  }
}
