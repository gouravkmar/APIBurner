//
//  MainViewModel.swift
//  APIBurner
//
//  Created by Gourav Kumar on 25/04/25.
//

import Foundation


class MainViewModel : ObservableObject{
    @Published var urlString : String = ""
    @Published var requestMethod : RequestMethod = .get
    @Published var numberOfRequests : Int = 10
    @Published var batchSize : Int = 1
    @Published var requestInterval : Int = 1
    @Published var useURlComponents : Bool = true
    @Published var queryParams : [KeyValPair] = [KeyValPair(key: "", value: "")]
    @Published var headerParams : [KeyValPair] = [KeyValPair(key: "", value: "")]
}

enum RequestMethod : String, CaseIterable,Identifiable{
    var id : String {
        self.rawValue
    }

    case get = "GET"
    case post = "POST"
                                                
}
struct KeyValPair : Identifiable{
    let id = UUID()
    var key : String
    var value : String
}
