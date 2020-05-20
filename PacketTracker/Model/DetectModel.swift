//
//  DetectModel.swift
//  PacketTracker
//
//  Created by ZainAnjum on 20/05/2020.
//  Copyright © 2020 Noman2. All rights reserved.
//

import Foundation

struct DetectData: Codable {
    let data: [CarrierCode]
}
struct CarrierCode: Codable {
    let name: String
    let code: String
}


struct AllData: Codable {
    let data: AllItems
}
struct AllItems: Codable {
    let items: [Order]
}
struct FetchOrder: Codable {
    let meta: MetaData
    let data: SingleOrArray?
}
enum SingleOrArray: Codable {
    case single(Order)
    case array([Order])
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .single(container.decode(Order.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .array(container.decode([Order].self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(SingleOrArray.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload conflicts with expected type"))
            }
        }
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .single(let single):
            try container.encode(single)
        case .array(let array):
            try container.encode(array)
        }
    }
}

struct Order: Codable {
    let status,carrier_code,tracking_number,id : String
}
struct AllOrderDetail: Codable {
    let data: OrderDetail
}
struct OrderDetail: Codable {
    let status,carrier_code,tracking_number,id : String
    let destination_country: String
    let origin_info: OriginInfo
}

struct OriginInfo: Codable{
    let trackinfo: [TrackingInfo]?
}
struct TrackingInfo: Codable {
    let Date: String
    let StatusDescription: String
    let Details: String
    let substatus: String
    let checkpoint_status: String
}
struct Meta: Codable {
    let meta: MetaData
}
struct MetaData: Codable {
    let message: String
    let code: Int
}
