//
//  RestaurantCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/10/8.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var images:[String] = []
    
    var restname:[String] = []
    
    var resttype:[String] = []
    
    var index : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "RestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //加載數據
    func reloadData(title:String,images:[String],name:[String],type:[String]){
        //設置標題
        self.title.text = title
        //保存圖片數據
        self.images = images
        
        self.restname = name
        
        self.resttype = type
        
        //collectionView重新加載數據
        self.collectionView.reloadData()
        //更新collectionView高度約束
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        collectionViewHeight.constant = contentSize.height
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! RestCollectionViewCell
        
        cell.FoodImage.image = UIImage(named: images[indexPath.item])
        
        cell.name.text = restname[indexPath.row]
        
        cell.type.text = resttype[indexPath.row]
        
        cell.selectedBackgroundView = .none
        
        return cell
    }
   
    //點擊事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        firstViewController()?.performSegue(withIdentifier: "restinfo", sender: nil)
    }
    
    override func draw(_ rect: CGRect) {
        //線寬
        let lineWidth = 1 / UIScreen.main.scale

        //線偏移量
        let lineAdjustoffset = 1 / UIScreen.main.scale / 2

        //線條顏色
        let lineColor = UIColor(red: 0xe0/255, green: 0xe0/255, blue: 0xe0/255, alpha: 1)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        //創建一個矩形，它的所有邊都内缩固定的偏移量
        let drawingRect = self.bounds.insetBy(dx: lineAdjustoffset, dy: lineAdjustoffset)

        //創建并設置路徑
        let path = CGMutablePath()
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: drawingRect.maxX, y: drawingRect.maxY))

        //添加路徑到圖形上下文
        context.addPath(path)

        //設置筆觸颜色
        context.setStrokeColor(lineColor.cgColor)
        //設置筆觸宽度
        context.setLineWidth(lineWidth)

        //繪製路徑
        context.strokePath()
    }
}

//找出view所在的controller
extension UIView{
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview}) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}

