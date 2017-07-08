//
//  Vector.swift
//  MLSwiftified
//
//  Created by Gunapandian on 06/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//

/**
 This struct is used to represent Generic  M X 1 vector which
 we can directly use in enumureation operation and
 we assing two dimentional array directly
 we can intilize this matrix with any data type (primitive , drived , your own data types)
 **/
public struct Vector<Element> {
    
    //Instance Variable
    var data : [Element]
    //Constant
    let rowCount : Int
    
    //init methods with row count and repeatedValue
    init(rows : Int , repeatedValue: Element) {
        self.rowCount = rows
        self.data = Array(repeatElement(repeatedValue, count: rows))
    }
    
    //init vector with 1D array
    public init(grid: [Element]) {
        self.rowCount = grid.count
        self.data = grid
    }
    
}

/**
 ExpressibleByArrayLiteral protocal is used here to map 1D assignment to our vector struct like below
 let max:Vector = [1,3,2,4,2,3]
 **/
extension Vector :ExpressibleByArrayLiteral{
    
    //MARK : Mutable Collection Conformances Variable
    public init(arrayLiteral elements: Element...){
     self.init(grid: elements)
    }
    
}

/**
 Vector struct conforms  MutableCollection protocal so that we can perform enumuration options directly to our matrix type
 eg:  let vec:Vector = [1,3,2,4,2,3]
 vec.map{}
 vec.sortby{}
 vec.flatmap{}
 for value in vec{}  ... etc
 **/
extension Vector : MutableCollection {
    
    //MARK : Mutable Collection Conformances Variable
    public var startIndex : Int {
        return 0
    }
    
    public var endIndex : Int {
        return rowCount
    }
    
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    //MARK : Mutable Collection Conformances Subscript
    public subscript(row: Int) -> Element {
        get {
            return data[row]
        }
        set {
            data[row] = newValue
        }
    }
    
}

