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
        testResults.filter({$0.isSuccess}).count
    }
    var failureCount : Int {totalRunningCount - successCount}
    var totalRunningCount : Int {
        testResults.count
    }
    var uuid : UUID
    var avgResTime : Int {
        var total = 0.0
        testResults.map{ total = total + $0.responseTime}
        return Int(total / Double(max(testResults.count,1)))
    }
    
    var maxResTime : Int {
        var maxT = 0.0
        testResults.map{ maxT = max(maxT, $0.responseTime)}
        return Int(maxT)
    }
    var minResTime : Int {
        var minT = Double.infinity
        testResults.map{ minT = min(minT, $0.responseTime)}
        return Int(minT)
    }
    var totalCount : Int = 100
    @Published var shouldPresent = false
    @Published var testResults : [TestResult] = []
    init(requestData: RequestDataModel,uuid : UUID) {
        self.requestData = requestData
        self.totalCount = requestData.numberOfRequests
        self.uuid = uuid
        NetworkService.shared.viewModel = self
        
        makeRequest()
        //network manager call starts {
        
//    }
    }
    func makeRequest(){
        NetworkService.shared.makeRequest(requestData: requestData)
    }
    func cancelAllRequests(){
        NetworkService.shared.cencelAllRequests()
    }
    
    
}
struct TestResult {
    var responseTime : Double
    var statusCode : Int
    var isSuccess : Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
