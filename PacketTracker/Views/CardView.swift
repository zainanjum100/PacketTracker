//
//  CardView.swift
//  PacketTracker
//
//  Created by ZainAnjum on 15/05/2020.
//  Copyright © 2020 Noman2. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var trackingInfo: TrackingInfo!
    var body: some View {
        VStack{
            HStack{
                Text(trackingInfo.Date)
                    .font(.custom("D-DIN", size: 14))
                    .padding(10)
                    .padding(.top,-5)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1)))
                Text(trackingInfo.checkpoint_status)
                    .font(.custom("D-DIN", size: 14))
                    .foregroundColor(Color.red)
                    .padding(10)
                    .padding(.top,-5)
                    .padding(.leading, 20)
                Spacer()
            }
            HStack{
                Text(trackingInfo.StatusDescription)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1)))
                    .font(.custom("D-DIN", size: 14))
                    .padding(10)
                    .padding(.top,-5)
                
                Text(trackingInfo.Details)
                    .font(.custom("D-DIN", size: 14))
                    .foregroundColor(Color.red)
                    .padding(10)
                    .padding(.top,-5)
                    .padding(.leading, 20)
                Spacer()
            }
        }
        .padding(5)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.init(#colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)), lineWidth: 1)
                .shadow(radius: 20)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
