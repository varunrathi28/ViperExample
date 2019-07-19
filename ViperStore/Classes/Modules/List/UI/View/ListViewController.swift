//
//  ListViewController.swift
//  ViperStore
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    //1
    var eventHandler : ListPresenter?
    //2
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<NSNumber, Product>>()
    //3
    var dataArray: Variable<[SectionModel<NSNumber, Product>]> = Variable([])
    
    @IBOutlet weak var tableView : UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eventHandler?.updateView()
        
    }
    
    
    func configureView() {
        //Title
        navigationItem.title = "Products"
        
        //Table View Configuration
        let dataSource = self.dataSource
        
        dataSource.configureCell = { (_, tv, indexPath, product) in
            let cell = tv.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
            cell.configureWithProduct(product: product)
            
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return Category(rawValue: dataSource[sectionIndex].model.intValue)?.title()
        }
        
        dataArray.asObservable()
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
 
    //MARK:
    //MARK: Other Methods
    func showProducts(sectioned data: [SectionModel<NSNumber, Product>]) {
        dataArray.value = data
    }
    
}
