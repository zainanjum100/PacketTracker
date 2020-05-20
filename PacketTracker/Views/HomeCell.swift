//
//  HomeCell.swift
//  PacketTracker
//
//  Created by ZainAnjum on 13/05/2020.
//  Copyright © 2020 Noman2. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation
struct HomeCell: View {
    var order: Order!
    var body: some View {
        return VStack(alignment: .leading, content: {
            Text(self.order.id)
                .foregroundColor(Color.red)
                .lineLimit(nil)
                .font(.custom("D-DIN-Bold", size: 18))
                .padding()
            
            HStack(alignment: .center, spacing: 5, content: {
                Text("Tracking Id:")
                    .foregroundColor(Color.black)
                    .lineLimit(nil)
                    .font(.custom("D-DIN", size: 13))
                
                Text(order.tracking_number)
                    .foregroundColor(Color.gray)
                    .lineLimit(nil)
                    .font(.custom("D-DIN", size: 13))
                    .padding()
                Spacer()
                
            }).padding(.leading)
            Text(order.status)
                .foregroundColor(Color.red)
                .lineLimit(nil)
                .font(.body)
                .padding(.leading)
                .font(.custom("D-DIN", size: 15))
            
        }).background(Color.init(#colorLiteral(red: 0.9681620507, green: 0.9850651712, blue: 0.9856703368, alpha: 1)))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.init(#colorLiteral(red: 0.9681620507, green: 0.9850651712, blue: 0.9856703368, alpha: 1)), lineWidth: 1)
        )
    }
}
#if DEBUG
struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell()
    }
}
#endif
