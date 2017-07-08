//
//  main.swift
//  MLSwiftified
//
//  Created by Gunapandian on 04/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//

let numberMatrix :Matrix = [[1,2,3,4,5],[2,3,4,22,33]]

let stringMatrix :Matrix = [["11","22","33","44","55"],["2","3","4","22","33"]]

let mixedMatrix : Matrix = [["Guna",3,"pandian"] , ["Dinesh",4.92,"SwiftGuru"]]

print(mixedMatrix)

let x: Matrix = [[10, 9, 8], [3, 2, 1]]
let y: Matrix = [[1, 2, 3], [4, 5, 6]]
let z: Matrix = [[1, 2], [3, 4], [5, 6]]



let vec : Vector = [1,2,3,4,5,6,7,8]

let sumMax = x + y
let maxMul = x * y
let maxDiv = x / y

let scalarMul = 2 * x
let reverseScalarMul = x * 3
let scalarDiv = x / 3

let trans = transpose(max: x)
let sumVal = sum(y)
let squareValue = squareOf(max: x)

let twoDim =  convert(Darray: z, column: z.columnCount)
let row  = getRow(rowIndex: 1, twoDArray: [[1,2,3,4,1],[56,12,45,78,89]])
let column  = getColumn(column: 4, twoDArray: [[1,2,3,4,1],[56,12,45,78,89]])


//Applying For loop directly in to matrix
for value in x {
   print(value)
}

//Appling in line closure directly in to matrix
let mapw = x.map{$0}
let sort = x.sorted(by: { s1, s2 in s1 > s2 } )
let flatM = x.flatMap{$0}


//Try to learn from data from files which as population and reveue for a foodchain company
//and predict revenue for a given population number

  try? DataLogger.readCsvFile{ (value :readCsvResultType) in
    let features =  value.0
    let labels = value.1
    let res  =  Matrix.init(DataLogger.addXeroParameter(max: features))
    let ml =    MLLinearRegression<Float>(xValue: res,yValue: Matrix.init(labels))
    
    let thetaval : Matrix<Float> = [[Float(0.0)],[Float(0.0)]]
        ml.minimizeGradientDecent(theta:thetaval,iters: 1500, dataLen: Float(res.data.count), aplha: Float(0.01)){ (val) in
        print(val)
        let predict1 = [[1, 13.9]] * val
        print(predict1)
    }
}





//let max :Matrix = [[1,2,3],[2,3,4]]
//let max2 :Matrix = [[1,2,3],[2,3,4]]
//
//let ma2 :Matrix = [[1,2],[2,3],[3,4]]
//let ma2w :Matrix = [[1],[23],[34] ,[23] ,[45]]
//let vec : Vector = [1,2,3,4,5,6,7]


//let valu = max[1,5]

//for item in ma2 {
//        print(item)
//}
//print(max * ma2)

//let value = convert(Darray: ma2, column: 5)
//let value2 = getColumn(column: 2, twoDArray:value)
//let value3 = getRow(rowIndex: 1, twoDArray: value)


//print(transpose(vec: vec))
//var transposew = transpose(vec: vec)
//print(convert(Darray: transpose(max: transposew), column: transposew.columnCount))


//Matrix.convert(Darray:max.data, column: 5)

