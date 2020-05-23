import Foundation


// MARK: - Theory
/*
 Команда – это поведенческий паттерн проектирования, который позволяет инкапсулировать запросы на выполнение некоторого действия в виде конкретного объекта. Все объекты, которые инициируют запрос на выполнение действия, отделены от объектов, выполняющих это действие.

 Когда применять Команду?
 ● Если необходимо помещать операции в очередь и выполнять их по расписанию.
 ● Если необходимо реализовать операцию отмены.
 Как применять Команду?
 1. Реализовать общий класс для команды с методом для выполнения действия.
 2. Создать конкретные реализации для команд.
 3. Создать класс, который будет хранить и отправлять команды.
 Команда позволяет избавиться от прямой зависимости между объектами, которые выполняют операции и которые их вызывают, позволяет реализовать отложенный запуск команд, создавать сложные команды из более простых, а также реализует принцип открытости / закрытости. Однако паттерн Команда усложняет проект за счет введения дополнительных классов.
 
 Объект команды — это то, что должно быть выполнено, но обычно через какое-то время. До этого момента объект команды хранится в памяти и даже может изменяться. Паттерн «команда» служит для того, чтобы описать и сохранить действие, которое должно быть выполнено позже.
 
 Invoker («вызывающий») — объект, который хранит команды и ставит их на исполнение. Это контроллер для команд.
 Command — непосредственно объект команды. Он инкапсулирует действие, которое должно быть выполнено позднее.
 Receiver («получатель») — объект, который получает команды. Именно он делает всю основную работу. Он получает команды, но они содержат лишь описание действия. Само действие делает receiver.
 */
// MARK: - Test

class Commands {

    static func testExampleWithBankOPeration() {
        
        let transactionManager = TransactionManager.sharedInstance
        let dimaAcc = Account(name: "Dima")
        let temaAcc = Account(name: "Tema", balance: 20000)
        let kuzinAcc = Account(name: "Kuzya", balance: 50000)
        
        let arr = [dimaAcc,temaAcc,kuzinAcc]
        
        transactionManager.addTransaction(transaction: Decrease(account: temaAcc, value: 50))
        transactionManager.addTransaction(transaction: Deposit(account: dimaAcc, value: 50))
        transactionManager.addTransaction(transaction: Credit(account: kuzinAcc, value: 500000000))
        
        transactionManager.addTransaction(transaction: Decrease(account: dimaAcc, value: 600))
        
//        transactionManager.printTransactionsInQue()
        printAccountsBalance(accounts: arr)
        
        print("do transactions")
        transactionManager.performTransactions()
        
        print("clear transactions")
        transactionManager.clearCompleteTransaction()
        transactionManager.printTransactionsInQue()
        printAccountsBalance(accounts: arr)
        
    }
    private static func printAccountsBalance(accounts: [Account]) {
        for acc in accounts {
            print("\(acc.name) account balance is \(acc.balance)")
        }
    }

}

// MARK: - Example №1 -

/*
у нас есть Счета в банке, и счетом можно выполнить три операции поплнение уменьшение и пополнение кредитом, как реализовать это с помощью паттерна комманд описаны ниже
 */


// MARK: protocols

/// интерфейс Command
fileprivate protocol Command {
    
    func execute()
    var isComplette: Bool { get set }
    
    var idOfOperation: String { get }
    
}

// MARK: classes
///счет клиента (Receiver)
fileprivate class Account {
    var name: String
    var balance: Double
    var credit: Double = 0
    
    init(name: String, balance: Double = 0) {
        self.name = name
        self.balance = balance
    }
}
///операция пополнения денег
fileprivate class Deposit: Command {
    
    var idOfOperation: String
    private var account: Account
    var isComplette: Bool = false
    private var operationValue: Double
    
    init(account: Account, value: Double) {
        self.account = account
        self.operationValue = value
        self.idOfOperation = UUID().uuidString
    }
    
    func execute() {
        account.balance += operationValue
        isComplette = true
    }
}
///операция выдачи кредита
fileprivate class Credit: Command {
    
    var idOfOperation: String
    private var account: Account
    var isComplette: Bool = false
    private var operationValue: Double
    
    init(account: Account, value: Double) {
        self.account = account
        self.operationValue = value
        self.idOfOperation = UUID().uuidString
    }
    
    func execute() {
        account.balance += operationValue
        account.credit += operationValue * 1.25
        isComplette = true
    }
}
///операция списывание денег
fileprivate class Decrease: Command {
    
    var idOfOperation: String
    private var account: Account
    var isComplette: Bool = false
    private var operationValue: Double
    
    init(account: Account, value: Double) {
        self.account = account
        self.operationValue = value
        self.idOfOperation = UUID().uuidString
    }
    
    func execute() {
        if operationValue < account.balance {
            account.balance -= operationValue
            isComplette = true
        } else {
            print("Not enough money on balance")
        }
    }
}
///Invoker
fileprivate class TransactionManager {
    
    static let sharedInstance = TransactionManager()
    private init() {}
    
    var commands = [Command]()
    
    func addTransaction(transaction: Command) {
        commands.append(transaction)
    }
    
    func performTransactions() {
        commands.filter { $0.isComplette == false }.forEach { $0.execute() }
    }
    
    func printTransactionsInQue() {
        for operation in commands {
            print("trans ID = '\(operation.idOfOperation)'")
            print("type of trans = '\(operation.self)'")
            print("isCompleting? = \(operation.isComplette) ")
            print("------------")
        }
    }
    
    func clearCompleteTransaction() {
        var newCommand = [Command]()
        commands.filter { $0.isComplette == false }.forEach { newCommand.append($0) }
        commands = newCommand
    }
    
}
