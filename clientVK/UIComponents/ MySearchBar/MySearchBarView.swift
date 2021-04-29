//
//  MySearchBarView.swift
//  clientVK
//
//  Created by Natalia on 28.04.2021.
//

import UIKit

protocol MySearchBarViewDelegate: class {
    func cancelPressed()
    func textDidChange(text: String)
    
}

class MySearchBarView: UIView, UITextFieldDelegate {
    
    weak var delegate: MySearchBarViewDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        endSearchAnimate()
        delegate?.cancelPressed()
    }
    
    @IBOutlet weak var cancelButtom: UIButton!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet var leftIconConstraint: NSLayoutConstraint!
    @IBOutlet var centerIconConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        config()
    }
    
    private func config() {
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.borderStyle = .none
    }
    
    private func loadNib() {
        
        let nib = UINib(nibName: "MySearchBarView", bundle: nil)
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if cancelButtom.frame.contains(point) {
            return cancelButtom
        }
        return self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startSearchAnimate()
    }

    func startSearchAnimate() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseIn) {
            self.cancelConstraint.constant = 4
            self.layoutIfNeeded()
        } completion: { _ in
            
        }
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .curveEaseIn) {
            self.leftIconConstraint.isActive = true
            self.centerIconConstraint.isActive = false
            self.layoutIfNeeded()
        } completion: { _ in
            
            let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.searchImageView.bounds.width + 10, height: self.textField.bounds.height))
            self.textField.leftView = leftView
            self.textField.leftViewMode = .always
            self.textField.becomeFirstResponder()
        }
    }
    
    func endSearchAnimate() {
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseIn) {
            self.cancelConstraint.constant = -67
            self.layoutIfNeeded()
        } completion: { _ in
            
        }
        
        self.textField.leftView = nil
        self.textField.leftViewMode = .always
        self.textField.resignFirstResponder()
        self.textField.text = nil
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .curveEaseIn) {
            self.leftIconConstraint.isActive = false
            self.centerIconConstraint.isActive = true
            self.layoutIfNeeded()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty, var text = textField.text, text.count > 0 {
            text.removeLast()
            delegate?.textDidChange(text: text)
            return true
        }
        let text = (textField.text ?? "") + string
        delegate?.textDidChange(text: text)
        return true
    }
}
