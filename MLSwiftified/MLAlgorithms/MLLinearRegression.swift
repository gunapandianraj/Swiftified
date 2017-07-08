//
//  MLLinearRegression.swift
//  MLSwiftified
//
//  Created by Gunapandian on 04/07/17.
//  Copyright © 2017 Gunapandian. All rights reserved.
//


typealias matrixType<T> = ( Matrix<T>) -> Void

//Linear Regression algorithm is used for predicting countious problems

//MLLinearRegression here uses generic but constraint to NumericArithmeticType
class MLLinearRegression<Num :NumericArithmeticType> {
    
    var features : Matrix<Num>
    var labels : Matrix<Num>
    
    
    //init method takes two matrix
    init(xValue: Matrix<Num> ,yValue : Matrix<Num>) {
        features = xValue
        labels = yValue
    }
    
    //Cost funtion in an linear regression is used to find the differences between actual value and predicated value
    //J(✓) = 1 Xm  h✓(x(i))   y(i) 2
    func costFuntion(theta : Matrix<Num>,datalength : Num)->Num{

                 let A = features * theta;
                 var  B = A - labels
                 B = squareOf(max: B)
                 let SquaredError = sum(B)
                 let ScaleDown = 2 * datalength
                 let intialError = SquaredError / ScaleDown;
         return intialError
    }
    
    
    //Gardient Decent helps to minimize the cost between actual value and predicated vaue by looping over the all dataset for pre defined interval
    //✓j := ✓j   ↵ (h✓(x(i))   y(i))x(i) (simultaneously update ✓j for all j).
    func minimizeGradientDecent(theta : Matrix<Num>,iters : Int,dataLen :Num,aplha:Num,completion : matrixType<Num> ) -> Void {
        var thetas = theta
        let twoDFeatures = convert(Darray: features, column: features.columnCount)
        let rowsf = getColumn(column:features.columnCount - 1, twoDArray: twoDFeatures)
        let D:Matrix = Matrix.init(rows:rowsf.count , columns: 1, grid: rowsf)
        
        for _ in 0...iters{
            
            let A = features * theta
            let B = A - labels
                
            //let minusValue = A - B
            
            let mulValue = zip(B, D).map{$0.0 * $0.1}
//            let mulValue = minusValue * D
            
            let theta1 = sum(B)
            let theta2 = sum(mulValue)
            
            let finalTheta1 = theta1 / dataLen
            let finalTheta2 = theta2 / dataLen
            
            
            let temp1 = thetas[0,0] - (aplha * finalTheta1);
            let temp2 = thetas[0,1]  - (aplha * finalTheta2) ;
            
            
            thetas[0,0] = temp1
            thetas[0,1] = temp2
            
        }
        completion(thetas)
    }
    
    
    
    
    func perdict(_value : Matrix<Num>) -> Void {
        
    }
}

