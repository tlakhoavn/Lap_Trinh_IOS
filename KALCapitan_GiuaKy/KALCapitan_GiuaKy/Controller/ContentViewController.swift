//
//  ContentViewController.swift
//  KALCapitan_GiuaKy
//
//  Created by AnhKhoa on 4/25/17.
//  Copyright © 2017 AnhKhoa. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    class cThongTinBanAn{
        var maBan: Int
        
        init(){
            self.maBan = 0
        }
        
    }
    //MARK: *** Declare variables
    
    @IBOutlet weak var viewPhongAn: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var imageView: UIImageView!
    
    
    var pageIndex:Int!
    var titlesText: String!
    var imagesFile: String!
    
    var danhsachBanAn = [cThongTinBanAn](repeating: cThongTinBanAn(), count: 12)

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let index = (danhsachBanAn.count)
        var topView = Int(self.view.frame.minY) + 65
        
        
        print("MinY \(self.view.frame.minY)")
        print("MaxY \(self.view.frame.maxY)")
        print("MinX \(self.view.frame.minX)")
        print("MaxX \(self.view.frame.maxX)")
        print("width \(self.view.frame.size.width)")
        print("height \(self.view.frame.size.height)")
        
        //Khai bao canh chinh le tu dong
        let leftMargin:Float = 25.0
        let rightMargin:Float = 25.0
        let topMargin:Float = 65.0
        let bottoMargin:Float = 10.0
        let viewWidth = Float(self.view.frame.size.width)
        let viewHeight = Float(self.view.frame.size.height)
        let buttonWidth:Float = 75.0
        let buttonHeight:Float = 75.0
        let spaceBetweenButton:Float = 40.0    //Khoang cach giua 2 ban an
        
        
        var xPos = leftMargin + 0
        var yPos = topMargin + 0
        
        var i:Float = 0
        
        for var element in  0...index-1 {
            
            
            if(xPos + buttonWidth > viewWidth - rightMargin){
                xPos = leftMargin
                yPos = yPos + buttonHeight + spaceBetweenButton
            }
            
            let button = UIButton(type: .custom)
            button.titleLabel!.font = UIFont.systemFont(ofSize: 18)
            button.titleLabel!.lineBreakMode = .byTruncatingTail
            
            
            //var y:CGFloat  = (CGFloat)(j*90 + topView);
            button.frame.size.height = CGFloat(buttonHeight)
            button.frame.size.width = CGFloat(buttonWidth)
            button.frame.origin.x = CGFloat(xPos)
            button.frame.origin.y = CGFloat(yPos)
            
            if let image = UIImage(named: "BanTrong.png") {
                button.setImage(image, for: .normal)
            }else {
                button.backgroundColor = UIColor.green
            }
            
            button.setTitle("\(element+1)", for: UIControlState.normal)
            button.tag = element
            
            arrButton .insert(button, at: element)
            
            
            xPos = xPos + (buttonWidth + spaceBetweenButton)

        }
        
        for var element in 0...index-1 {
            
            var button:UIButton = arrButton [element]
            button.addTarget(self, action:#selector(clickButton), for: UIControlEvents.touchUpInside)
            
            self.view .addSubview(button)
        }
        
    }
    
    func clickButton(_sender: UIButton){
        var alertView = UIAlertView();
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
