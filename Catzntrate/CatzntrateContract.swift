//
//  CatzntrateContract.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/20.
//

import Foundation
import web3
import BigInt

//public enum CatzntrateContractFunction{
//    // get attr
//    public struct getStats: ABIFunction{
//        public static let name = "getStats"
//        public let gasPrice: BigUInt?
//        public let gasLimit: BigUInt?
//        public var contract: EthereumAddress
//        public let from: EthereumAddress?
//        public let id: BigUInt
//        
//        public init(contract: EthereumAddress,
//                    from: EthereumAddress? = nil,
//                    gasPrice: BigUInt? = nil,
//                    gasLimit: BigUInt? = nil,
//                    // input
//                    id:BigUInt) {
//            self.contract = contract
//            self.from = from
//            self.gasPrice = gasPrice
//            self.gasLimit = gasLimit
//            self.id = id
//        }
//        
//        public func encode(to encoder: ABIFunctionEncoder) throws {
//            try encoder.encode(id)
//        }
//    }
//    
//    public struct getStatsResponse: ABIResponse, MulticallDecodableResponse {
//        public static var types: [ABIType.Type] = [ Bool.self ]
//        public let value: Bool
//        
//        public init?(values: [ABIDecoder.DecodedValue]) throws {
//            self.value = try values[0].decoded()
//        }
//    }
//    
//    // getStates
//    public struct getStates: ABIFunction{
//        public static let name = "getStates"
//        public let gasPrice: BigUInt?
//        public let gasLimit: BigUInt?
//        public var contract: EthereumAddress
//        public let from: EthereumAddress?
//        public let id: BigUInt
//        
//        public init(contract: EthereumAddress,
//                    from: EthereumAddress? = nil,
//                    gasPrice: BigUInt? = nil,
//                    gasLimit: BigUInt? = nil,
//                    // input
//                    id:BigUInt) {
//            self.contract = contract
//            self.from = from
//            self.gasPrice = gasPrice
//            self.gasLimit = gasLimit
//            self.id = id
//        }
//        
//        public func encode(to encoder: ABIFunctionEncoder) throws {
//            try encoder.encode(id)
//        }
//    }
//}
//
//public enum CatzntrateContractResponse{
//    public struct getStatsResponse: ABIResponse, MulticallDecodableResponse {
//        public static var types: [ABIType.Type] = [ BigUInt.self,BigUInt.self,BigUInt.self,BigUInt.self ]
//        public let value: BigUInt
//        
//        public var effiency: BigUInt
//        public var curiousity: BigUInt
//        public var luck: BigUInt
//        public var vitaity: BigUInt
//
//        public init?(values: [ABIDecoder.DecodedValue]) throws {
//            self.value = try values[0].decoded()
//            
//            self.effiency =  try values[0].decoded()
//            self.curiousity =  try values[1].decoded()
//            self.luck =  try values[2].decoded()
//            self.vitaity =  try values[3].decoded()
//        }
//    }
//    
//    public struct getStatesResponse: ABIResponse, MulticallDecodableResponse {
//        // [lv, exp, skillPoint, energy, saturation, gender]
//        public static var types: [ABIType.Type] = [ BigUInt.self, BigUInt.self, BigUInt.self,BigUInt.self,BigUInt.self,BigUInt.self,Bool.self ]
//        public let value: BigUInt
//        
//        public var state: BigUInt
//        public var lv: BigUInt
//        public var exp: BigUInt
//        public var skillPoint: BigUInt
//        public var energy: BigUInt
//        public var saturation: BigUInt
//        public var gender: Bool
//
//        public init?(values: [ABIDecoder.DecodedValue]) throws {
//            self.value = try values[0].decoded()
//            
//            
//        }
//    }
//
//}
