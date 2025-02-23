import UIKit

///You are given an array arr[] of N integers including 0. The task is to find the smallest positive number missing from the array.
///
///Example 1:
///
///Input:
///N = 5
///arr[] = {1,2,3,4,5}
///Output: 6
///Explanation: Smallest positive missing
///number is 6.
///
///Example 2:
///
///Input:
///N = 5
///arr[] = {0,-10,1,3,-20}
///Output: 2
///Explanation: Smallest positive missing
///number is 2.
///Your Task:
///The task is to complete the function missingNumber() which returns the smallest positive missing number in the array.
///
///Expected Time Complexity: O(N).
///Expected Auxiliary Space: O(1).
///
///Constraints:
///1 <= N <= 106
///-106 <= arr[i] <= 106

func missingNumber(_ array: inout [Int]) -> Int {
    let arraySize = array.count

    for i in 0..<arraySize {
        while array[i] > 0 && array[i] <= arraySize && array[i] != array[array[i] - 1] {
            swap(&array, i, array[i] - 1)
        }
    }

    for i in 0..<arraySize {
        if array[i] != i + 1 {
            return i + 1
        }
    }

    return arraySize + 1
}

func swap(_ array: inout [Int], _ i: Int, _ j: Int) {
    let temp = array[i]
    array[i] = array[j]
    array[j] = temp
}

var array = [0,-10,1,3,-20] //[1,2,3,4,5]
print(missingNumber(&array))
