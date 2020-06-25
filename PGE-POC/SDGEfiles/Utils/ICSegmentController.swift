//
//  ICSegmentController.swift
//  SDGE Near Miss
//
//  Created by Ujwal K Raikar on 10/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import UIKit

class ICSegmentController: UIView {

    let segmentController: UISegmentedControl! = UISegmentedControl(items: ["Yes","No"])
    var onChangeHandler: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        segmentController.tintColor = Application_SKYBlue_Color
        self.segmentController.addTarget(self, action: #selector(onSegmentSelected(_:)), for: .valueChanged)
        self.addSubview(segmentController)
        segmentController.center = self.center
    }
    
    @objc
    func onSegmentSelected(_ sender: UISegmentedControl) {
        onChangeHandler?(sender.selectedSegmentIndex)
    }
}
