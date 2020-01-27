import Foundation

enum BankAccountError: Error{
    case insufficientFunds;
    case invalidAmount;
}

class BankAccount{
    var amount = 0.0
    
    func deposit(funds: Double) throws -> Double{
        if funds < 0 {
            throw BankAccountError.invalidAmount
        }
        amount = amount + funds
        return amount
    }
    
    func withdraw(funds: Double) throws -> Double{
        if funds < 0 {
            throw BankAccountError.invalidAmount
        }
        if funds > amount {
            throw BankAccountError.insufficientFunds
        }
        amount = amount - funds
        return amount
    }
}

let bankAccount = BankAccount()
try! bankAccount.deposit(funds: -20.0)
bankAccount.amount

do{
    let bankAccount = BankAccount()
    try bankAccount.deposit(funds: -20.0)
    bankAccount.amount
} catch BankAccountError.insufficientFunds{
    print("insufficient funds error")
} catch BankAccountError.invalidAmount{
    print("invalid amount error")
} catch {
    print("an error has occured \(error.localizedDescription)")
}

