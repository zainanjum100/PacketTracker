//
//  DetailView.swift
//  PacketTracker
//
//  Created by Noman2 on 07/05/2020.
//  Copyright © 2020 Noman2. All rights reserved.
//


import SwiftUI
import CoreLocation
import MapKit

struct DetailView : View {
    var order: Order!
    @State private var orderDetails: OrderDetail!
    @State private var showLoading = true
    @State var location = MKPointAnnotation()
    @EnvironmentObject var apiService: ApiService
    
    var body: some View {
        VStack{
            if orderDetails == nil{
                if showLoading{
                ActivityIndicator(isAnimating: showLoading) { (indicator: UIActivityIndicatorView) in
                    indicator.color = .red
                    indicator.hidesWhenStopped = false
                    }
                }else{
                    Text("The request was successful but the response is empty.")
                }
            }else{
                VStack{
                    Text("Tracking No: \(self.orderDetails.tracking_number)")
                        .foregroundColor(Color.black)
                        .padding()
                        .font(.custom("D-DIN", size: 18))
                    
                    if location.coordinate.latitude == 0{
                        Text(orderDetails == nil ? "No Location found" : "Loading location...")
                            .foregroundColor(Color.red)
                            .lineLimit(nil)
                            .font(.body)
                            .padding(.leading)
                            .font(.custom("D-DIN", size: 15))
                            .padding(12)
                    }else{
                        MapView(location: location)
                            .padding(12)
                    }
                    HStack{
                        Text("Status")
                            .padding()
                        Spacer()
                        Text(self.orderDetails.status)
                            .font(.custom("D-DIN-Bold", size: 22))
                            .foregroundColor(Color.red)
                            .padding()
                            .padding(.trailing,6)
                    }
                    HStack{
                        Spacer()
                        Text(orderDetails.carrier_code)
                            .padding(10)
                            .padding(.trailing,10)
                            .font(.custom("D-DIN", size: 14))
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(radius: 12, corners: .allCorners)
                            .padding(.trailing,12)
                    }.padding(.trailing,10)
                    List{
                        ForEach(0 ..< (self.orderDetails.origin_info.trackinfo?.count ?? 0)) { item in
                            CardView(trackingInfo: self.orderDetails.origin_info.trackinfo?[item])
                        }
                    }
                }
            }
        }
        .navigationBarTitle("\(self.order.title ?? "Unknown")", displayMode: .inline).foregroundColor(.red)
        .onAppear {
            self.getTrackingDetail()
        }
        
    }
    
    func getTrackingDetail() {

        self.apiService.callBEWithData(postUrl: "trackings/\(order.carrier_code)/\(order.tracking_number)", params: nil, method: .get) { (data) in
            if let data = data{
                do {
                    let JSON = try JSONDecoder().decode(AllOrderDetail.self, from: data)
                    self.orderDetails = JSON.data
                    self.getCoordinateFrom(address: self.orderDetails.destination_country) { (cords, error) in
                        if error == nil{
                            let annotation = MKPointAnnotation()
                            annotation.title = self.orderDetails.destination_country
                            annotation.coordinate = cords!
                            self.location = annotation
                            self.showLoading.toggle()
                        }else{
                            print(error!)
                            self.showLoading.toggle()
                        }
                    }
                } catch let err {
                    print(err)
                    self.showLoading.toggle()
                }
            }
        }
    }
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
