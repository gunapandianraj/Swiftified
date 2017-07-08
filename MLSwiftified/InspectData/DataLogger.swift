//
//  DataConvertor.swift
//  MLSwiftified
//
//  Created by Gunapandian on 06/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//
import Foundation

public typealias readCsvResultType<T:NumericArithmeticType> = ([[T]],[[T]])
/**
 Data Logger class deals with opeartions related to data mapping ,segmenting, adding data parameters
 **/
class DataLogger {
    
    //Read Comma seprated data file and return as  tuple of two 2D arrays
    static func readCsvFile(completion:(readCsvResultType<Float>)->Void) throws -> Void{
        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirectory.appendingPathComponent("ex.txt")
        var featureMatrix : [[Float]] = [[]]
        var labelMatrix : [[Float]] = [[]]
        do {
            let fileObject = try String(contentsOf: fileURL)
            var fileObjectCleaned = fileObject.components(separatedBy: "\n") //Swift 4 feature use String as sequences
            
            _ = fileObjectCleaned.removeLast()
            
            for item in fileObjectCleaned{
                var value = item.components(separatedBy: ",")
                
                if let value1 = Float(value[0]){
                    featureMatrix.append([value1])
                }
                if let value2 = Float(value[1]){
                    labelMatrix.append([value2])
                }
            }
            
            featureMatrix.removeFirst()
            labelMatrix.removeFirst()
            completion((featureMatrix,labelMatrix))
        } catch {
           throw DataLogError.UnableToReadData
        }        
    }
    
    
    //Adding an column on each row with given numerictype
    static func addXeroParameter<T:NumericArithmeticType> (max : [[T]]) ->[[T]]{
        var temp = max
        for (ind,_) in temp.enumerated() {
            temp[ind].append(1)
        }
        return temp
    }
    
}
