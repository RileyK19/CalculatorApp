//
//  ContentView.swift
//  testfeb23
//
//  Created by Riley Koo on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        stackBased()
        //graphs()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct stackBased: View {
    @State var text: String = " "
    @State var eval: EquationEval = EquationEval()
    @State var prev: [String] = [" ", " ", " ", " ", " "]
    @State var clicked = false
    @State var curPrev = 5
    @State var clear = true
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(spacing: 15){
            Spacer()
            Text("Calculator")
                .padding(15)
                .font(.system(size: 25))
                .multilineTextAlignment(.leading)
            Spacer()
            VStack{
                ForEach(Array(prev.count-5..<prev.count), id: \.self) { x in
                    Button(prev[x], action: {
                        text = prev[x]
                        text = text.components(separatedBy: " = ")[0]
                        clicked = false
                        curPrev = x
                        clear = false
                    })
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .opacity(0.4)
                    .font(.system(size: 25))
                }
            }
            Text(text)
                .padding(15)
                .font(.system(size: 40))
                .multilineTextAlignment(.leading)
            Spacer()
            HStack{
                if !clear {
                    Button{
                        text = " "
                        clicked = false
                        clear = true
                    } label: {
                        Text("C")
                    }
                    .foregroundColor(.green)
                    .padding(25)
                    .font(.system(size: 15))
                    /*.padding(20)
                     .ignoresSafeArea()
                     .foregroundColor(.green)
                     .font(.system(size: 30))
                     .font(.headline.weight(.bold))
                     .background{
                     Circle()
                     .foregroundColor(.black)
                     .opacity(0.5)
                     .frame(width: 60, height: 60)
                     .ignoresSafeArea()
                     }*/
                } else {
                    Button{
                        prev = [" ", " ", " ", " ", " "]
                    } label: {
                        Text("AC")
                    }
                    .foregroundColor(.green)
                    .padding(25)
                    .font(.system(size: 15))
                }
                Button{
                    text += " ( "
                    clicked = true
                    clear = false
                } label: {
                    Text("(")
                }
                .foregroundColor(.green)
                .padding(25)
                .font(.system(size: 20))
                Button{
                    text += " ) "
                    clicked = true
                    clear = false
                } label: {
                    Text(")")
                }
                .foregroundColor(.green)
                .padding(25)
                .font(.system(size: 20))
                Button{
                    var tmp = text.components(separatedBy: " ")
                    tmp[tmp.count-1] = "-" + tmp[tmp.count-1]
                    text = ""
                    for x in tmp {
                        text += x + " "
                    }
                    text = String(text.dropLast())
                    //text += ""
                    clicked = true
                    clear = false
                } label: {
                    Text("±")
                }
                .foregroundColor(.green)
                .padding(25)
                .font(.system(size: 20))
                Button{
                    if !clicked {
                        text = " "
                    }
                    if curPrev > 5 {
                        text += prev[curPrev-1].components(separatedBy: " = ")[1]
                    }
                    clicked = true
                    clear = false
                } label: {
                    Text("ans")
                }
                .foregroundColor(.green)
                .padding(25)
                .font(.system(size: 15))
            }
            ForEach (Array(1..<4), id: \.self) { x in
                HStack {
                    ForEach(Array(0..<3), id: \.self) { y in
                        Button{
                            if !clicked {
                                text = " "
                            }
                            text += String((3-x)*3 + y+1)
                            clicked = true
                            clear = false
                        } label: {
                            Text(String((3-x)*3 + y+1))
                        }
                            .foregroundColor(.green)
                            .padding(25)
                            .font(.system(size: 20))
                        }
                        if x == 1 {
                            Button{
                                text += " + "
                                clicked = true
                                clear = false
                            } label: {
                                ZStack{
                                    Text("+")
                                }
                            }
                            .foregroundColor(.green)
                            .padding(25)
                            .font(.system(size: 20))
                            Button{
                                text += " ^ "
                                clicked = true
                                clear = false
                            } label: {
                                Text("^")
                            }
                            .foregroundColor(.green)
                            .padding(25)
                            .font(.system(size: 20))
                        } else if x == 2 {
                            Button{
                                text += " - "
                                clicked = true
                                clear = false
                            } label: {
                                Text("-")
                            }
                            .foregroundColor(.green)
                            .padding(25)
                            .font(.system(size: 20))
                            Button{
                                text += " √ "
                                clicked = true
                                clear = false
                            } label: {
                                Text("√")
                            }
                            .foregroundColor(.green)
                            .padding(25)
                            .font(.system(size: 20))
                        } else {
                            Button{
                                text += " * "
                                clicked = true
                                clear = false
                            } label: {
                                Text("*")
                            }
                            .foregroundColor(.green)
                            .padding(25)
                            .font(.system(size: 20))
                            Button {
                                if !clicked {
                                    text = " "
                                }
                                text += " ! "
                                clicked = true
                                clear = false
                            } label: {
                                Text("!")
                            }
                            .foregroundColor(.green)
                            .padding(25)
                            .font(.system(size: 20))
                        }
                    }
                }
                HStack{
                    Button{
                        if !clicked {
                            text = " "
                        }
                        text += "0"
                        clicked = true
                        clear = false
                    } label: {
                        Text("0")
                    }
                    .foregroundColor(.green)
                    .padding(25)
                    .font(.system(size: 20))
                    Button{
                        if !clicked {
                            text = " "
                        }
                        text += "."
                        clicked = true
                        clear = false
                    } label: {
                        Text(".")
                    }
                    .foregroundColor(.green)
                    .padding(25)
                    .font(.system(size: 20))
                    Button{
                        if clicked {
                            if text.last == " "{
                                text = String(text.dropLast())
                                text = String(text.dropLast())
                                text = String(text.dropLast())
                            } else {
                                text = String(text.dropLast())
                            }
                        }
                    } label: {
                        Text("←")
                    }
                    .foregroundColor(.green)
                    .padding(25)
                    .font(.system(size: 20))
                    Button{
                        text += " / "
                        clicked = true
                        clear = false
                    } label: {
                        Text("/")
                    }
                    .foregroundColor(.green)
                    .padding(25)
                    .font(.system(size: 20))
                    Button{
                        if text == ""{
                            text = prev[curPrev - 1].components(separatedBy: " = ")[1]
                        } else {
                            curPrev += 1
                            let tmp = eval.calc(s: text)
                            text += " = "
                            text += String(tmp)
                            prev.append(text)
                            text = String(tmp)
                            clicked = false
                            clear = false
                        }
                    } label: {
                        Text("=")
                    }
                    .foregroundColor(.green)
                    .padding(25)
                    .font(.system(size: 20))
                }
            }
            Spacer()
        }
    }


//Button("↑", action:{
//    if (curPrev >= 0){
//        text = prev[curPrev-1]
//        text = text.components(separatedBy: " =")[0]
//        clicked = false
//        curPrev -= 1
//    }
//})
//.padding()
//Button("↓", action:{
//    if (curPrev < prev.count){
//        text = prev[curPrev+1]
//        text = text.components(separatedBy: " =")[0]
//        clicked = false
//        curPrev += 1
//    }
//})
//.padding()

//struct graphs: View {
//    @State var frame = frameFromCorners()
//    var body: some View {
//        Button {
//            
//        }
//    }
//}

struct nonStackBased : View {
    @State var clicked: [Double] = [0]
    @State var c: Calc = Calc()
    @State var click: Bool = false
    @State var numClick = 0
    @State var s: String = ""
    @State var curOp: [String] = []
    @State var prev: [String] = [" ", " ", " ", " ", " ", " "]
    @State var curString: Int = 1
    @State var typing = false
    @State var dec = false
    @State var decNum: Double = 0
    var body: some View {
        VStack {
            Text("Calculator :D")
            Spacer()
            Spacer()
            ForEach(Array(prev.count-5..<prev.count), id: \.self) { x in
                if (x > 0){
                    Text(prev[x])
                        .opacity(0.5)
                }
            }
            .fixedSize()
            Text(s)
                .fixedSize()
            Spacer()
            HStack{
                ForEach(Array(1..<4), id: \.self) { x in
                    VStack{
                        ForEach(Array(0..<3), id: \.self) { y in
                            Button(String(y*3 + x), action:{
                                if (!click){
                                    if (typing){
                                        /*for _ in 0..<decNum {
                                            c.curNum *= 10
                                        }*/
                                        if (!dec){
                                            c.curNum *= 10
                                            c.curNum += Double(y*3 + x)
                                        } else {
                                            c.curNum += (Double(y*3 + x) * pow(10, -(decNum+1)))
                                            decNum += 1
                                        }
                                        /*if dec {
                                            for _ in 0..<decNum {
                                                c.curNum /= 10
                                            }
                                            decNum += 1
                                        }*/
                                    } else {
                                        prev.append(s)
                                        curString += 1
                                        c.curNum = Double(y*3 + x)
                                        s = ""
                                        typing = true
                                        decNum = 0
                                        dec = false
                                    }
                                } else {
                                    /*for _ in 0..<decNum {
                                        clicked[numClick] *= 10
                                    }*/
                                    if (!dec){
                                        clicked[numClick] *= 10
                                        clicked[numClick] += Double(y)*3 + Double(x)
                                    } else {
                                        clicked[numClick] += (Double(y*3 + x) * pow(10, -(decNum+1)))
                                        decNum += 1
                                    }
                                    /*for _ in 0..<decNum {
                                        clicked[numClick] /= 10
                                    }
                                    decNum += 1*/
                                }
                                s += String(y*3 + x)
                            })
                            .padding()
                        }
                    }
                    .fixedSize()
                }
                VStack{
                    HStack{
                        Button("+", action: {
                            s += "+"
                            curOp.append("+")
                            click = true
                            numClick += 1
                            clicked.append(0)
                            dec = false
                            decNum = 0
                        })
                        .padding()
                        Button("-", action: {
                            s += "-"
                            curOp.append("-")
                            click = true
                            numClick += 1
                            clicked.append(0)
                            dec = false
                            decNum = 0
                        })
                        .padding()
                    }
                    HStack{
                        Button("*", action: {
                            s += "*"
                            curOp.append("*")
                            click = true
                            numClick += 1
                            clicked.append(0)
                            dec = false
                            decNum = 0
                        })
                        .padding()
                        Button("/", action: {
                            s += "/"
                            curOp.append("/")
                            click = true
                            numClick += 1
                            clicked.append(0)
                            dec = false
                            decNum = 0
                        })
                        .padding()
                    }
                    HStack{
                        Button("^", action: {
                            s += "^"
                            curOp.append("^")
                            click = true
                            numClick += 1
                            clicked.append(0)
                            dec = false
                            decNum = 0
                        })
                        .padding()
                        Button("x√", action: {
                            s += "√"
                            curOp.append("sqrt")
                            click = true
                            numClick += 1
                            clicked.append(0)
                            dec = false
                            decNum = 0
                        })
                        .padding()
                    }
                }
            }
            .fixedSize()
            HStack{
                Button("!", action: {
                    s += "!"
                    curOp.append("!")
                    clicked.append(0)
                    numClick += 1
                    click = false
                    decNum = 0
                })
                .padding()
                Button(".", action: {
                    s += "."
                    dec = true
                })
                .padding()
                
            }
            HStack{
                Button(String(0), action:{
                    if (!click){
                        if (typing){
                            /*for _ in 0..<decNum {
                                c.curNum *= 10
                            }*/
                            if (!dec){
                                c.curNum *= 10
                                c.curNum += Double(0)
                            } else {
                                decNum += 1
                            }
                            /*if dec {
                                for _ in 0..<decNum {
                                    c.curNum /= 10
                                }
                                decNum += 1
                            }*/
                        } else {
                            prev.append(s)
                            curString += 1
                            c.curNum = Double(0)
                            s = ""
                            decNum = 0
                            dec = false
                        }
                    } else {
                        /*for _ in 0..<decNum {
                            clicked[numClick] *= 10
                        }*/
                        if (!dec){
                            clicked[numClick] *= 10
                        } else {
                            decNum += 1
                        }
                        /*if dec {
                            for _ in 0..<decNum {
                                clicked[numClick] /= 10
                            }
                            decNum += 1
                        }*/
                    }
                    print(String(c.curNum))
                    s += String(0)
                })
                .padding()
                Button("C", action: {
                    c.curNum = 0
                    prev = [" ", " ", " ", " ", " "]
                    curString = 1
                    s = ""
                    curOp = []
                    clicked = [0]
                    numClick = 0
                    click = false
                    typing = false
                    dec = false
                    decNum = 0
               })
                .padding()
                Button("<-", action: {
                    if (curString > 0){
                        c.unexecute()
                        typing = false
                        click = false
                        curOp = []
                        clicked = []
                        numClick = 0
                        curString -= 1
                        s = prev[curString]
                        dec = false
                        decNum = 0
                    }
               })
                .padding()
                Button("->", action: {
                    if (curString < prev.count){
                        c.execute()
                        click = false
                        typing = false
                        curOp = []
                        clicked = [0]
                        numClick = 0
                        curString += 1
                        s = prev[curString]
                        dec = false
                        decNum = 0
                    }
               })
                .padding()
                Button("=", action: {
                    for i in 0..<numClick {
                        c.makeCmd(s: curOp[i], i: clicked[i+1])
                        c.execute()
                    }
                    s += "="
                    curOp = []
                    clicked = [0]
                    numClick = 0
                    click = false
                    typing = false
                    prev.append(s)
                    curString += 1
                    s = String(c.curNum)
                    dec = false
                    decNum = 0
               })
                .padding()
            }
            .fixedSize()
        }
        .fixedSize()
    }
}
