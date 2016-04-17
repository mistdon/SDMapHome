//
//  SDTabBarViewController.swift
//  SDMapHome
//
//  Created by Allen on 16/4/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class SDTabBarViewController: UITabBarController {
    private enum Tab:Int{
        case Root
        case Library
        case PersonalInfo
        
        var title: String{
            switch self {
            case .Root:
                return NSLocalizedString("Lists", comment: "")
            case .Library:
                return NSLocalizedString("Library", comment: "")
            case .PersonalInfo:
                return NSLocalizedString("Personal", comment: "")
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        if let items = tabBar.items {
            for i in 0..<items.count {
                let item = items[i]
                item.title = Tab(rawValue:i)?.title
            }
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
