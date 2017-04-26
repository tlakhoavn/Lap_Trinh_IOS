//
//  ContentViewController.swift
//  KALCapitan_GiuaKy
//
//  Created by AnhKhoa on 4/25/17.
//  Copyright © 2017 AnhKhoa. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    /*
    class cThongTinBanAn{
        var maBan: Int
        
        init(){
            self.maBan = 0
        }
        
    }
 */
    //MARK: *** Declare variables
    
    @IBOutlet weak var viewPhongAn: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var imageView: UIImageView!
    
    
    var pageIndex:Int!
    var titlesText: String!
    var imagesFile: String!
    
    //var danhsachBanAn = [cThongTinBanAn](repeating: cThongTinBanAn(), count: 0)
    
    
    //SQLite
    var dsBanAnMotTang:[ClassBanAn] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("so luong ban an\(dsBanAnMotTang.count)")
        
        // Do any additional setup after loading the view.
        //self.imageView.image = UIImage(named: imagesFile)
        let backgroundImage: UIImage = UIImage(named: imagesFile)!
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        self.titleLabel.text = titlesText
                
        hienThiDanhSachBanAn()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    func hienThiDanhSachBanAn(){
        
        var arrButton = [UIButton]()
        
        /*
        print("MinY \(self.view.frame.minY)")
        print("MaxY \(self.view.frame.maxY)")
        print("MinX \(self.view.frame.minX)")
        print("MaxX \(self.view.frame.maxX)")
        print("width \(self.view.frame.size.width)")
        print("height \(self.view.frame.size.height)")
        */
        
        //Khai bao canh chinh le tu dong
        let leftMargin:Float = 15.0
        let rightMargin:Float = 15.0
        let topMargin:Float = 35.0
        //let bottoMargin:Float = 10.0
        let viewWidth = Float(self.view.frame.size.width)
        //let viewHeight = Float(self.view.frame.size.height)
        
        let buttonWidth:Float = 64.0
        let buttonHeight:Float = 64.0
        var spaceBetweenButton:Float = 0    //Khoang cach giua 2 ban an
        
        
        var xPos = leftMargin + 0
        var yPos = topMargin + 0
        
        
        //Tinh va sap xep so luong button tren mot hang
        let floorWidth = viewWidth - leftMargin - rightMargin
        let numOfButtonPerRow = Int(floorWidth/(1.5*buttonWidth))
        
        spaceBetweenButton = ( floorWidth - Float(numOfButtonPerRow) * buttonWidth )/Float(numOfButtonPerRow - 1)
            
        //print("So luong button tren hang la: \(numOfButtonPerRow)")
        
        let index = (dsBanAnMotTang.count)
        var i = 0
        if(index>0){
            for var element in  0...index-1 {
                i += 1
                if(i <= numOfButtonPerRow){
                    
                }else {
                    i = 1
                    xPos = leftMargin
                    yPos = yPos + buttonHeight + spaceBetweenButton
                }
                
                
                let button = UIButton(type: .custom)
                button.titleLabel!.font = UIFont.systemFont(ofSize: 22)
                button.titleLabel!.lineBreakMode = .byTruncatingTail
                button.titleLabel!.textColor = UIColor.black
                button.setTitleColor(UIColor.black, for: UIControlState.normal)
                
                
                //var y:CGFloat  = (CGFloat)(j*90 + topView);
                button.frame.size.height = CGFloat(buttonHeight)
                button.frame.size.width = CGFloat(buttonWidth)
                button.frame.origin.x = CGFloat(xPos)
                button.frame.origin.y = CGFloat(yPos)
                
                if let image = UIImage(named: "BanTrong.png") {
                    button.setBackgroundImage(image, for: .normal)
                }else {
                    button.backgroundColor = UIColor.green
                }
                
                button.setTitle("\( dsBanAnMotTang[element].getSoBan() )", for: UIControlState.normal)
                button.tag = dsBanAnMotTang[element].getSoBan()
                
                arrButton .insert(button, at: element)
                
                
                xPos = xPos + (buttonWidth + spaceBetweenButton)
                
            }
            
            for var element in 0...index-1 {
                
                var button:UIButton = arrButton [element]
                button.addTarget(self, action:#selector(clickButton), for: UIControlEvents.touchUpInside)
                
                self.view .addSubview(button)
            }
        }
        
        
    }
    
    func clickButton(_sender: UIButton){
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "Done");
        alertView.title = "Alert!";
        alertView.message = "Button Pressed!!!";
        alertView.show();
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
