//
//  ViewController.swift
//  LuckySpin
//
//  Created by Hồ Sĩ Tuấn on 8/6/20.
//  Copyright © 2020 Hồ Sĩ Tuấn. All rights reserved.
//

import UIKit
import SpinWheelControl
import SmoothButton
import SwiftMessages

class ViewController: UIViewController, SpinWheelControlDataSource, SpinWheelControlDelegate {
    
    

    @IBOutlet var spinWheelControl: SpinWheelControl!
    let colors = [#colorLiteral(red: 0.9420027733, green: 0.7658308744, blue: 0.136086911, alpha: 1),
                  #colorLiteral(red: 0.9099512696, green: 0.4911828637, blue: 0.1421333849, alpha: 1),
                  #colorLiteral(red: 0.8836082816, green: 0.3054297864, blue: 0.2412178218, alpha: 1),
                  #colorLiteral(red: 0.8722914457, green: 0.1358049214, blue: 0.382327497, alpha: 1),
                  #colorLiteral(red: 0.578535378, green: 0.6434150338, blue: 0.6437515616, alpha: 1),
                  #colorLiteral(red: 0.07094667107, green: 0.6180127263, blue: 0.5455638766, alpha: 1),
                  #colorLiteral(red: 0.1627037525, green: 0.4977462888, blue: 0.7221878171, alpha: 1),
                  #colorLiteral(red: 0.5330474377, green: 0.2909428477, blue: 0.6148440838, alpha: 1),
                  #colorLiteral(red: 0.5619059801, green: 0.2522692084, blue: 0.4293728471, alpha: 1),
                  #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1)]
    var prizes = ["$30", "$10", "$250", "$20", "LOSE", "$5", "$500", "$80", "LOSE", "$200"]
    
    
    @IBAction func pressSpin(_ sender: SmoothButton) {
        self.spinWheelControl.spin()
    }
    
    func wedgeForSliceAtIndex(index: UInt) -> SpinWheelWedge {
        let wedge = SpinWheelWedge()
//        
//        wedge.shape.fillColor = colors[Int(index)].cgColor
//        wedge.label.text = prizes[Int(index)]
        
        return wedge
    }
    
    
    
    
    func numberOfWedgesInSpinWheel(spinWheel: SpinWheelControl) -> UInt {
        return UInt(prizes.count)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)

        spinWheelControl = SpinWheelControl(frame: frame)
        spinWheelControl.addTarget(self, action: #selector(spinWheelDidChangeValue), for: UIControl.Event.valueChanged)
        spinWheelControl.dataSource = self
        spinWheelControl.delegate = self
        spinWheelControl.reloadData()
        
        
    }
    @objc func spinWheelDidChangeValue(sender: AnyObject) {
        var title = "You LOSE! :("
        var iconText = "😭😭"
        if prizes[spinWheelControl.selectedIndex] != "LOSE" {
            title = "You win \(prizes[spinWheelControl.selectedIndex])!!!"
            iconText = "😱😱😱😱"
        }
        let body = "Swiping to dismiss!"
        showMessage(title: title, body: body, iconText: iconText)
        
    }
    
    func showMessage(title: String, body: String, iconText: String) {
        let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
        messageView.configureBackgroundView(width: 250)
        messageView.configureContent(title: title , body: body, iconImage: nil, iconText: iconText, buttonImage: nil, buttonTitle: "Got it") { _ in
            SwiftMessages.hide()
        }
        messageView.backgroundView.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        messageView.backgroundView.layer.cornerRadius = 10
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = .forever
        config.dimMode = .blur(style: .dark, alpha: 1, interactive: true)
        config.presentationContext  = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: config, view: messageView)
    }
    
    
}

