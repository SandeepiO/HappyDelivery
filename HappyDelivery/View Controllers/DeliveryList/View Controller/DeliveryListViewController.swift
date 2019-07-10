//
//  ViewController.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 26/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import UIKit

class DeliveryListViewController: UIViewController {
    
    var tableView: UITableView! = UITableView(frame: CGRect.zero, style: .grouped)
    var refreshControl = UIRefreshControl()
    var animatedCell: [IndexPath] = []
    var deliveryList: [DeliveryListModel] = []
    var bottomActivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var isNextPageApiCalled: Bool = false
    var dataManager: DataManager! = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.checkExistingDeliveryListData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func pullToRefresh(sender: AnyObject) {
        self.getDeliveryList(isToPullRefresh: true)
    }
    
    func setUpUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = NavigationTitle().deliveryList
        self.view.addSubview(self.tableView)
        self.bottomActivityIndicator.isHidden = true
        self.bottomActivityIndicator.color = .black
        self.setUpTableView()
    }

    func setUpTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraintForTableViewAndActivityIndicator()
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.register(DeliveryListTableViewCell.self, forCellReuseIdentifier: TableViewCell.cell)
        self.refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.refreshControl = self.refreshControl
        self.tableView.contentInset = UIEdgeInsets(top: EdgeInsetsValue.top, left: EdgeInsetsValue.left, bottom: EdgeInsetsValue.bottom, right: EdgeInsetsValue.right)
        self.tableView.estimatedRowHeight = CGFloat(kTableViewDefaultHeight)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func checkExistingDeliveryListData() {
        self.deliveryList = dataManager.getDeliveriesListFromCoreData(offset: kStartOffset, limit: kListLimit)
        if self.deliveryList.isEmpty {
            self.getDeliveryListFromServer()
            return
        }
        self.tableView.reloadData()
    }
    
}

// MARK: - Api Request
extension DeliveryListViewController {

    func getDeliveryListFromServer() {
        Indicator.shared.showActivityIndicatory(uiView: self.view)
        self.getDeliveryList()
    }
    
    func getDeliveryList(isToPullRefresh: Bool? = false) {
        dataManager.getDeliveryListFromServer(offset: self.deliveryList.count, limit: kListLimit, isToPullRefresh: isToPullRefresh, responseBlock: {[weak self] (deliveryList, error) in
            Indicator.shared.hideAcivityIndicator()
            if let error = error {
                self?.errorResponse(isToPullRefresh: isToPullRefresh ?? false, error: error)
            } else {
                self?.successFullResponse(isToPullRefresh: isToPullRefresh ?? false, deliveryList: deliveryList ?? [])
            }
        })
    }
    
    func successFullResponse(isToPullRefresh: Bool, deliveryList: [DeliveryListModel]) {
        self.refreshControl.endRefreshing()
        if !deliveryList.isEmpty {
            if isToPullRefresh {
                self.deliveryList.removeAll()
                CoreDataHelper.shared.deleteAllRecords()
            }
            self.deliveryList = deliveryList
            self.tableView.reloadData()
            CoreDataHelper.shared.save(deliveryList: self.deliveryList)
        }
        self.addTableViewBackgroundView()
    }
    
    func errorResponse(isToPullRefresh: Bool, error: Error) {
        DispatchQueue.main.async {[weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {[weak self] in
            self?.showAlertWithCancelButton(error.localizedDescription, AlertKey.retry, {[weak self] in
                self?.getDeliveryListFromServer()
            })
        })
        self.addTableViewBackgroundView()
    }

    func addTableViewBackgroundView() {
        if self.deliveryList.isEmpty {
            self.tableView.backgroundView = self.addLabelView()
        } else {
            self.tableView.backgroundView = nil
        }
    }

    func addLabelView() -> UILabel {
        let noDataLabel = UILabel()
        noDataLabel.numberOfLines = kZeroNumberOfLine
        noDataLabel.text = StringValue.noResultData
        noDataLabel.textAlignment = .center
        return noDataLabel
    }
    
    func getNextPageData() {
        let fetchedData = dataManager.getDeliveriesListFromCoreData(offset: self.deliveryList.count, limit: kListLimit)
        if !fetchedData.isEmpty {
            self.deliveryList += fetchedData
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        } else {
            DispatchQueue.main.async {[weak self] in
                self?.isNextPageApiCalled = true
                self?.getDeliveryListNextPageData()
            }
        }
    }
    
    func getDeliveryListNextPageData() {
        self.bottomActivityIndicator.isHidden = false
        self.bottomActivityIndicator.startAnimating()
        self.dataManager.getDeliveryListFromServer(offset: self.deliveryList.count, limit: kListLimit, isToPullRefresh: false, responseBlock: {[weak self](deliveryList, error) in
            self?.bottomActivityIndicator.isHidden = true
            self?.bottomActivityIndicator.stopAnimating()
            self?.isNextPageApiCalled = false
            if let error = error {
                self?.showAlert(error.localizedDescription, nil)
            } else {
                if let deliveryList = deliveryList, !deliveryList.isEmpty {
                    self?.deliveryList += deliveryList
                    self?.tableView.reloadData()
                    CoreDataHelper.shared.save(deliveryList: deliveryList)
                }
            }
        })
    }
}

// MARK: - Table View Delegate, DataSource
extension DeliveryListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cell, for: indexPath) as! DeliveryListTableViewCell
        cell.selectionStyle = .none
        cell.configCell(self.deliveryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeliveryDetailViewController(model: self.deliveryList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !animatedCell.contains(indexPath) {
            animatedCell.append(indexPath)
            cell.transform = CGAffineTransform(scaleX: Animation.Scale.x, y: Animation.Scale.y)
            UIView.animate(withDuration: Animation.Duration.time) {
                cell.transform = CGAffineTransform.identity
            }
        }
        if indexPath.row == self.deliveryList.count - 1 && isNextPageApiCalled == false {
            self.getNextPageData()
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return bottomActivityIndicator
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

}

// MARK: - Constriant
extension DeliveryListViewController {

    func addConstraintForTableViewAndActivityIndicator() {
        NSLayoutConstraint(item: tableView as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        NSLayoutConstraint(item: tableView as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        NSLayoutConstraint(item: tableView as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        NSLayoutConstraint(item: tableView as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
    }

}
