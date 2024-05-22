//
//  Common.swift
//
//  Created by mac on 16/06/20.
//  Copyright © 2020 Subhash. All rights reserved.
//

import UIKit

extension UIViewController {
    
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
    
    func toastMessage(_ message: String){
    guard let window = UIApplication.shared.keyWindow else {return}
    let messageLbl = UILabel()
    messageLbl.text = message
    messageLbl.textAlignment = .center
    messageLbl.font = UIFont.systemFont(ofSize: 12)
    messageLbl.textColor = .white
    messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)

    let textSize:CGSize = messageLbl.intrinsicContentSize
    let labelWidth = min(textSize.width, window.frame.width - 40)

    messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 50, height: textSize.height + 20)
    messageLbl.center.x = window.center.x
    messageLbl.layer.cornerRadius = messageLbl.frame.height/2
    messageLbl.layer.masksToBounds = true
    window.addSubview(messageLbl)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

    UIView.animate(withDuration: 1, animations: {
        messageLbl.alpha = 0
    }) { (_) in
        messageLbl.removeFromSuperview()
      }
     }
  }
}

extension UIButton {
    
    func setBorder(borderColor : CGColor, cornerRadius : CGFloat){
            layer.borderWidth = 1
            layer.borderColor = borderColor
            layer.cornerRadius = cornerRadius
        }
    
    func Shadow (){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
        
    }

     }

extension UIImageView {
    func makeRounded(borderClr:CGColor,borderWidth:CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderClr
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    func cornerImg(cornerRadius:CGFloat,borderClr:CGColor){
           layer.masksToBounds = false
           layer.cornerRadius = cornerRadius
           layer.borderWidth = 1
           layer.borderColor = borderClr
          self.clipsToBounds = true
       }
}

extension UIView {
func Rounded() {

    self.layer.borderWidth = 1
    self.layer.masksToBounds = false
    self.layer.borderColor = UIColor.clear.cgColor
    self.layer.cornerRadius = self.frame.height / 2
    self.clipsToBounds = true
    }
    
    func cornerRadius(cornerRadius:CGFloat,borderClr:CGColor){
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 0.5
        layer.borderColor = borderClr
    }
    
}

class Shadow : UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
    }
}


class CornerView : UIView{
    override init(frame: CGRect) {
          super.init(frame: frame)
          layer.cornerRadius = 10
        layer.borderColor = UIColor.white.cgColor
          self.layer.borderWidth = 1
          clipsToBounds = true
}
    required init?(coder: NSCoder) {
    super.init(coder: coder)
    layer.cornerRadius = 10
    layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 1
    clipsToBounds = true
  }
}

class CornerVwGray : UIView{
    override init(frame: CGRect) {
          super.init(frame: frame)
          layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
          self.layer.borderWidth = 1
          clipsToBounds = true
}
    required init?(coder: NSCoder) {
    super.init(coder: coder)
    layer.cornerRadius = 10
    layer.borderColor = UIColor.lightGray.cgColor
    self.layer.borderWidth = 1
    clipsToBounds = true
  }
}

class CornerVwBrown : UIView{
    override init(frame: CGRect) {
          super.init(frame: frame)
          layer.cornerRadius = 10
        //layer.borderColor = Color.BackgroundColor.cgColor
        layer.borderColor = backgroundColor?.cgColor
          self.layer.borderWidth = 1
          clipsToBounds = true
}
    required init?(coder: NSCoder) {
    super.init(coder: coder)
    layer.cornerRadius = 10
       // layer.borderColor = Color.BackgroundColor.cgColor
        layer.borderColor = backgroundColor?.cgColor
    self.layer.borderWidth = 1
    clipsToBounds = true
  }
}

extension UITableView {
    
    func setEmptyVieww(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1, animations: {
            
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finishh) in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restoreee() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        
    }
    
}
