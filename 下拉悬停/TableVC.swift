//
//  TableVC.swift
//  下拉悬停
//
//  Created by 徐开源 on 16/3/25.
//  Copyright © 2016年 徐开源. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {

    var timer: NSTimer!
    
    var number: Int = 0
    let numberLabel_top = MyLabel()
    let numberLabel_bottom = MyLabel()
    let labelHeight: CGFloat = 50
    
     // 是否应该悬停 TableView 的标记
    var holding_top: Bool = false
    var holding_bottom: Bool = false
    
    enum direction {
        case top
        case bottom
    }
    
    
    
    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel_top.frame =  CGRectMake(0, 64, view.frame.width, labelHeight)
        numberLabel_bottom.frame =  CGRectMake(0, view.frame.height - labelHeight, view.frame.width, labelHeight)
        navigationController!.view.addSubview(numberLabel_top)
        navigationController!.view.addSubview(numberLabel_bottom)
        
        view.backgroundColor = UIColor.purpleColor()
    }
    
    
    
    // MARK: - Scroll 监听
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let topSpace = 64+labelHeight
        let bottomSpace = 213+labelHeight
        
        if y < -topSpace {
            if holding_top == false { // 条件判断，避免多次执行
                tableView.contentInset.top = topSpace
                addTimer(.top)
            }
        }
        
        if y > bottomSpace {
            if holding_bottom == false { // 条件判断，避免多次执行
                tableView.contentInset.bottom = labelHeight
                addTimer(.bottom)
            }
        }
    }
    
    
    
    // MARK: - 定时器
    func addTimer(dir:direction) {
        // 定时器
        timer = NSTimer.scheduledTimerWithTimeInterval(
            0.1,
            target: self,
            selector: #selector(update), userInfo: nil, repeats: true)
        [NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)]
        
        // 标记 - 现在应该悬停 TableView
        if dir == .top {
            holding_top = true
        }else if dir == .bottom {
            holding_bottom = true
        }
    }
    
    func update() {
        if number < 10 { // 数字增长动画
            
            number+=1
            if holding_top {
                numberLabel_top.text = String(number)
            }
            if holding_bottom {
                numberLabel_bottom.text = String(number)
            }
            
        }else { // 动画完成后，释放 TableView
            
            // 数据归位
            number = 0
            // 【动画】
            if holding_top || holding_bottom {
                UIView.animateWithDuration(1, animations: {
                    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
                })
            }
            // 停止循环
            timer.invalidate()
            // 可以开始下次循环
            holding_top = false
            holding_bottom = false
        }
    }
    
    
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
}
