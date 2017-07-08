//
//  CustomNumericType.swift
//  MLSwiftified
//
//  Created by Gunapandian on 06/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//


//Custom protocal for  matrix Arithmetic operation and linear algebra
public protocol NumericArithmeticType: ExpressibleByIntegerLiteral {
   static func +(lhs: Self, rhs: Self) -> Self
   static func -(lhs: Self, rhs: Self) -> Self
   static func *(lhs: Self, rhs: Self) -> Self
   static func /(lhs: Self, rhs: Self) -> Self
}

//For signed NumericArithmeticType is further extended
public protocol SignedNumericArithmeticType: NumericArithmeticType {
    prefix static func -(value: Self) -> Self
}

//For Floating litreals
public protocol FloatingPointArithmeticType: SignedNumericArithmeticType { }


//Making  constrain types  for using in Generics 
extension Int8   : SignedNumericArithmeticType { }
extension Int16  : SignedNumericArithmeticType { }
extension Int32  : SignedNumericArithmeticType { }
extension Int64  : SignedNumericArithmeticType { }
extension Int    : NumericArithmeticType { }
extension UInt8  : NumericArithmeticType { }
extension UInt16 : NumericArithmeticType { }
extension UInt32 : NumericArithmeticType { }
extension UInt64 : NumericArithmeticType { }
extension UInt   : NumericArithmeticType { }
extension Float32 : FloatingPointArithmeticType { }
extension Float64 : FloatingPointArithmeticType { }
extension Float80 : FloatingPointArithmeticType { }

