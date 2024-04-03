//
//  ViewController.swift
//  CryptoApp
//
//  Created by Wiktor Witkowski on 21/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
  

    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let cryptoVM = CryptoVM()
    
    var cryptoList = [Crypto]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        setUpBinding()
        cryptoVM.requestURL()
   
    }
    
   private func setUpBinding(){
       
       cryptoVM
           .loading
           .bind(to: self.indicatorView.rx.isAnimating)
           .disposed(by: disposeBag)
       
//       cryptoVM
//           .error
//           .observe(on: MainScheduler.asyncInstance)
//           .subscribe { errorString in
//               print(errorString)
//           }
//           .disposed(by: disposeBag)
//
       cryptoVM
           .cryptos
           .observe(on: MainScheduler.asyncInstance)
           .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoViewCell.self)){row,item,cell in
               cell.item = item
               
           }
           .disposed(by: disposeBag)
       
        
       cryptoVM
           .cryptos
           .observe(on: MainScheduler.asyncInstance)
           .subscribe { cryptos in
               self.cryptoList = cryptos
               self.tableView.reloadData()
               
           }
           .disposed(by: disposeBag)
        
        
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        var content = cell.defaultContentConfiguration()
//        content.text = cryptoList[indexPath.row].currency
//        content.secondaryText = cryptoList[indexPath.row].price
//        cell.contentConfiguration = content
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cryptoList.count
//    }
    
}

