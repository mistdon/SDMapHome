//
//  SDPersonalInfoViewController.swift
//  SDMapHome
//
//  Created by Allen on 16/4/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
//import SDSettingViewController

class SDPersonalInfoViewController: UIViewController {
    
    private let setttingTableView = UITableView()
    override func viewDidLoad() {
        title = "我的"
//        setttingTableView = 
        view.addSubview(setttingTableView)
        
//        let setttingButton = UIBarButtonItem.init(image: UIImage.init(named: "angle-mask@3x"), style: UIBarButtonItemStyle.Plain, target:self , action:set)
//        self.navigationItem.leftBarButtonItem = setttingButton
    }
    func settingBttonClicked() {
        let vc = UIViewController.init()
        self.navigationController! .pushViewController(vc, animated: true)
    }
}
