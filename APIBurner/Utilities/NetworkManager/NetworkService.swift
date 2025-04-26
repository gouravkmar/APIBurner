//
//  NetworkService.swift
//  APIBurner
//
//  Created by Adarsh Singh on 26/04/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func makeRequest(requestData : RequestDataModel) -> Void
}
class NetworkService : NetworkServiceProtocol{
    static let shared = NetworkService()
    private init() {}
    private let networkManager = NetworkManager()
    weak var viewModel : ResultViewModel?
    var workItems : [DispatchWorkItem] = []
    let group = DispatchGroup()
    let queue = DispatchQueue(label: "com.API.requestQueue",attributes: .concurrent)
    func makeRequest(requestData: RequestDataModel) {
        guard let url = getURL(requestData: requestData) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = requestData.requestMethod.rawValue
        requestData.headerParams.forEach { keyval in
            if !keyval.key.isEmpty {
                request.addValue(keyval.value, forHTTPHeaderField: keyval.key)
            }
            
        }
        executeAPICalls(request: request, requestData: requestData)
        
    }
    //Result<HTTPURLResponse, Error>
    private func executeAPICalls(request: URLRequest,requestData : RequestDataModel) {
        
        let batchSize = requestData.batchSize
        let totalReq = requestData.numberOfRequests
        let totalBatches = Int(ceil(Double(totalReq/batchSize)))
        for (ind,batch) in (0..<totalBatches).enumerated(){
            for _ in 0..<batchSize{
                let workItem = DispatchWorkItem { [weak self] in
                    guard let self = self else { return }
                    let currTime = Date().timeIntervalSince1970 * 1000
                    self.networkManager.request(urlRequest: request, completion: {result in
                        defer {self.group.leave()}
                        let elapsedTime = Date().timeIntervalSince1970 * 1000 - currTime
                        var statusCode : Int
                        switch result{
                            
                        case .success(let response):
                            statusCode = response.statusCode
                        case .failure(let error):
                            statusCode = -1
                        }
                        let testResult = TestResult(responseTime: elapsedTime, statusCode: statusCode)
                        DispatchQueue.main.async {
                            self.viewModel?.testResults.append(testResult)
                        }
                        
                        
                    })
                }
                workItems.append(workItem)
                group.enter()
                queue.asyncAfter(deadline: .now() + .milliseconds(ind * requestData.requestInterval * 1000), execute: workItem)
            }
            
        }
        group.notify(queue: .main) {
            self.viewModel?.shouldPresent = true
        }
        
        
        
    }
    //cancel request method for back and rerequests
    
    
    
    
    
    
    
    
    
    
    
    
    func getURL(requestData: RequestDataModel) -> URL? {
        var urlString = requestData.urlString.trimmingCharacters(in: .whitespacesAndNewlines)

        if urlString.lowercased().hasPrefix("http://") {
            urlString = urlString.replacingOccurrences(of: "http://", with: "https://")
        } else if !urlString.lowercased().hasPrefix("https://") {
            urlString = "https://\(urlString)"
        }

        if requestData.useURlComponents {
            guard var components = URLComponents(string: urlString) else {
                return nil
            }
            
            components.queryItems = requestData.queryParams.compactMap { param in
                guard !param.key.isEmpty else { return nil }
                return URLQueryItem(name: param.key, value: param.value)
            }

            return components.url
        } else {
            return URL(string: urlString)
        }
    }

    
    
    
    
    
}
