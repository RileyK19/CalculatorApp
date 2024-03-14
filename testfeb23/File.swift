//
//  File.swift
//  testfeb23
//
//  Created by Riley Koo on 2/23/24.
//

import Foundation
class Calc{
    var curNum: Double
    var cmds: [Command] = []
    var doNothing: Bool
    init (){
        curNum = 0
        doNothing = false
    }
    func makeCmd(s: String, i: Double){
        switch (s){
        case "+":
            cmds.append(AddCmd(x: i, n: curNum))
        case "-":
            cmds.append(AddCmd(x: -1*i, n: curNum))
        case "*":
            cmds.append(MultCmd(x: i, n: curNum))
        case "/":
            cmds.append(MultCmd(x: 1/i, n: curNum))
        case "^":
            cmds.append(ExpoCmd(x: i, n: curNum))
        case "sqrt":
            cmds.append(ExpoCmd(x: 1/curNum, n: i))
        case "!":
            cmds.append(FactCmd(n: curNum))
        default:
            doNothing = !doNothing
        }
    }
    func execute(){
        let cmd = cmds.first(where: {c in
            !c.executed
        })
        if (cmds.contains(where: {c in !c.executed})){
            cmd!.execute()
            curNum = cmd!.curNum
        }
    }
    func unexecute(){
        let c = cmds.last(where: {c in c.executed})
        if (cmds.contains(where: {c in c.executed})){
            c!.unexec()
            curNum = c!.curNum
        }
    }
}
class Command{
    init (){
        curNum = 0
        executed = false
    }
    init (n: Double){
        curNum = n
        executed = false
    }
    func execute(){}
    func unexec(){}
    var curNum: Double
    var executed: Bool
}
class AddCmd : Command{
    var addNum: Double
    init (x: Double){
        addNum = x
        super.init()
    }
    init (x: Double, n: Double){
        addNum = x
        super.init(n: n)
    }
    override func execute() {
        executed = true
        curNum += Double(addNum)
    }
    override func unexec() {
        executed = false
        curNum -= Double(addNum)
    }
}
class MultCmd : Command{
    var multInt: Double
    init (x: Double){
        multInt = x
        super.init()
    }
    init (x: Double, n: Double){
        multInt = x
        super.init(n: n)
    }
    override func execute() {
        executed = true
        curNum *= Double(multInt)
    }
    override func unexec() {
        executed = false
        curNum /= Double(multInt)
    }
}
class ExpoCmd : Command{
    var expoInt: Double
    init (x: Double){
        expoInt = x
        super.init()
    }
    init (x: Double, n: Double){
        expoInt = x
        super.init(n: n)
    }
    override func execute() {
        executed = true
        curNum = pow(curNum, Double(expoInt))
    }
    override func unexec() {
        executed = false
        curNum = pow(curNum, 1/Double(expoInt))
    }
}
class FactCmd : Command{
    override init (n: Double){
        super.init(n: n)
    }
    override func execute() {
        executed = true
        curNum = fact(num: Double(curNum))
    }
    private func fact(num: Double) -> Double{
        if (num <= 0){
            return 1
        }
        return num*fact(num: num-1)
    }
    override func unexec() {
        executed = false
        curNum = unfact(target: curNum, cur: 1, mult: 1)
    }
    private func unfact(target: Double, cur: Double, mult: Double) -> Double{
        if (cur > target){
            return -1
        } else if (cur == target){
            return mult
        }
        return unfact(target: target, cur: cur*mult, mult: mult+1)
    }
}
