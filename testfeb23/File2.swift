//
//  File2.swift
//  testfeb23
//
//  Created by Riley Koo on 2/25/24.
//

import Foundation
struct Stack<Element> {
    var items = [Element]()
    var curSize = 0
    mutating func push(_ item: Element) {
        items.append(item)
        curSize += 1
    }
    mutating func pop() -> Element {
        curSize -= 1
        return items.remove(at: curSize)
    }
    mutating func top() -> Element {
        return items[curSize-1]
    }
    mutating func isEmpty() -> Bool {
        //print(curSize)
        return curSize <= 0
    }
    func pr() {
        for x in items {
            print(x)
        }
    }
}
class EquationEval {
    var oper = ["!", "√", "^", "/", "*", "-", "+"]
    func calc(s: String) -> Double{
        return eval(s: convert(s: s))
    }
    func convert(s: String) -> String {
        var ret = ""
        var stk = Stack<String>()
        let arr = s.components(separatedBy: " ")
        //for x in arr {print(x)}
        for x in arr {
            if isOperand(s: x) {
                ret += x + " "
            }
            else if x == "(" {
                stk.push(x)
            }
            else if x == ")" {
                while stk.top() != "(" {
                    ret += stk.pop() + " "
                }
            }
            else if isOperator(s: x) != -1 {
                if stk.isEmpty() {
                    stk.push(x)
                } else {
                    while !stk.isEmpty() && getPrecedence(s: stk.top()) < getPrecedence(s: x) && stk.top() != "(" {
                        ret += stk.pop() + " "
                    }
                    stk.push(x)
                }
            }
        }
        //print(ret)
        //stk.pr()
        while !stk.isEmpty() {
            ret += stk.pop() + " "
        }
        //print(ret)
        return ret
    }
    func eval(s: String) -> Double {
        var stk = Stack<Double>()
        let arr = s.components(separatedBy: " ")
        //for x in arr {print(x)}
        for x in arr {
            if isOperator(s: x) == 0 {
                stk.push(evalEq(op: x, x1: 0, x2: stk.pop()))
            }
            else if isOperator(s: x) != -1 {
                if x == "!" {
                    stk.push(evalEq(op: x, x1: stk.pop(), x2: 0))
                }
                stk.push(evalEq(op: x, x1: stk.pop(), x2: stk.pop()))
            } else if isOperand(s: x) {
                stk.push(Double(x)!)
            }
        }
        return stk.top()
    }
    func evalEq (op: String, x1: Double, x2: Double) -> Double {
        let x = isOperator(s: op) + 1
        switch x {
        case 1:
            return fact(x: Int(x2))
        case 2:
            return pow(x1, 1/x2)
        case 3:
            return pow(x2, x1)
        case 4:
            return x2/x1
        case 5:
            return x2*x1
        case 6:
            return x2-x1
        default:
            return x2+x1
        }
    }
    func isOperator(s: String) -> Int{
        for i in 0..<oper.count {
            if oper[i] == s {
                return i
            }
        }
        return -1
    }
    func isOperand(s: String) -> Bool {
        return Double(s) != nil
    }
    func getPrecedence(s: String) -> Int {
        let x = isOperator(s: s)
        if x == 4{
            return 3
        }
        if x == 6{
            return 5
        }
        return x
    }
    func fact(x: Int) -> Double{
        if x == 0 {
            return 1
        }
        return Double(fact(x: x-1)*Double(x));
    }
}

//class Factory {
//    var oper = ["+", "-", "*", "/", "^", "√", "!"]
//    var stk: Stack<>
//    init (s: String) {
//        postOrder(s: s)
//        stk = Stack<String>()
//    }
//    func postOrder(s: String){
//        let arr = s.components(separatedBy: " ")
//        var b = false
//        var open = false
//        var curOp = ""
//        var tmp = ""
//        for x in arr {
//            if x == ")"{
//                open = false
//                postOrder(s: tmp)
//                tmp = ""
//            }
//            if open {
//                tmp += x
//            }
//            if (isOperator(s: x) != -1) {
//                curOp = x
//            } else if x == "("{
//                open = true
//            } else {
//                stk.push(x)
//                if b {
//                    stk.push(curOp)
//                    b = !b
//                } else {
//                    b = !b
//                }
//            }
//        }
//    }
//    func isOperator(s: String) -> Int{
////        for i in 0..<oper.count {
////            if oper[i] == s {
////                return i
////            }
////        }
//        return -1
//    }
//    func eval(){
//        var tmpStk = Stack<Double>()
//        for x in 0..<stk.curSize {
//            tmpStk.push((stk.items[x] as NSString).doubleValue)
//        }
//        stk = tmpStk
//    }
//    func eval2(){
//        while !stk.isEmpty() {
//            var x = stk.top()
//            let o = isOperator(s: String(x))
//            if o != -1{
//                stk.pop()
//                var a = stk.pop(), b = stk.pop()
//                switch o{
//                case 1:
//                    stk.push(a + b)
//                case 2:
//                    stk.push(a - b)
//                case 3:
//                    stk.push(a * b)
//                case 4:
//                    stk.push(a / b)
//                case 5:
//                    stk.push(pow(a, b))
//                case 6:
//                    stk.push(pow(b, 1/a))
//                default:
//                    stk.push(b)
//                    stk.push(fact(x: Int(a)))
//
//                }
//            } else {
//                stk.push((x as NSString).doubleValue)
//            }
//        }
//    }
//    func fact(x: Int) -> Double{
//        if x == 0 {
//            return 1
//        }
//        return Double(fact(x: x-1)*Double(x));
//    }
//}
