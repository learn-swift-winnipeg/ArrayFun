import Foundation

func main(){
    let randNum = arc4random_uniform(100)
    let randInt = Int(randNum)
    
    var arr1 = Array(repeating:randInt, count: 100)
    var arr2 = Array(repeating:randInt, count: 100)
    
    // TimeIt
    let begin = clock()
    mult()
    let elapsedTime = Double(clock() - begin) / Double(CLOCKS_PER_SEC)
    
    print("Elapsed time: \(elapsedTime)")
}


func mult(arr1: [Int], arr2: [Int]) -> [Int]{
    let result = zip(arr1, arr2).map{$0 * $1}
    return result
}
