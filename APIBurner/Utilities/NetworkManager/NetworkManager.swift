//
//  NetworkManager.swift
//  APIBurner
//
//  Created by Gourav Kumar on 26/04/25.
//

import Foundation

class NetworkManager {
    
    func request(urlRequest: URLRequest,
                 completion: @escaping (Result<HTTPURLResponse, Error>) -> Void){
        
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 30
        session.dataTask(with: urlRequest)
        { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                    completion(.success(httpResponse))
                return
            }
            let error = NSError(domain: "com.yourapp.network", code: -1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong."])
            completion(.failure(error))
            return 

//            guard let data = data else {
//                let error = NSError(domain: "Invalid Data", code: 1001, userInfo: nil)
//                completion(.failure(error))
//                return
//            }
            
        }.resume()
    }
    
    
    
}
