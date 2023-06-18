//
//  NetworkHelper.swift
//  ListedApp
//
//  Created by Rahul Bawane on 18/06/23.
//

import Foundation

let baseUrl = "https://api.inopenapp.com/api/v1/"//dashboardNew
let accesssToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkHelper {
    static let shared = NetworkHelper()
    private init(){}
    
    func dataTask(baseUrl: String = baseUrl, apiUrl: String, httpMethod: HTTPMethod, paramms: [String: Any]?, completion: @escaping (_ success: Bool, _ response: Data?) -> Void) {
        let url = String(format: baseUrl + apiUrl)
        guard let serviceUrl = URL(string: url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = httpMethod.rawValue
        request.setValue(accesssToken, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                completion(true, data)
            }
            completion(false, data)
        }.resume()
    }
}
