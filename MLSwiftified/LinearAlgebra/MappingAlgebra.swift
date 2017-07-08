//
//  MappingAlgebra.swift
//  MLSwiftified
//
//  Created by Gunapandian on 05/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//

//This file contains  matrix and vector arithmetic operations ,
//linear  algebra , transponse , 1D to 2D matrix convertion ,Summation over matrix
//get particular row or column


// Negative mapping for matrix elements
public prefix func -<T: SignedNumericArithmeticType>(value: Matrix<T>) -> Matrix<T> {
    return [value.map(-) ]
}

//Adding two matrix
public func +<T: NumericArithmeticType>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    if lhs.columnCount != rhs.columnCount || rhs.rowCount != lhs.rowCount {
        fatalError(MatrixDimError.InnerDimMisMatch.rawValue)
    }
    return [zip(lhs.data, rhs.data).map{$0.0 + $0.1}]
}

//Subtract two matrix
public func -<T: NumericArithmeticType>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    if lhs.columnCount != rhs.columnCount || rhs.rowCount != lhs.rowCount {
        fatalError(MatrixDimError.InnerDimMisMatch.rawValue)
    }
    let sub = zip(lhs.data, rhs.data).map{$0.0 - $0.1}
    
    
    return Matrix.init(rows: lhs.rowCount, columns: rhs.columnCount, grid: sub)
}

//Matrix * Scalar Multiplication
public func *<T: NumericArithmeticType>(lhs: T, rhs: Matrix<T>) -> Matrix<T> {
    return [rhs.map { lhs * $0 }]
}

//Scalar * Matrix  Multiplication
public func *<T: NumericArithmeticType>(lhs: Matrix<T>, rhs: T) -> Matrix<T> {
    return [lhs.map { rhs * $0 }]
}

//Scalar matrix division
public func /<T:NumericArithmeticType>(lhs: Matrix<T> , rhs: T) ->Matrix<T>{
    return [lhs.map { rhs / $0 }]
}

//Scalar matrix division
public func /<T:NumericArithmeticType>(lhs:T , rhs: Matrix<T>) ->Matrix<T>{
    return [rhs.map { lhs / $0 }]
}

//Matrix * Matrix Multiplication
public func *<T:NumericArithmeticType>(lhs: Matrix<T> , rhs: Matrix<T>) ->Matrix<T>{
    
    if lhs.columnCount != rhs.rowCount {
        fatalError(MatrixDimError.ColumnNotEqualToRow.rawValue)
    }
    
    let lhsDouble:[[T]] = convert(Darray: lhs, column: lhs.columnCount)
    let rhsDouble:[[T]] = convert(Darray: rhs, column: rhs.columnCount)
    var newMax:Matrix<T> = Matrix(rows: lhs.rowCount, columns: rhs.columnCount, repeatedValue: 0)
    
    for (pos,_) in newMax.enumerated() {
        
        let rowValue = pos/rhs.columnCount
        let columnValue = pos % rhs.columnCount
        let lhsRow = getRow(rowIndex: rowValue, twoDArray: lhsDouble)
        let rhsRow = getColumn(column: columnValue, twoDArray: rhsDouble)
        let multi = zip(lhsRow, rhsRow).map{$0.0 * $0.1}
        let sum = multi.reduce(0,+)
        
       // print("\(pos/rhs.columnCount) ----\(pos % rhs.columnCount)")
        newMax[pos/rhs.columnCount, pos % rhs.columnCount] = sum
    }
    return newMax
}

//Matrix * Vector Multiplication
public func *<T:NumericArithmeticType>(lhs: Matrix<T> , rhs:Vector<T>) ->Vector<T>{
    
    if lhs.columnCount != rhs.rowCount {
        fatalError(VectorDimError.ColumnNotEqualToRow.rawValue)
    }
    let lhsDouble:[[T]] = convert(Darray: lhs, column: lhs.columnCount)
    var newMax:Vector<T> = Vector(rows: lhs.rowCount, repeatedValue: 0)
    
    for (pos,_) in newMax.enumerated() {
        let rowValue = pos/lhs.columnCount
        let lhsRow = getRow(rowIndex: rowValue, twoDArray: lhsDouble)
        let multi = zip(lhsRow, rhs).map{$0.0 * $0.1}
        let sum = multi.reduce(0,+)
        newMax[pos] = sum
    }
    return newMax
}


//Divide matrix by matrix
public func /<T:NumericArithmeticType>(lhs: Matrix<T> , rhs: Matrix<T>) ->Matrix<T>{
    if lhs.columnCount != rhs.rowCount {
        fatalError(MatrixDimError.ColumnNotEqualToRow.rawValue)
    }
    
    let lhsDouble:[[T]] = convert(Darray: lhs, column: lhs.columnCount)
    let rhsDouble:[[T]] = convert(Darray: rhs, column: rhs.columnCount)
    var newMax:Matrix<T> = Matrix(rows: lhs.rowCount, columns: rhs.columnCount, repeatedValue: 0)
    
    for (pos,_) in newMax.enumerated() {
        
        let rowValue = pos/rhs.columnCount
        let columnValue = pos % rhs.columnCount
        let lhsRow = getRow(rowIndex: rowValue, twoDArray: lhsDouble)
        let rhsRow = getColumn(column: columnValue, twoDArray: rhsDouble)
        let multi = zip(lhsRow, rhsRow).map{$0.0 / $0.1}
        let sum = multi.reduce(0,+)
        
        // print("\(pos/rhs.columnCount) ----\(pos % rhs.columnCount)")
        newMax[pos/rhs.columnCount, pos % rhs.columnCount] = sum
    }
    return newMax
}

//Compare Two marix
public func == <T: Equatable>(lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
    return lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount &&
        lhs.data == rhs.data
}

//Not Equal comparision
public func != <T: Equatable>(lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
    return !(lhs == rhs)
}


// transform matrix rows becomes columns
public func transpose<T:NumericArithmeticType>(max : Matrix<T>) -> Matrix<T>{
    var newMax:Matrix<T> = Matrix(rows: max.columnCount, columns: max.rowCount, repeatedValue: 0)
        for i in 0..<max.rowCount {
            for j in 0..<max.columnCount {
                newMax[j,i] = max[i,j]
            }
        }
    return newMax
}

//transform vector rows become columns
public func transpose<T:NumericArithmeticType>(vec : Vector<T>) -> Matrix<T>{
    var newMax:Matrix<T> = Matrix(rows: vec.rowCount, columns: vec.rowCount, repeatedValue: 0)
    for i in 0..<vec.rowCount {
        newMax[i,i] = vec[i]
    }
    return newMax
}

//Sum of whole matrix
public func sum<T:NumericArithmeticType>(_ value :Matrix<T>) -> T {
    return value.data.reduce(0,+)
}

public func sum<T:NumericArithmeticType>(_ value :[T]) -> T {
    return value.reduce(0,+)
}

//Sum of whole matrix
public func sum<T:NumericArithmeticType>(_ value :Vector<T>) -> T {
    return value.data.reduce(0,+)
}
//Convert one - dimentional matrix to two
public func convert<T:NumericArithmeticType>(Darray:Matrix<T>,column : Int )->[[T]]{
    var temp :[[T]] = []
    var currnetIndex = 0
    for value in stride(from: 0, through: Darray.count, by: column) {
        if value != 0
        {
            let seq = value - 1
            var oneArray :[T] = []
            for i in currnetIndex...seq{
                oneArray.append(Darray[i])
            }
            temp.append(oneArray)
            currnetIndex = value
        }
    }
    return temp
}

//Get particular row from 2D array
public func getRow<T:NumericArithmeticType>(rowIndex: Int ,twoDArray:[[T]]) -> [T]{
    return twoDArray[rowIndex]
}

//Get particular column from 2D array
public func getColumn<T:NumericArithmeticType>(column: Int ,twoDArray:[[T]]) -> [T]{
    var temp :[T] = []
    for value in twoDArray{
        temp.append(value[column])
    }
    return temp
}

//Square value for each element in Matrix
public func squareOf<T:NumericArithmeticType>(max:Matrix<T>) -> Matrix<T>{
    return [max.map{$0 * $0}]
}



