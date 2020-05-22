//
//  PostRequestView.swift
//  PacketTracker
//
//  Created by ZainAnjum on 19/05/2020.
//  Copyright © 2020 Noman2. All rights reserved.
//

import SwiftUI

struct PostRequestView: View {
    //    @State private var carriers = [CarrierCode(name: "Select carrier", code: "")]
    @State private var carriers = [CarrierCode]()
    @State private var trackingNumber = ""
    @State private var title = ""
    @State private var isTrackingEntered = false
    @State private var isShowingAlert = false
    @State private var isShowingLoading = false
    @State private var selectedIndex = 0
    @EnvironmentObject var apiService: ApiService
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            if isShowingLoading{
                ActivityIndicator(isAnimating: isShowingLoading) { (indicator: UIActivityIndicatorView) in
                    indicator.color = .red
                    indicator.hidesWhenStopped = false
                }
            }else{
                Form {
                    Section(header: Text("Enter tracking number")){
                        TextField("123456789", text: self.$trackingNumber, onEditingChanged: { (success) in
                            self.carriers = [CarrierCode]()
                        }) {
                            self.isTrackingEntered = true
                            print("finished")
                            self.getCarriersFromBE()
                        }
                    }
                    if carriers.count == 0{
                        Section {
                            Button(action: {
                                if self.trackingNumber.count == 0{
                                    self.title = "Please write tracking number first"
                                    self.isShowingAlert.toggle()
                                    UIApplication.shared.endEditing()
                                }else{
                                    UIApplication.shared.endEditing()
                                    self.isShowingLoading.toggle()
                                    self.getCarriersFromBE()
                                }
                            }) {
                                Text("Get Carrier List")
                                    .foregroundColor(Color.red)
                                    .font(.custom("D-DIN", size: 16))
                            }
                            
                        }
                    }
                    if carriers.count != 0{
                        Section {
                            Picker(selection: $selectedIndex, label: Text("Select carrier")) {
                                ForEach(0 ..< carriers.count, id: \.self) {
                                    Text(self.carriers[$0].name)
                                }
                            }
                            
                        }
                    }
                    if carriers.count != 0{
                        Section {
                            Button(action: {
                                if self.carriers.count == 0{
                                    self.title = "Plase select a carrier first."
                                    self.isShowingAlert.toggle()
                                }else{
                                    self.isShowingLoading.toggle()
                                    self.postRequest()
                                }
                            }) {
                                Text("Submit Request")
                                    .foregroundColor(Color.red)
                                    .font(.custom("D-DIN", size: 16))
                            }
                            
                        }
                    }
                }
            }
        }.navigationBarTitle("Post Request")
            .padding(.top)
            .alert(isPresented: self.$isShowingAlert) {
                Alert(title: Text(self.title), message: nil, dismissButton: .default(Text("OK")))
        }
    }
    func getCarriersFromBE() {
        let params = ["tracking_number": trackingNumber] as [String: Any]
        apiService.callBEWithData(postUrl: "carriers/detect", params: params, method: .post) { (data) in
            if let data = data{
                do {
                    let JSON = try JSONDecoder().decode(DetectData.self, from: data)
                    if JSON.meta.code == 200{
                        self.carriers = JSON.data
                    }else{
                        self.title = JSON.meta.message
                        self.isShowingAlert.toggle()
                    }
                } catch let err {
                    print(err)
                }
                self.isShowingLoading.toggle()
            }
        }
    }
    func postRequest() {
        let params = ["tracking_number": trackingNumber,
                      "carrier_code": self.carriers[selectedIndex].code] as [String: Any]
        apiService.callBEWithData(postUrl: "trackings/post", params: params, method: .post) { (data) in
            if let data = data{
                do {
                    let JSON = try JSONDecoder().decode(FetchOrder.self, from: data)
                    if JSON.meta.code == 200{
                        if let order = JSON.data{
                            switch order {
                            case .array:
                                self.title = JSON.meta.message
                                self.isShowingAlert.toggle()
                                break
                            case .single(let order):
                                self.apiService.orders.append(order)
                                self.apiService.saveOrdersToDefaults()
                                self.presentation.wrappedValue.dismiss()
                            }
                        }
                    }else{
                        self.title = JSON.meta.message
                        self.isShowingAlert.toggle()
                    }
                } catch let err {
                    print(err)
                }
                self.isShowingLoading.toggle()
            }
        }
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
