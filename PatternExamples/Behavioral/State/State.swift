import Foundation


// MARK: - Theory
/*
 Состояние — это поведенческий паттерн проектирования, который позволяет объектам менять поведение в зависимости от своего состояния. Извне создаётся впечатление, что изменился класс объекта.
 Когда применять Состояние?
 ● Если имеется объект, который значительно меняет свою функциональность при изменении внутреннего состояния.
 ● Если существует множество условных операторов, которые выбирают действие в зависимости от какой-либо переменной.
 Как применять Состояние?
 1. Реализовать интерфейс для Состояний.
 2. Создать конкретные возможные Состояния объекта.
 3. Реализовать класс объекта с применением созданных состояний.
 4. Создать методы для изменения Состояния объекта.
 Паттерн Состояние позволяет избавиться от множества условных операторов, хранит код, отвечающий за определенное состояние, в одном месте. Однако, применение паттерна может привести к значительному усложнению кода, если возможных состояний мало, и они оказывают недостаточное влияние на объект. В этом случае применение паттерна не окупается.
 */
// MARK: - Test

class State {

    static func testExampleWithPrinter() {
        print("create printer")
        let printer = Printer(name: "'192.168.0.10'")
        print("try to turn off")
        printer.turnOff()
        print("try to turn on")
        printer.turnOn()
        print("try to print")
        printer.printing()
        print("try to print 2time")
        printer.printing()
        print("try to turn on")
        printer.turnOn()
        print("try to turn off")
        printer.turnOff()
        print("try to printing")
        printer.printing()
        
    }

}

// MARK: - Example №1 -

/*
 Есть принтер(контекст) у него 3 состояния: включен, выключен и печатает. В зависимости от его состояния его методы должны отрбатывать по разному.
*/


// MARK: protocols
fileprivate protocol PrinterState {
    func on(printer: Printer)
    func off(printer: Printer)
    func printing(printer: Printer)
}

// MARK: classes

fileprivate class Printer {
    var name: String
    private var state: PrinterState
    
    enum State {
        case on
        case off
        case printing
    }
    
    
    init(name: String) {
        self.name = name
        state = PrinterOff()
    }
    
    func set(state: State) {
        switch state {
        case .on:
            self.state = PrinterOn()
        case .off:
            self.state = PrinterOff()
        case .printing:
            self.state = PrinterPrinting()
        }
    }
    
    func turnOn() {
        state.on(printer: self)
    }
    func turnOff() {
        state.off(printer: self)
    }
    func printing() {
        state.printing(printer: self)
    }
}

fileprivate class PrinterOn: PrinterState {
    func on(printer: Printer) {
        print("printer \(printer.name) is already turn on")
    }
    
    func off(printer: Printer) {
        print("turning printer \(printer.name) off")
        printer.set(state: .off)
    }
    
    func printing(printer: Printer) {
        print("printer \(printer.name) is printing")
        printer.set(state: .printing)
    }
}

fileprivate class PrinterOff: PrinterState {
    func on(printer: Printer) {
        print("turning printer \(printer.name) on")
        printer.set(state: .on)
    }
    
    func off(printer: Printer) {
        print("printer \(printer.name) is already turn off")
    }
    
    func printing(printer: Printer) {
        print("printer \(printer.name) is turn off, please turn on it and try to print")
    }
}

fileprivate class PrinterPrinting: PrinterState {
    func on(printer: Printer) {
        print("printer \(printer.name) is already turn on")
    }
    
    func off(printer: Printer) {
        print("turning printer \(printer.name) off")
        printer.set(state: .off)
    }
    
    func printing(printer: Printer) {
        print("printer \(printer.name) already is printing")
    }
}

