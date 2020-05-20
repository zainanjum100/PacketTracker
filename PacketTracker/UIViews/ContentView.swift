//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Zeeshan Dar on 4/7/20.
//  Copyright © 2020 Zeeshan Dar. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct ContentView: View {
    @State var showDetail = false
    @State var showingAlert = false
    @State var isShowingAlert = false
    @State var inputNumber = ""
    @State var inputCarrier = ""
    @State var title = ""
    @EnvironmentObject var apiService: ApiService
    @State var selectedOrder: Order!
    init(){
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.981870234, green: 0.7615160346, blue: 0.1441443861, alpha: 1)
        UINavigationBar.appearance().tintColor = .red
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "D-DIN-Bold", size: 24)!,
            .foregroundColor: UIColor.red]
    }
    var body: some View {
        return NavigationView {
            VStack{
                if apiService.showLoading{
                    ActivityIndicator(isAnimating: apiService.showLoading) { (indicator: UIActivityIndicatorView) in
                        indicator.color = .red
                        indicator.hidesWhenStopped = false
                    }
                }else{
                    if apiService.orders.count == 0{
                        VStack{
                            Text("No data found")
                            
                            Button(action: {
                                self.apiService.loadData()
                            }) {
                                Text("Reload")
                                    .foregroundColor(Color.blue)
                            }
                        }
                        
                    }else{
                        List(apiService.orders, id: \.id) { order in
                            NavigationLink(destination: DetailView(order: order)) {
                                HomeCell(order: order)
                            }
                        }.listRowBackground(Color.init(#colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)))
                        
                    }
                }
                
            }
            .navigationBarTitle("HOME", displayMode: .inline).foregroundColor(.red)
            .navigationBarItems(trailing:
                NavigationLink(destination: PostRequestView().environmentObject(self.apiService), label: {
                    Image("ico_add")
                        .accentColor(.red)
                        .aspectRatio(contentMode: .fit)
                })
            )
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


