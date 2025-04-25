//
//  ResultViewModel.swift
//  APIBurner
//
//  Created by Gourav Kumar on 26/04/25.
//

import Foundation

class ResultViewModel : ObservableObject {
    var successCount : Int {
        testResults.map({$0.isSuccess}).count
    }
    var failureCount : Int {totalRunningCount - successCount}
    var totalRunningCount : Int {
        testResults.count
    }
    var totalCount : Int = 100
    @Published var testResults : [TestResult] = []
    
}
struct TestResult {
    var reqTime : Double
    var resTime : Double
    var statusCode : Int
    var isSuccess : Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
