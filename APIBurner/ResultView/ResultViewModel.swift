//
//  ResultViewModel.swift
//  APIBurner
//
//  Created by Gourav Kumar on 26/04/25.
//

import Foundation

class ResultViewModel : ObservableObject {
    var requestData : RequestDataModel
    var successCount : Int {
        testResults.map({$0.isSuccess}).count
    }
    var failureCount : Int {totalRunningCount - successCount}
    var totalRunningCount : Int {
        testResults.count
    }
    var totalCount : Int = 100
    @Published var testResults : [TestResult] = []
    init(requestData: RequestDataModel) {
        self.requestData = requestData
        self.totalCount = requestData.numberOfRequests
        //network manager call starts {
        
//    }
    }
    
}
struct TestResult {
    var reqTime : Double
    var resTime : Double
    var statusCode : Int
    var isSuccess : Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
