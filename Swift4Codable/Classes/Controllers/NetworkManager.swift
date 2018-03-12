//
//  NetworkManager.swift
//  RepliconTest
//
//  Created by Sayan Chatterjee on 12/03/18.
//  Copyright © 2018 Vaoprware Solutions. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    public static let sharedInstance = NetworkManager()

    public var lastResponseStausCode : Int?
    public var lastResponse : HTTPURLResponse?

    private override init(){

    }

    public func getDataFromURL(urlString : String, params : Dictionary<String, String>!, sucess : @escaping (_ response : Data , _ msg : String) -> Void, failure : @escaping (_ error: Error, _ msg : String) -> Void){

        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: urlString + getQueryFromParam(param: params))!

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            self.lastResponse = response as? HTTPURLResponse
            self.lastResponseStausCode =  self.lastResponse?.statusCode

            if error != nil {
                print(error!.localizedDescription)
                failure(error!, error!.localizedDescription)

            } else {
                if(self.lastResponseStausCode ==  200) {
                    sucess(data! , "Success")
                }
                else{
                    let msg = "Error due to Status Code : " + String(describing: self.lastResponseStausCode)
                    failure (error!, msg)
                }
            }

        })
        task.resume()
    }

    private func getQueryFromParam (param : Dictionary<String, String>!) -> String {

        guard let queryParams = param else {
            return "";
        }

        let q = "?" as String

        var queries : [String] = []
        for (key, value) in queryParams {
            let query = (key + "=" + value) as String
            queries.append(query)
        }

        return q + queries.joined(separator: "&")
    }
}
