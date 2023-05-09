//
//  NetworkUtility.swift
//  PlanetListTask
//
//  Created by Prajakta on 09/05/23.
//

import Foundation

public final class NetworkUtility {
    
    public let session = URLSession(configuration: .default)
    static let shared = NetworkUtility()
     
    /// Generic function to call API.
    
    func callAPI<T: Codable>(urlRequest: URLRequest,
                             urlString: String,
                             completionBlock: @escaping ((T?) -> Void)) {
    
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, let res = response as? HTTPURLResponse, res.statusCode == 200
            else { return }
            let genericModel = try? JSONDecoder().decode(T.self, from: data)
            if genericModel != nil  {
                DatabaseUtility.shared.addValuesToDatabase( rawData: data, url: urlString) // save latest data in database
            }
            completionBlock(genericModel)
        }
        dataTask.resume()
    
    }
    
    /// Generic function to check network availability. If network available then call actual API. Otherwise return data from database.

    func fetchDataFromApiWith<T: Codable>(urlString: String = "",
                                          completionBlock: @escaping ((T?) -> Void)) {
        guard let url = URL(string: urlString) else { return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if Reachability()!.isReachable { // network available, get data from API response
            self.callAPI(urlRequest: request, urlString: urlString, completionBlock: completionBlock)
        } else { // network not available, get data from databse
            DatabaseUtility.shared.checkInDatabaseWith(url: urlString, completionBlock: completionBlock)
        }
        
    }
}
