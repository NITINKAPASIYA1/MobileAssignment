//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path
    @State private var textField: String = ""
    
    

    var body: some View {
        NavigationStack(path: $path) {
            Group() {
                if let computers = viewModel.data, !computers.isEmpty {
                    DevicesList(devices: viewModel.filterData(textField: textField)) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .searchable(text: $textField)
            
            .onChange(of: viewModel.navigateDetail) {
                navigateDetail in
                if let navigateDetail = navigateDetail{
                    path.append(navigateDetail)
                }
            }
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                if let navigate = viewModel.navigateDetail{
                    DispatchQueue.main.asyncAfter(deadline:.distantFuture) {
                        path.append(navigate)
                    }
                }
            }
        }
    }
}
