//
//  WebService.swift
//  CryptoApp
//
//  Created by Wiktor Witkowski on 22/02/2024.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}

class WebService {
    
    func downloadData(url:URL, completion: @escaping (Result<[Crypto],CryptoError>) -> () ){
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(.serverError))
            }else if let data = data {
               let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList{
                    completion(.success(cryptoList))
                }else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
        
    }
    
}
