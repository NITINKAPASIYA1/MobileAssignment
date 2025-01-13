//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData]? = []
    
    init(){
        fetchAPI()
    }

    func fetchAPI() {
        apiService.fetchDeviceDetails { devices in
            DispatchQueue.main.async{
                if devices.isEmpty {
                    print("No device fetched")
                }
                else {
                    print("Fetched devies \(devices)")
                }
                self.data = devices
            }
        }
    }
    
    func filterData(textField:String) -> [DeviceData]{
        if textField.isEmpty {
            return data!
        }else {
            return data!.filter {
                $0.name.lowercased().contains(textField.lowercased())
            }
        }
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
