////
////  UserInfoViewModel.swift
////  todolistreal1
////
////  Created by t2023-m0088 on 2023/09/18.
////
//
import Foundation

protocol UserViewModelDelegate: AnyObject {
    func updateUserName(name: String)
    func updateUserAge(name: Int)
}

class UserViewModel{
    private var user: User
    weak var delegate: UserViewModelDelegate?
    
    init(user: User) {
        self.user = user
    }
    
    lazy var userName: String = user.name{
        didSet {
            delegate?.updateUserName(name: userName)
        }
    }
    lazy var userAge: Int = user.age{
        didSet {
            delegate?.updateUserAge(name: userAge)
        }
    }
}

//
//class UserViewModel{
//    let user: User
//
//    init(user: User) {
//        self.user = user
//    }
//
//
//    var name: String{
//        return user.username
//    }
//
//    var post: String{
//        return user.post
//    }
//
//    var follwer: String{
//        return user.follower
//    }
//
//    var follwing: String{
//        return user.following
//    }
//    
//    var follwerAll: String{
//        switch user.follower{
//        case .sparta:
//            return "84"
//        case .kiho:
//            return "67"
//        case .pomeranian:
//            return "91"
//        case .poodle:
//            return "32"
//        }
//    }
//}
//
//extension UserViewModel {
//    func configure(_ view: InstaVIew) {
//        view.nameLabel.text = name
//        view.imageName = imageName
//    }
//}
