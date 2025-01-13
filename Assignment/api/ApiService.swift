//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation

class ApiService : NSObject {
//    private let baseUrl = ""
    
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    func fetchDeviceDetails(completion : @escaping ([DeviceData]) -> Void){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async{
                    completion([])
                }// Return an empty array on network failure
                return
            }
            
            guard let data = data else{
                print("No Data is Fetched or received from the api service.")
                DispatchQueue.main.async{
                    completion([])
                }
                return
            }
            
            do{
                //Decoding the JSON DATA here
                let jsonDecoder = JSONDecoder()
                let deviceData = try jsonDecoder.decode([DeviceData].self,from: data)
                DispatchQueue.main.async {
                    completion(deviceData)
                }
            }catch {
                print("Error while Decoding Data : \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}
