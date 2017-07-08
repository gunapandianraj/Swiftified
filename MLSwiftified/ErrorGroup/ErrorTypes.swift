//
//  ErrorTypes.swift
//  MLSwiftified
//
//  Created by Gunapandian on 07/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//


enum MatrixDimError : String, Error{
    case ColumnMismatch = "Column should be equal in all rows" ,
        RowMismatch = "Row should be equal",
        ColumnNotEqualToRow = "Column is not equal to row",
        InnerDimMisMatch = "Both Matrix should have equal rows and column",
        None
}

enum VectorDimError : String, Error{
    case VectorMultiplicationError = "Matrix column must be equal to Vector Rows" ,
    RowMismatch = "Row should be equal",
    ColumnNotEqualToRow = "Column is not equal to row",
    None
}

enum DataLogError :String, Error{
    case UnableToOpenFile = "Unable to open the file",UnableToReadData = "Unable to read the data from file",None
}
