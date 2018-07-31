//
//  Alamowater.swift
//  Alamowater
//
//  Created by 甘忠达 on 7/31/18.
//  Copyright © 2018 Zhongda Gan. All rights reserved.
//

import Foundation
import UIKit


public protocol AlamoWaterProtocol {
    func didCallHello()
}

open class AlamoWater: NSObject {
    public static let shared = AlamoWater()
    
    public var delegate:AlamoWaterProtocol?
    
    open func hello(){
        debugPrint("Hello from AlamoWater!")
        AlamoWater.shared.delegate?.didCallHello()
    }
    
    public func fetchAndParseDataFromApi<T>(urlString: String, type: T.Type, completion: @escaping (T?, Error?)->Void) where T : Codable{
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error == nil{
                do{
                    let jsonResult = try JSONDecoder().decode(T.self, from: data!)
                    completion(jsonResult, nil)
                }catch{
                    print("can not parse json data")
                }
            }else{
                completion(nil, error)
            }
        }).resume()
    }
}
