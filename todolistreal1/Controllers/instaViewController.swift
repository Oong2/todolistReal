//
//  instaViewController.swift
//  todolistreal1
//
//  Created by t2023-m0088 on 2023/09/18.
//

import UIKit
import SwiftUI
import SnapKit
import CoreData

class instaViewController: UIViewController {
    
    var task: Task2?
    
    var container: NSPersistentContainer!
    
    var arrImageName:[String] = ["picture","picture 1","picture 2","picture 3","picture 4","picture 5","picture 6",]
    
//    let cellMarginSize: CGFloat = 10.0
//    static let identifier = "instaViewController"
//
//    private let collectionV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let reutan = "르탄이"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.InstaCollectView.reloadData()
    }
    
    let Username : UILabel = {
        let view = UILabel()
        view.text = "nabaecamp"
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        return view
    }()
    let dismissBtn : UIButton = {
        let view = UIButton()
        view.setTitle("<", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    let Menu : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "burger")
        return view
    }()
    let UserImage : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "profile")
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    let PostText : UILabel = {
        let view = UILabel()
        view.text = "7"
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 18)
        return view
    }()
    let PostText2 : UILabel = {
        let view = UILabel()
        view.text = "post"
        view.textAlignment = .center
        return view
    }()
    let FollwerText : UILabel = {
        let view = UILabel()
        view.text = "89"
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 18)
        return view
    }()
    let FollwerText2 : UILabel = {
        let view = UILabel()
        view.text = "follower"
        view.textAlignment = .center
        return view
    }()
    let FollwingText : UILabel = {
        let view = UILabel()
        view.text = "23"
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 18)
        return view
    }()
    let FollwingText2 : UILabel = {
        let view = UILabel()
        view.text = "following"
        view.textAlignment = .center
        return view
    }()
    let profileText : UILabel = {
        let view = UILabel()
        view.text = """
르탄이
iOS Developer🍎
spartacodingclub.kr
"""
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    lazy var middleBar : UIStackView = {
       let view = UIStackView(arrangedSubviews: [FollowBtn, MessageBtn])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    let FollowBtn : UIButton = {
        let view = UIButton()
        view.setTitle("이름 수정", for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        return view
    }()
    let MessageBtn : UIButton = {
        let view = UIButton()
        view.setTitle("Message", for: .normal)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.layer.cornerRadius = 5
        return view
    }()
    let MoreBtn : UIButton = {
        let view = UIButton()
        view.setTitle("▼", for: .normal)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.layer.cornerRadius = 5
        return view
    }()
    lazy var middleGalleryBar : UIStackView = {
       let view = UIStackView(arrangedSubviews: [GalleryBtn, midBtn, lastBtn])
        view.axis = .horizontal
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .fillEqually
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    let GalleryBtn : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "grid"), for: .normal)
        return view
    }()
    let midBtn : UIButton = {
        let view = UIButton()
        view.setTitle("", for: .normal)
        return view
    }()
    let lastBtn : UIButton = {
        let view = UIButton()
        view.setTitle("", for: .normal)
        return view
    }()
    let InstaCollectView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        view.register(UICollectionView.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        return view
    }()
    
//    private let collectionV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViewAll()
        view.backgroundColor = .white
        
        Username.text = task?.title
        
        
        FollowBtn.addTarget(self, action: #selector(followBtnClick), for: .touchUpInside)
        dismissBtn.addTarget(self, action: #selector(dismissBtnClick), for: .touchUpInside)
        self.InstaCollectView.dataSource = self
        self.InstaCollectView.delegate = self
        self.InstaCollectView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
            
        
        
        
//        let userViewModel = UserViewModel()
//        userViewModel.configure(instaView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let task,
              let id = task.id,
              let tasktitle = Username.text else { return }
        
        Task2DataManager.shared.modifyTaskData(id: id, title: tasktitle, isCompleted: true)
    }
    
    @objc func followBtnClick(){
        let alertController = UIAlertController(title: "이름 수정", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "수정 내용을 입력하세요"
        }
        let addAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            guard let self else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                self.Username.text = title
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func dismissBtnClick(){
        self.dismiss(animated: true)
    }

    func addSubViewAll(){
        [Username,dismissBtn,Menu,UserImage,PostText,PostText2,FollwerText,FollwerText2,FollwingText,FollwingText2,profileText,middleBar,MoreBtn,middleGalleryBar,InstaCollectView].forEach{ view?.addSubview($0)}
        configureUsername()
        configuredismissBtn()
        configureMenu()
        configureUserImage()
        configurePostText()
        configurePostText2()
        configureFollwerText()
        configureFollwerText2()
        configureFollwingText()
        configureFollwingText2()
        configureProfileText()
        configureMiddleBar()
        configureMoreBtn()
        configureMiddleGalleryBar()
        configureInstaCollectView()
    }

    func configureUsername(){
        Username.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    func configuredismissBtn(){
        dismissBtn.snp.makeConstraints { make in
            make.centerY.equalTo(Username).offset(0)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    func configureMenu(){
        Menu.snp.makeConstraints { make in
            make.centerY.equalTo(Username).offset(0)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    func configureUserImage(){
        UserImage.snp.makeConstraints { make in
            make.top.equalTo(Username.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    func configurePostText(){
        PostText.snp.makeConstraints { make in
            make.centerY.equalTo(UserImage).offset(-13)
            make.leading.equalTo(UserImage.snp.trailing).offset(34)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
    }
    func configurePostText2(){
        PostText2.snp.makeConstraints { make in
            make.centerX.equalTo(PostText).offset(0)
            make.centerY.equalTo(UserImage).offset(13)
            make.top.equalTo(PostText.snp.bottom).offset(0)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
    func configureFollwerText(){
        FollwerText.snp.makeConstraints { make in
            make.centerY.equalTo(UserImage).offset(-13)
            make.leading.equalTo(PostText.snp.trailing).offset(36)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
    }
    func configureFollwerText2(){
        FollwerText2.snp.makeConstraints { make in
            make.centerX.equalTo(FollwerText).offset(1)
            make.centerY.equalTo(UserImage).offset(13)
            make.top.equalTo(FollwerText.snp.bottom).offset(0)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }
    func configureFollwingText(){
        FollwingText.snp.makeConstraints { make in
            make.centerY.equalTo(UserImage).offset(-13)
            make.trailing.equalTo(Menu.snp.trailing).offset(-28)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
    }
    func configureFollwingText2(){
        FollwingText2.snp.makeConstraints { make in
            make.centerX.equalTo(FollwingText).offset(0)
            make.centerY.equalTo(UserImage).offset(13)
            make.top.equalTo(FollwingText.snp.bottom).offset(0)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }
    func configureProfileText(){
        profileText.snp.makeConstraints { make in
            make.top.equalTo(UserImage.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(100)
        }
    }
    func configureMiddleBar(){
        middleBar.snp.makeConstraints { make in
            make.top.equalTo(profileText.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-65)
            make.height.equalTo(36)
        }
    }
    func configureMoreBtn(){
        MoreBtn.snp.makeConstraints { make in
            make.top.equalTo(profileText.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
    }
    func configureMiddleGalleryBar(){
        middleGalleryBar.snp.makeConstraints { make in
            make.top.equalTo(middleBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(60)
        }
    }
    func configureInstaCollectView(){
        InstaCollectView.snp.makeConstraints { make in
            make.top.equalTo(middleGalleryBar.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }

}

extension instaViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageName.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell

        cell.ImageVIew.image = UIImage(named: arrImageName[indexPath.row]) ?? UIImage()
//        cell.setTask(Task2DataManager.shared.getCompletedTask2(ascending: true)[indexPath.row])
        return cell
    }


}
extension instaViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout colletionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interval: CGFloat = 3
        let width: CGFloat = (UIScreen.main.bounds.width - interval * 2) / 3
        
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}



#if DEBUG

struct ViewControllerRepresentable1: UIViewControllerRepresentable{
    
    //    update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    //    makeui
    
}


struct ViewController_Previews1: PreviewProvider{
    static var previews: some View{
        ViewControllerRepresentable()
            .previewDisplayName("아이폰 14")
        
    }
}


#endif
