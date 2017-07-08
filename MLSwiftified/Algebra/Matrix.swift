//
//  Matrix.swift
//  MLSwiftified
//
//  Created by Gunapandian on 04/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//

/**
 This struct is used to represent Generic  M X N matrix which
 we can directly use in enumureation operation and
 we assing two dimentional array directly
 we can intilize this matrix with any data type (primitive , drived , your own data types)
 **/
public struct Matrix<Element> {
    
    //Insatance variables
    var data : [Element]
    //Const
    let rowCount : Int
    let columnCount : Int
    
    //init method for creating M X N array with reapeated value
    init(rows : Int , columns : Int , repeatedValue: Element) {
        self.rowCount = rows
        self.columnCount = columns
        self.data = Array(repeatElement(repeatedValue, count: columns * rows)) // creating M x N matrix in 1D array
    }
    
    //init method which takes column row and one dimentional array
    public init(rows: Int, columns: Int, grid: [Element]) {
        self.rowCount = rows
        self.columnCount = columns
        self.data = grid
    }
    
    //init method which accepts 2D Element Array
    public init(_ towDData: [[Element]]) {
        let rows = towDData.count
        let columns = towDData[0].count
        
        if let count = towDData.first?.count {
            for row in towDData {
                if row.count != count {
                    fatalError(MatrixDimError.ColumnMismatch.rawValue)
                }
            }
        }
        let temp = towDData.flatMap{$0} // flat map here used to transform incoming 2D array to 1D
        self.init(rows: rows, columns: columns, grid: temp)
    }
    
    //Generic Subscript to access a element in Matrix
    public subscript(row: Int, column: Int) -> Element {
        get {
            return data[(row * columnCount) + column]
        }
        set {
            data[(row * columnCount) + column] = newValue
        }
    }
    
    // Matrix dimention check for all the rows should have equal column
    func isInnerDimentionMatches(_ value:[[Element]]) -> MatrixDimError{
        if let count = value.first?.count {
            for row in value {
                if row.count != count {
                    return MatrixDimError.ColumnMismatch
                }
            }
        }
        return MatrixDimError.None
    }
    
}

/**
 ExpressibleByArrayLiteral protocal is used here to map 2D assignment to our matrix struct like below
  let max:Matrix = [[1,3],[2,4],[2,3]]
 **/
extension Matrix :ExpressibleByArrayLiteral{
    
    //MARK : ExpressibleByArrayLiteral Conformance init method
        public init(arrayLiteral elements: [Element]...){
        
        if let count = elements.first?.count {
            for row in elements {
                if row.count != count {
                    fatalError(MatrixDimError.ColumnMismatch.rawValue)
                }
            }
        }
        self.init(elements)
    }
    
}

/**
 Matrix struct conforms  MutableCollection protocal so that we can perform enumuration options directly to our matrix type
 eg:  let max:Matrix = [[1,3],[2,4],[2,3]]
 max.map{}
 max.sortby{}
 max.flatmap{}
 for value in max{}  ... etc
**/
extension Matrix : MutableCollection {
    
    //MARK : Mutable Collection Conformances Variables
    public var startIndex : Int {
        return 0
    }
    
    public var endIndex : Int {
        return columnCount*rowCount
    }
    
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    //MARK : Mutable Collection Conformances Subscript
    public subscript(position: Int) -> Element {
        get {
            return self[position/columnCount, position % columnCount]
        }
        set {
            self[position/columnCount, position % columnCount] = newValue
        }
    }
    
}




