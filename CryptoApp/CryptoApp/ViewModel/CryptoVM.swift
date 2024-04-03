//
//  CryptoVM.swift
//  CryptoApp
//
//  Created by Wiktor Witkowski on 01/03/2024.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoVM {
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
   
    func requestURL(){
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadData(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case.success(let cryptos):
                self.cryptos.onNext(cryptos)
            case.failure(let error):
                switch error {
                case.parsingError:
                    self.error.onNext("Parsing Error")
                case.serverError:
                    self.error.onNext("Server Error")
                }
                
                
            }
        }
        
    }
    
    
    
    
}
