//
//  ViewController.swift
//  todolist개인과제
//
//  Created by t2023-m0088 on 2023/08/28.
//

import UIKit
import SwiftUI
import SnapKit

class ViewController: UIViewController {
    
    
    let goInstaView : UIButton = {
       let view = UIButton()
        view.setImage(UIImage(named: "insta"), for: .normal)
        
        return view
    }()
    
    let image1 : UIImageView = {
        //      imageView의 형태지정을 위한 clouser
        let view = UIImageView()
        view.backgroundColor = .lightGray
        //      배경색은 lightGray로 하겠다.
        view.layer.cornerRadius = 25
        //      모서리 둥글기를 25로 하겠다.
        view.image = UIImage(named: "christ")
        view.clipsToBounds = true
        //      clipsToBounds를 true로 선언함으로써 모서리가 둥글어졌을때만큼 잘리는 모서리 이미지를 같이 둥글게 다듬어준다.

        return view
    }()
    
    let btn1 : UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 25
        view.setTitle("할 일 확인하기", for: .normal)
        view.setTitle("클릭 !", for: .highlighted)
        //       '할 일 확인하기' 버튼을 눌렀을때 '클릭' 이라는 text로 변환된다.
        view.titleLabel?.font = .systemFont(ofSize: 25)
        //        font의 크기를 변환해준다.
        return view
    }()
    let btn2 : UIButton = {
        let view = UIButton()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 25
        view.setTitle("완료한 일 보기", for: .normal)
        view.setTitle("클릭 !", for: .highlighted)
        view.titleLabel?.font = .systemFont(ofSize: 25)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "To Do List"
        //        네비게이션 바 타이틀 설정
        
        configureBtn1()
        configureBtn2()
        configureIimage1()
        setupViews()
        
        btn1.addTarget(self, action: #selector(btn1Click), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(btn2Click), for: .touchUpInside)
        goInstaView.addTarget(self, action: #selector(instaViewClick), for: .touchUpInside)
        
    }
    
    @objc func btn1Click(){
        //      btn1을 클릭했을때의 action을 지정해준다.
            let viewController2 = checkViewController()
        //      checkViewController 창을 변수로 선언
        self.navigationController?.pushViewController(viewController2, animated: true)
        //      push 액션으로 ( 오른쪽에서 왼쪽으로 슬라이드 ) checkViewController(viewController2) 창이 출력되게 하는 코드.
    }
    
    @objc func btn2Click(){
            let viewController3 = successViewController()
        self.navigationController?.pushViewController(viewController3, animated: true)
    }
    
    @objc func instaViewClick(){
        let instaViewController = instaViewController()
        instaViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(instaViewController, animated: true, completion: nil)
    }
    
    func setupViews(){
//        [goInstaView].forEach({ view.addSubview($0) })
        view.addSubview(goInstaView)
        setConstraints()
    }
    
    func setConstraints(){
        goInstaView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(640)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
    }
    
    func configureIimage1() {
        self.view.addSubview(image1)
        image1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            image1.widthAnchor.constraint(equalToConstant: 200),
            image1.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    func configureBtn1() {
        self.view.addSubview(btn1)
        btn1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 25),
            btn1.widthAnchor.constraint(equalToConstant: 200),
            btn1.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
    func configureBtn2() {
        self.view.addSubview(btn2)
        btn2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 125),
            btn2.widthAnchor.constraint(equalToConstant: 200),
            btn2.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
}

#if DEBUG

struct ViewControllerRepresentable: UIViewControllerRepresentable{
    
    //    update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    //    makeui
    
}


struct ViewController_Previews: PreviewProvider{
    static var previews: some View{
        ViewControllerRepresentable()
            .previewDisplayName("아이폰 14")
        
    }
}


#endif
