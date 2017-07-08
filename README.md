# Swiftified


## Created Two Custom data types Matrix and vector using Swift Standard Library to hold M x N and N x 1 Dimentional data.These Data types are generic and act as a Array litreal 

## Provided overriden operators for the custom datatype for matrix multiplication , division , addition , subraction

# Output

let numberMatrix :Matrix = [[1,2,3,4,5],[2,3,4,22,33]]
print(numberMatrix)

let stringMatrix :Matrix = [["11","22","33","44","55"],["2","3","4","22","33"]]
print(stringMatrix)

let mixedMatrix : Matrix = [["Guna",3,"pandian"] , ["Dinesh",4.92,"SwiftGuru"]]

print(mixedMatrix)

let x: Matrix = [[1,2,3],[2,3,4]]
let y: Matrix = [[67,2,23],[32,11,4],[32,11,4]]
let z: Matrix = [[1, 2], [3, 4], [5, 6]]
let a: Matrix = [[1, 2], [3, 4], [5, 6]]



let vec : Vector = [1,2,3,4,5,6,7,8]
print(vec)

let sumMax = a + z
let maxMul = x * y
let maxDiv = x / y

print(sumMax)
print(maxMul)
print(maxDiv)



let scalarMul = 2 * x
print(scalarMul)

let reverseScalarMul = x * 3
print(reverseScalarMul)

let scalarDiv = x / 3

print(scalarDiv)


let trans = transpose(max: x)
print(trans)

let sumVal = sum(y)
print(sumVal)

let squareValue = squareOf(max: x)
print(squareValue)

let twoDim =  convert(Darray: z, column: z.columnCount)
let row  = getRow(rowIndex: 1, twoDArray: [[1,2,3,4,1],[56,12,45,78,89]])
let column  = getColumn(column: 4, twoDArray: [[1,2,3,4,1],[56,12,45,78,89]])

print(twoDim)
print(row)
print(column)


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

