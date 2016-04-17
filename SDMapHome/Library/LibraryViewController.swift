//
//  LibraryViewController.swift
//  SDMapHome
//
//  Created by Allen on 16/4/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import SVProgressHUD


class LibraryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - Property
    let identifierBookCell = "BookCell"
    let pagesize = 10
    var page = 0
    let URLString = "https://api.douban.com/v2/book/search?"
    var tag  = "Swift"
    var books = [Book]()
    
    //MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        self.books = []
//        tableView.headerBeginRefresh()
        addHeaderAndFooterRefresh()
        tableView.headerBeginRefresh()
        let nib = UINib.init(nibName: "BookCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: identifierBookCell)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
//        NetManager.GET(URLString, parameters: ["tag":tag,"start":0,"count":10], showHUD: true, success: { (responseObject) in
//            self.books = []
//            if let dict = responseObject as? [String:NSObject],array = dict["books"] as? [[String:NSObject]]{
//                for dict in array {
//                    self.books.append(Book(dict: dict))
//                }
//                self.tableView.reloadData()
//            }
//            print(self.books.count)
//            
//            }) { (eror) in
//                print(eror)
//        }
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - UITableView datasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookcell = tableView.dequeueReusableCellWithIdentifier(identifierBookCell,forIndexPath: indexPath) as!  BookCell
        bookcell.configureWithBook(self.books[indexPath.row])
        return bookcell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    private func addHeaderAndFooterRefresh(){
        tableView.headerAddMJRefresh { 
            self.tableView.footerResetNoMoreData()
            NetManager.GET(self.URLString, parameters: ["tag":self.tag,"start":self.page,"count":self.pagesize], showHUD: false, success: { (responseObject) in
                
                if let dict = responseObject as? [String:NSObject],array = dict["books"] as? [[String:NSObject]]{
                    for dict in array {
                        self.books.append(Book(dict: dict))
                    }
                    self.tableView.reloadData()
                }
                print(self.books.count)
                self.page += 1
                self.tableView.headerEndRefresh()
            }) { (eror) in
                print(eror)
                self.tableView.headerEndRefresh()
            }
        }
        
        

    }

}
