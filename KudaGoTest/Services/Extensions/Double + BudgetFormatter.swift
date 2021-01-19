//
//  Double + BudgetFormatter.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import Foundation

extension Double {
    public func budgetFormater(budgetCurrency bc: String?) -> String {
        guard let bc = bc else { return "" }
        var symbol = ""
        switch bc {
        case BudgetCurrency.rub.rawValue: symbol = "₽"
        case BudgetCurrency.usd.rawValue: symbol = "$"
        case BudgetCurrency.eur.rawValue: symbol = "€"
        default: break
        }
        
        if self > 1000000 { // 1 mln
            return "\(Int(self / 1000000)) млн \(symbol)"
        }
        
        return "\(Int(self)) \(symbol)"
    }
    
    private enum BudgetCurrency: String {
        case rub = "RUB"
        case usd = "USD"
        case eur = "EUR"
    }
}
