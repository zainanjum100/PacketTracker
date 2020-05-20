//
//  Response.swift
//  SwiftUIDemo
//
//  Created by Zeeshan Dar on 4/7/20.
//  Copyright © 2020 Zeeshan Dar. All rights reserved.
//

import SwiftUI

struct Response: Decodable {

    var data: Tracking
    var meta : TractingData?
    
    
    
//    public init(from: Decoder) {
//    //decoding here
//    }
    
}

struct Tracking: Decodable {
    
    var page: Int
    var limit: Int
    var total: String
    var items : [Items]?
    
    
    init(_ dictionary: [String: Any]) {
         self.page = dictionary["page"] as? Int ?? 0
         self.limit = dictionary["limit"] as? Int ?? 0
         self.total = dictionary["total"] as? String ?? ""
         self.items = dictionary["items"] as? [Items] ?? []
    }
    
}

struct Items: Decodable {
    
    var id:String?
    var tracking_number:String?
    var carrier_code:String?
    var order_create_time:String?
    var status:String?
    var created_at:String?
    var customer_email:String?
    var customer_name:String?
    var order_id:String?
    var comment:String?
    var title:String?
//    var logistics_channel:String?
   var updated_at:String?
    var archived:Bool?
   var original_country:String?
  var destination_country:String?
   //var itemTimeLength:Int?
   var service_code:String?
   var lastEvent:String?
    var lastUpdateTime:String?
    var origin_info:origin_info?
    
//    enum CodingKeys : String , CodingKey {
//
//           case identifier = "id"
//           case tracking_number
//           case carrier_code
//           case order_create_time
//           case status
//           case created_at
//           case customer_email
//           case customer_name
//           case order_id
//           case comment
//           case title
////           var logistics_channel:String?
////           var updated_at:String?
////           var archived:Bool?
////           var original_country:String?
////           var destination_country:String?
////           var itemTimeLength:Int?
////           var service_code:String?
////           var lastEvent:String?
////           var lastUpdateTime:String?
//       }
    
//
//    init(_ dictionary: [String: Any]) {
//            self.id = dictionary["id"] as? String ?? ""
//            self.tracking_number = dictionary["tracking_number"] as? String ?? ""
//            self.carrier_code = dictionary["carrier_code"] as? String ?? ""
//            self.order_create_time = dictionary["order_create_time"] as? String ?? ""
//            self.status = dictionary["status"] as? String ?? ""
//            self.created_at = dictionary["created_at"] as? String ?? ""
//            self.customer_email = dictionary["customer_email"] as? String ?? ""
//            self.customer_name = dictionary["customer_name"] as? String ?? ""
//            self.order_id = dictionary["order_id"] as? String ?? ""
//            self.comment = dictionary["comment"] as? String ?? ""
//            self.title = dictionary["title"] as? String ?? ""
////            self.logistics_channel = dictionary["logistics_channel"] as? String ?? ""
////            self.updated_at = dictionary["updated_at"] as? String ?? ""
////            self.archived = dictionary["archived"] as? Bool ?? false
////            self.original_country = dictionary["original_country"] as? String ?? ""
////            self.destination_country = dictionary["destination_country"] as? String ?? ""
////            self.itemTimeLength = dictionary["itemTimeLength"] as? Int ?? 0
////            self.service_code = dictionary["service_code"] as? String ?? ""
////            self.lastEvent = dictionary["lastEvent"] as? String ?? ""
////            self.lastUpdateTime = dictionary["lastUpdateTime"] as? String ?? ""
//        //self.origin_info = dictionary["origin_info"] as? [String:Any] ?? [String:Any]
//           // self.destination_info = dictionary["destination_info"] as? [String:Any] ?? [String:Any]
//    }
    
    
    
    
    
    
}

struct origin_info:Decodable {
    var ArrivalfromAbroad : String?
    var CustomsClearance : String?
    var DepartfromAirport : String?
    var DestinationArrived : String?
    var ItemDispatched : String?
    var ItemReceived : String?
    var ReferenceNumber : String?
    var carrier_code : String?
    var phone : String?
    var trackinfo : [trackinfo]?
    
}

struct trackinfo : Decodable{
    var Date : String?
    var Details : String?
    var StatusDescription : String?
    var checkpoint_status : String?
    var substatus : String?
}

struct TractingData:Decodable {
    var code:Int?
    var type:String?
    var message:String?
    
//    init(_ dictionary: [String: Any]) {
//      self.code = dictionary["code"] as? Int ?? 0
//      self.type = dictionary["type"] as? String ?? ""
//      self.message = dictionary["message"] as? String ?? ""
//    }
}




