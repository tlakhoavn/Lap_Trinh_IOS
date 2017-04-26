//
//  mainViewController.swift
//  KALCapitan_GiuaKy
//
//  Created by AnhKhoa on 4/25/17.
//  Copyright © 2017 AnhKhoa. All rights reserved.
//

import UIKit

var QuanLyQuanAnDB: OpaquePointer? = nil
class mainViewController: UIViewController, UIPageViewControllerDataSource {
    var pageViewController : UIPageViewController!
    var pageTitles : NSArray!
    var pageImages : NSArray!
    
    var strFloor : String!
    
    //Slide Menu
    var btnMenu: UIButton = UIButton()
    var btnOrder: UIButton = UIButton()
    var viewMenu: UIView = UIView()
    
    var btnMenuRoomFormat: UIButton = UIButton()
    var btnMenuStatistics: UIButton = UIButton()
    var btnMenuInfomation: UIButton = UIButton()
    var labelMenuVersion: UILabel = UILabel()
    
    
    //Khai bao cho SQLite
    
    var MonanList:[ClassMonAn] = []
    var BanAnList:[ClassBanAn] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///-Khoi tao cho sqlite
        QuanLyQuanAnDB = openDB();
        BanAnList = selectBanAn(db: QuanLyQuanAnDB)
        /*
        MonanList = selectMonAn(db: QuanLyQuanAnDB)
        //BanAnList = selectBanAn(db: QuanLyQuanAnDB)
        let a:Int = MonanList.count
        print(a)
        print(BanAnList.count)
        BanAnList[0].SoBan = 10
        ThemBanAn(db: QuanLyQuanAnDB, BanAn: BanAnList[0])
        let tem:ClassMonAn = ClassMonAn()
        ThemMonAn(db: QuanLyQuanAnDB, MonAn: tem)
        // Them ban an
        let temp:ClassBanAn = ClassBanAn(SoBan: 8, ThongTin: "HGJGHTY", HinhAnh: "HJFGHFYFT", MaKhuVuc: 3)
        ThemBanAn(db: QuanLyQuanAnDB, BanAn: temp)
        */
        
        //-----
        slideMenuInit()
        
        //-----
        strFloor = NSLocalizedString("Floor", comment: "Dat ten tang toa phong an") as String
        
        self.pageTitles = NSArray(objects: strFloor + " 1",strFloor + " 2")
        self.pageImages = NSArray(objects: "anhlau1.jpg","anhlau2.jpg", "anhlau3.jpg")
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewcontroller") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.height)!, width: self.view.frame.width, height: self.view.frame.size.height-30)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)

        // Do any additional setup after loading the view.
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     /////////////////////////////////////////////
    func slideMenuInit(){
        
        navigationController?.navigationBar.backgroundColor = UIColor.green
                //Tao button Order
        btnMenuSettup()
        btnOrderSettup()
        viewMenuSettup()
        
    }
    
    
    private func btnOrderSettup(){
        //Tao button Order dat ban
        btnOrder = UIButton(frame: CGRect(x: self.view.frame.size.width - 30 - 10, y:10, width: 30, height: 30))
        btnOrder.setBackgroundImage(#imageLiteral(resourceName: "order"), for: .normal)
        navigationController?.navigationBar.addSubview(btnOrder)
        btnOrder.addTarget(self,action: #selector(mainViewController.btnOrderClick), for: .touchUpInside)
        
    }
    
    private func btnMenuSettup(){
        //Tao button Menu
        btnMenu = UIButton(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        btnMenu.setBackgroundImage(#imageLiteral(resourceName: "menu"), for: .normal)
        navigationController?.navigationBar.addSubview(btnMenu)
        btnMenu.addTarget(self,action: #selector(mainViewController.showSlideMenu), for: .touchUpInside)
    }
    
    
    private func viewMenuSettup(){
        //Tao view khi click vao Menu
        viewMenu = UIView(frame: CGRect(x: -3*view.frame.width/5, y:(navigationController?.navigationBar.frame.height)! , width: 3*self.view.frame.size.width/5, height: self.view.frame.size.height - (navigationController?.navigationBar.frame.height)! ))
        navigationController?.navigationBar.addSubview(viewMenu)
        viewMenu.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.65)
        
        
        //Them cac button trong menu
        let spaceBetweenMenuButton = 20
        let menuButtonFontSize = 20
        let menuButtonOriginX = 10
        let menuButtonWidth = 170
        let menuButtonHeight = 30
        
        //Bo tri them xoa sua cac ban an trong phong
        btnMenuRoomFormat = UIButton(frame: CGRect(x: menuButtonOriginX, y: 10, width: menuButtonWidth, height: menuButtonHeight))
        btnMenuRoomFormat.titleLabel!.font = UIFont.systemFont(ofSize: CGFloat(menuButtonFontSize))
        btnMenuRoomFormat.titleLabel!.lineBreakMode = .byTruncatingTail
        btnMenuRoomFormat.titleLabel!.textColor = UIColor.black
        btnMenuRoomFormat.setTitleColor(UIColor.black, for: UIControlState.normal)
        btnMenuRoomFormat.contentHorizontalAlignment = .left
        btnMenuRoomFormat.setTitle(NSLocalizedString("MenuRoomFormatTitle", comment: "Cai dat bo tri phong an") as String, for: UIControlState.normal)
        btnMenuRoomFormat.addTarget(self, action:#selector(mainViewController.btnMenuRoomFormatClick), for: UIControlEvents.touchUpInside)
        viewMenu.addSubview(btnMenuRoomFormat)
        
        
        //Thong ke doanh thu
        btnMenuStatistics = UIButton(frame: CGRect(x: menuButtonOriginX, y: Int(btnMenuRoomFormat.frame.maxY) + spaceBetweenMenuButton, width: menuButtonWidth, height: menuButtonHeight))
        btnMenuStatistics.titleLabel!.font = UIFont.systemFont(ofSize: CGFloat(menuButtonFontSize))
        btnMenuStatistics.titleLabel!.lineBreakMode = .byTruncatingTail
        btnMenuStatistics.titleLabel!.textColor = UIColor.black
        btnMenuStatistics.setTitleColor(UIColor.black, for: UIControlState.normal)
        btnMenuStatistics.contentHorizontalAlignment = .left
        btnMenuStatistics.setTitle(NSLocalizedString("MenuStatisticsTitle", comment: "Thong ke doanh thu") as String, for: UIControlState.normal)
        btnMenuStatistics.addTarget(self, action:#selector(mainViewController.btnMenuStatisticsClick), for: UIControlEvents.touchUpInside)
        viewMenu.addSubview(btnMenuStatistics)

        
        
    }
    
    func btnMenuStatisticsClick(){
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "MenuStatistics");
        alertView.title = "Alert!";
        alertView.message = "MenuStatistics here";
        alertView.show();
    }
    
    func btnMenuRoomFormatClick(){
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "MenuRoomFormat");
        alertView.title = "Alert!";
        alertView.message = "MenuRoomFormat here";
        alertView.show();
    }

    
    func showSlideMenu(){
        //print("CLICK MENU SLIDE")
        UIView.animate(withDuration: 0.7){
            
            //click hien va click tiep an menu
            self.viewMenu.frame.origin.x = -3*self.view.frame.width/5 - self.viewMenu.frame.origin.x
            //Khong the cham vao man hinh chinh khi dang hien menu
            if(self.viewMenu.frame.origin.x == 0) {
                self.view.isUserInteractionEnabled = false
                self.btnOrder.isEnabled = false
            }else{
                self.view.isUserInteractionEnabled = true
                self.btnOrder.isEnabled = true
            }
        }
    }

    
    func btnOrderClick(){
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "Order");
        alertView.title = "Alert!";
        alertView.message = "Button Order here";
        alertView.show();
    }
    
    
    
    //-------------------
    
    func viewControllerAtIndex(index : Int)->ContentViewController{
    if((self.pageTitles.count == 0) || (index >= self.pageTitles.count)){
    return ContentViewController()
    }
    
    let vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
    
    vc.imagesFile = self.pageImages[index] as! String
    vc.titlesText = self.pageTitles[index] as! String
    vc.pageIndex = index
        
    //Them danh sach ban an cho tang
        for var i in 0...BanAnList.count-1 {
            if(BanAnList[i].MaKhuVuc == index+1){
                vc.dsBanAnMotTang.append(BanAnList[i])
            }
        }
    
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
