import UIKit

class ViewController: UIViewController {
    
    private lazy var square: UIView = {
        let square = UIView(frame: CGRect(x: view.center.x-50, y: view.center.y-50, width: 100, height: 100))
        square.backgroundColor = .blue
        
        return square
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(square)
        
    }
    
    @IBAction func animationActionButton(_ sender: Any) {
        //    actionFirst()
        //    actionSecond()
        //    transitionFirst()
        //    anchorPointFirst()
        //    anchorPointSecond()
        //    keyframe()
        //    basicAnimation()
        change()
    }
    
    // animate
    func actionFirst() {
        UIView.animate(withDuration: 2.0) {
            self.square.backgroundColor = .red
            self.square.frame = CGRect(x: self.view.center.x-25, y: (self.view.center.y-25)/2, width: 50, height: 50)
        }
    }
    
    // animate
    func actionSecond() {
        UIView.animate(withDuration: 4.0,
                       delay: 0.0,
                       options: .autoreverse,
                       animations: {
            self.square.backgroundColor = .yellow
            self.square.frame = CGRect(x: self.view.center.x-25, y: (self.view.center.y-25)/2, width: 50, height: 50)},
                       completion: {_ in
            self.square.frame = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
            self.square.backgroundColor = .red
        })
    }
    
    // transition
    func transitionFirst() {
        UIView.transition(with: square, duration: 0.33,
          options: [.curveEaseOut, .transitionFlipFromBottom],
          animations: {
            self.square.removeFromSuperview()
          },
          completion: nil
        )
    }
    
    // change AnchorPoint
    func anchorPointFirst() {
        square.setAnchorPoint(CGPoint(x: 0, y: 0))

        UIView.animate(withDuration: 3) {
            self.square.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    // change AnchorPoint
    func anchorPointSecond() {
        square.setAnchorPoint(CGPoint(x: 1, y: 1))

        UIView.animate(withDuration: 3) {
            self.square.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    // animateKeyframes
    func keyframe() {
        UIView.animateKeyframes(withDuration: 10.0,
                                delay: 0,
                                options: [],
                                animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0,
                               relativeDuration: 0.2,
                               animations: {
                
                self.square.frame = CGRect(x: self.view.center.x+50, y: self.view.center.y-50, width: 100, height: 100)
                self.square.backgroundColor = .yellow
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2,
                               relativeDuration: 0.4,
                               animations: {
                
                self.square.frame = CGRect(x: self.view.center.x+50, y: self.view.center.y+50, width: 100, height: 100)
                self.square.backgroundColor = .red
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4,
                               relativeDuration: 0.6,
                               animations: {
                
                self.square.frame = CGRect(x: self.view.center.x-50, y: self.view.center.y+50, width: 100, height: 100)
                self.square.backgroundColor = .black
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6,
                               relativeDuration: 0.8,
                               animations: {
                
                self.square.frame = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
                self.square.backgroundColor = .purple
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8,
                               relativeDuration: 1,
                               animations: {
                
                self.square.frame = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
                self.square.backgroundColor = .blue
            })
        })
    }
    
    // CABasicAnimation
    func basicAnimation() {
        let timeInterval: CFTimeInterval = 2
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = timeInterval
        rotateAnimation.repeatCount=Float.infinity
        square.layer.add(rotateAnimation, forKey: nil)
    }
    
    // transformation + change anchorPoint + keyframe
    func change() {        
        UIView.animateKeyframes(withDuration: 5.0,
                                delay: 0,
                                options: [],
                                animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0,
                               relativeDuration: 0.5,
                               animations: {
                
                let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
                rotateAnimation.fromValue = 0.0
                rotateAnimation.toValue = CGFloat(Double.pi * 2)
                rotateAnimation.isRemovedOnCompletion = false
                rotateAnimation.repeatCount=Float.infinity
                self.square.layer.add(rotateAnimation, forKey: nil)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5,
                               relativeDuration: 1.0,
                               animations: {
                
                self.square.setAnchorPoint(CGPoint(x: 0, y: 0))
                let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
                rotateAnimation.fromValue = 0.0
                rotateAnimation.toValue = CGFloat(Double.pi * 2)
                rotateAnimation.isRemovedOnCompletion = false
                rotateAnimation.repeatCount=Float.infinity
                self.square.layer.add(rotateAnimation, forKey: nil)
            })
        })
    }

}

extension UIView {
    
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        /* this is for change position for spend object only change position and anchorPoint without this code change anchorPoint but position no
         
        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
         */
        layer.anchorPoint = point
    }
    
}

