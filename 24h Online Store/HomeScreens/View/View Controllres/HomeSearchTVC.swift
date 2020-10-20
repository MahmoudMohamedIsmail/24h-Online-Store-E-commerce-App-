//
//  HomeSearchTVC.swift
//  24h Online Store
//
//  Created by macboock pro on 10/17/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class HomeSearchTVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var tableViewSearch: UITableView!
    //MARK: - Properties
    var searchViewModel = HomeSearchViewModel()
    var product = PublishSubject<Product>()
    let disposeBag = DisposeBag()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToItems()
        subscribeToDidSelectedCell()
    }
  //MARK: - Methods
    func subscribeToItems() {
        searchViewModel.items.bind(to: tableViewSearch.rx.items(cellIdentifier: "searchCell")){ (row, item, cell) in
            cell.textLabel?.text = item.name
        }.disposed(by: disposeBag)
        
    }
    func subscribeToDidSelectedCell() {
        tableViewSearch.rx.itemSelected.subscribe(onNext: { (indexPath) in
            let item = try! self.searchViewModel.items.value()[indexPath.row]
            self.product.onNext(item)
        }).disposed(by: disposeBag)
        
    }
}
