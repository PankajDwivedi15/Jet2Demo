//
//  AWS_Service.swift
//  InternationalVideoEditingApplication
//
//  Created by cis on 26/02/20.
//  Copyright © 2020 cis. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceCall: String {
    case BaseUrl = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/"
    case BlogsPage = "blogs?page="
    case Limit = "&limit=10"
}

protocol MyEncodable: Encodable {
    func toJSONData() -> Data?
}

extension MyEncodable {
    func toJSONData() -> Data?{
        return try? JSONEncoder().encode(self)
    }
}


class NetworkingClient {
    typealias JSONTaskCompletionHandler = (Decodable?, String?) -> Void
    
    func request<T: Decodable, U: Encodable>(urlString: String, httpMethod : HTTPMethod, parameters: U, decodingType: T.Type, isGet:Bool, completion: @escaping JSONTaskCompletionHandler ) {
        
        
        guard let url = URL(string: "\(ServiceCall.BaseUrl.rawValue)\(urlString)") else { return }
        print("Url Request = \(url)")
        
        var request = URLRequest.init(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil, response.error?.localizedDescription)
                    return
                }
                do {
                    let genericModel = try JSONDecoder().decode(decodingType, from: data)
                    print((genericModel))
                    completion(genericModel, nil)
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}


extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
