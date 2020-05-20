
//  Service.swift
//  SwiftUIDemo
//
//  Created by Zeeshan Dar on 4/23/20.
//  Copyright © 2020 Zeeshan Dar. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire

class ApiService: ObservableObject{
    
    let defaults = UserDefaults.standard
    static let instance = ApiService()
    var showLoading = true
    var didChange = PassthroughSubject<ApiService, Never>()
    
    @Published var orders = [Order](){
        didSet{
            self.didChange.send(self)
        }
    }
    
    init() {
        getOrdersFromDetault()
        if orders.count == 0{
            self.orders = [Order]()
            self.showLoading = false
        }else{
            self.showLoading = false
        }
    }
    
    func saveOrdersToDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(orders) {
            defaults.set(encoded, forKey: "orders")
        }
    }
    func getOrdersFromDetault(){
        if let safeUser = defaults.object(forKey: "orders") as? Data {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode([Order].self, from: safeUser) {
                orders = savedUser
            }
        }
    }
    
    func callBEWithData(postUrl: String,params: [String: Any]?,method: HTTPMethod,Completion: @escaping CompletionData) {
        let header = ["Content-Type":"application/json",
                      "Accept":"application/json",
                      "Trackingmore-Api-Key":"82173cb2-e38b-40b3-a6c4-cf42384e03e4"]
        AF.request(BASE_URL + postUrl, method: method, parameters: params, encoding: JSONEncoding.default, headers: .init(header)).responseJSON { (response) in
            DispatchQueue.main.async {
                debugPrint(response.value as Any)
                guard let data = response.data else{Completion(nil);return}
                Completion(data)
            }
            
        }
        
    }
    
    func loadData() {
        self.showLoading = true
        self.orders = [Order]()
        callBEWithData(postUrl: "get", params: nil, method: .post) { (data) in
            if let data = data{
                do {
                    let JSON = try JSONDecoder().decode(AllData.self, from: data)
                    self.orders = JSON.data.items
                    self.showLoading = false
                } catch let err {
                    print(err)
                    self.orders = [Order]()
                    self.showLoading = false
                }
            }
        }
    }
}


