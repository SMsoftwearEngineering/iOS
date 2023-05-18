//
//  BaseViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    // MARK: Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    // MARK: Combine Property
    
    var cancellableBag = Set<AnyCancellable>()
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setHierarchy()
        setLayout()
        setBinding()
        navigation()
    }
    
    // MARK: - Override Methods
    
    func setAttributes() { self.view.backgroundColor = .white}     // 속성 설정
    func setHierarchy() {}      // 계층 설정
    func setLayout() {}         // 레이아웃 설정
    func setBinding() {} // 데이터 바인딩
    func navigation() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .black

        let backImage = UIImage(named: "arrow")?.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -6.0, bottom: 0.0, right: 0.0))

        navigationBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .SMPurple
        navigationController?.view.backgroundColor = .white              /// Navagation 배경 색상을 지정
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
