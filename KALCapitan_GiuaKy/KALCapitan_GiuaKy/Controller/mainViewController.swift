//
//  mainViewController.swift
//  KALCapitan_GiuaKy
//
//  Created by AnhKhoa on 4/25/17.
//  Copyright © 2017 AnhKhoa. All rights reserved.
//

import UIKit

class mainViewController: UIViewController, UIPageViewControllerDataSource {


    var pageViewController : UIPageViewController!
    var pageTitles : NSArray!
    var pageImages : NSArray!
    
    var strFloor : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strFloor = NSLocalizedString("Floor", comment: "Dat ten tang toa phong an") as String
        
        self.pageTitles = NSArray(objects: strFloor + " 1",strFloor + " 2")
        self.pageImages = NSArray(objects: "anhlau1.jpg","anhlau2.jpg", "anhlau3.jpg")
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewcontroller") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.size.height-30)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)

        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewControllerAtIndex(index : Int)->ContentViewController{
    if((self.pageTitles.count == 0) || (index >= self.pageTitles.count)){
    return ContentViewController()
    }
    
    let vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
    
    vc.imagesFile = self.pageImages[index] as! String
    vc.titlesText = self.pageTitles[index] as! String
    vc.pageIndex = index
    
    return vc
    }
    
    // MARK: - Page view controller Data source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if(index == 0)||(index == NSNotFound){
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if(index == NSNotFound){
            return nil
        }
        
        index += 1
        
        if(index == self.pageTitles.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
