//
//  PieView.swift
//  ChartsPractice
//
//  Created by Tiana  on 23/10/2020.
//

import UIKit

struct Slice{
    var percent: CGFloat
    var color: UIColor
}

class PieView: UIView {
    
    
    static let ANIMATION_DURATION: CGFloat = 1.4

    var slices: [Slice]?
    var sliceIndex: Int = 0
    var currentPercent: CGFloat =  0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func getDuration(_ slice: Slice) -> CFTimeInterval {
        return CFTimeInterval(slice.percent / 1.0 * PieView.ANIMATION_DURATION)
    }
    
    func percentToRadian(_ percent: CGFloat) -> CGFloat {
            //Because angle starts wtih X positive axis, add 270 degrees to rotate it to Y positive axis.
            var angle = 270 + percent * 360
            if angle >= 360 {
                angle -= 360
            }
            return angle * CGFloat.pi / 180.0
        }
    
    func addSlice(_ slice: Slice) {
           let animation = CABasicAnimation(keyPath: "strokeEnd")
           animation.fromValue = 0
           animation.toValue = 1
           animation.duration = getDuration(slice)
           animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
           animation.delegate = self
           
           let canvasWidth = self.frame.width
        let centerPoint = CGPoint(x: canvasWidth / 2, y: self.frame.height / 2)
           let path = UIBezierPath(arcCenter: centerPoint,
                                   radius: canvasWidth * 3 / 8,
                                   startAngle: percentToRadian(currentPercent),
                                   endAngle: percentToRadian(currentPercent + slice.percent),
                                   clockwise: true)
           
           let sliceLayer = CAShapeLayer()
           sliceLayer.path = path.cgPath
           sliceLayer.fillColor = nil
           sliceLayer.strokeColor = slice.color.cgColor
           sliceLayer.lineWidth = canvasWidth * 2 / 8
           sliceLayer.strokeEnd = 1
           sliceLayer.add(animation, forKey: animation.keyPath)
           
           self.layer.addSublayer(sliceLayer)
       }
    /// Call this to start pie chart animation.
        func animateChart() {
            sliceIndex = 0
            currentPercent = 0.0
            self.layer.sublayers = nil
            
            if slices != nil && slices!.count > 0 {
                let firstSlice = slices![0]
                addSlice(firstSlice)
            }
        }
    
}


extension PieView: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            currentPercent += slices![sliceIndex].percent
            sliceIndex += 1
            if sliceIndex < slices!.count {
                let nextSlice = slices![sliceIndex]
                addSlice(nextSlice)
            }
        }
    }
}
