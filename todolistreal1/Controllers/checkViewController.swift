//
//  checkViewController.swift
//  todolistreal1
//
//  Created by t2023-m0088 on 2023/08/28.
//

import UIKit

class tableViewCell1: UITableViewCell{
    static let reuseIdentifier = "Cell"
}

class checkViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 메서드 정의 : 셀을 선택하였을 때 어떤 셀이 선택되었는지 알려주는 메서드 : didSelectRowAt

        // tasks 배열 요소에 접근해서, done이 true이면 false가 되게 만들어주고, false면 true 가 되게 만들어줄 것.
        var task = self.tasks[indexPath.row]
        task.done = !task.done   // bool값이 반대가 되게해줌
        self.tasks[indexPath.row] = task   // 눌린 위치에서 작동해라
        self.tableView.reloadRows(at: [indexPath], with: .automatic) // 눌렸을때 체크표시활성화를위허 다시 reload하는 코드
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           self.tasks.remove(at: indexPath.row) // remove cell 알려주는 것.
           tableView.deleteRows(at: [indexPath], with: .automatic) //automatic에니메이션을 설정하게 되면, 삭제버튼을 눌러서 삭제도 가능하고, 우리가 평소에 사용하던 스와이프해서 삭제하는 기능도 사용 가능하다.
           if self.tasks.isEmpty { //모든셀이 삭제되면
               self.doneButtonTap() // done버튼 메서드를 호출해서 편집모드를 빠져나오게 구현.
           }
       }
    
    var tasks = [Task](){
        didSet {
//            didSet의 역할은 프로퍼티의 값이 변경된 직후를 감지하여 호출하는것이다.
//            즉 , self.saveTasks를 통해 저장되는 값이 감지되면 바로 호출된다.
            self.saveTasks()
        }
    }
    
    
    let tableView : UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
//            insetGrouped로 tableView의 style을 더 디자인적이게 수정해주었다.
        view.backgroundColor = .lightGray

        
        return view
    }()
    let tableViewCell : UITableViewCell = {
        let view = UITableViewCell()
        view.backgroundColor = .red
        
        return view
    }()
    let addBtn1 : UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("+", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 30)
        
        return view
    }()
    let editButton : UIBarButtonItem = {
        let view = UIBarButtonItem()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //        할일 확인하기 창의 뒷배경색깔
        configureTable()
        //        tableView의 위치, 크기 등 constraint값을 저장해둔 함수 호출
        configureBtn()
        //        addBtn1의 위치, 크기 등 constraint값을 저장해둔 함수 호출
        configureTableCell()
        //        tableViewCell의 위치, 크기 등 constraint값을 저장해둔 함수 호출
        tableView.delegate = self
        tableView.dataSource = self
        //        위의 두 코드가 실행됨으로써 UITableView를 다룰 수 있는 여러 method들을 사용 할 수 있다.
        addBtn1.addTarget(self, action: #selector(add1Click), for: .touchUpInside)
        //        추가하기 버튼을 눌렀을때 , add1Click 이라는 액션을 실행하도록 정의해준다.
        self.loadTasks()
        //        메인화면에 userDefaults로 저장되었던 메모들을 불러와주는 코드
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //        tableView에는 identifier가 지정되어있지 않았기때문에 , Cell이라는 이름으로 지정해주는 코드
        //        identifier를 지정해줌으로써 identifier로 접근하려는 코드들의 접근을 허용해준다.
    }
    
    @objc func doneButtonTap(){
        self.navigationItem.leftBarButtonItem = self.editButton
        //        네비게이션 바 왼쪽에 버튼을 생성해준다. ( 미구현 )
        self.tableView.setEditing(false, animated: true)
    }
    //
    @objc func add1Click(){
        
        let alert = UIAlertController(title: "할 일 추가하기", message: "할 일을 작성해주세요", preferredStyle: .alert)
        //        alert창을 만들 수 있게 변수선언을 해주는 코드. title은 alert창 제목, message는 내용인셈.
        let registerButton = UIAlertAction(title: "등록", style: .default , handler: {[weak self] _ in guard let title = alert.textFields?[0].text else { return }
            //       alert의 '등록' 버튼 형식을 정의한다. ( 추가 이해 필요 코드 )
            let task = Task(title: title, done: false)
            //       Task 라는 struct ( 저장소 ) 에다가 done ( 체크표시 ) 이 false ( 체크해제 ) 된 상태로 추가를위한 코드.
            //       title은 위에서 정의 해준대로 textField에 입력된 값을 지칭한다.
            self?.tasks.append(task)
            //            등록 버튼을 눌렀을때 텍스트필드에 있는 값을 tasks 에 추가해준다.
            self?.tableView.reloadData()
            //            추가한 내용을 즉시 직관적으로 확인하기위하여 추가와 동시에 새로고침을 한번 해준다.
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel , handler: nil)
        //     알러트에 액션을 추가할거야. 이름은 취소버튼이고 취소(cancel)값으로 둘거야.
        self.present(alert, animated: true, completion: nil)
        //     present = view위에 view가 쌓이는 구조로 불러와주는 스타일의 코드. UIVIewController에서 사용가능하다.
        alert.addAction(registerButton)
        //     아까 정의해주었던 등록버튼을 alert에 추가해준다.
        alert.addAction(cancelButton)
        //     아까 정의해주었던 취소버튼을 alert에 추가해준다.
        alert.addTextField(configurationHandler: { TextField in TextField.placeholder = "할 일을 입력해주세요."})
        //     alert에 없었던 textField창을 생성해주며 그 안의 안내문구를 등록해준다.

    }
    
    func configureTable(){
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func configureTableCell(){
        self.tableView.addSubview(tableViewCell)
        //        tableView.register(UINib(nibName: "tableViewCell",bundle: nil), forCellReuseIdentifier: "Cell")
        tableViewCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewCell.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor),
            tableViewCell.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            tableViewCell.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableViewCell.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func configureBtn(){
        self.view.addSubview(addBtn1)
        addBtn1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addBtn1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            addBtn1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            addBtn1.widthAnchor.constraint(equalToConstant: 50),
            addBtn1.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //      numberOfROwsInSection = tableViewCell의 갯수를 몇개로 할까요? 와 같은맥락으로 , '행' 의 갯수를 정의한다.
        if section == 0 {

        } else if section == 1 {
        } else {
        }
        return tasks.count
        //      행의 갯수를 내가 추가한 갯수만큼 ( tasks의 갯수 ) 만들겠다는 의미.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //      행에 어떤내용을 출력할지를 정의해주는 공간. 데이터 소스를 정의할 수 있다.
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
//        if indexPath.section == 0 {
//        cell = 2
//        } else if indexPath.section == 1 {
//            cell = 5
//        } else {
//            cell = 1
//        }
        
        let task = self.tasks[indexPath.row]
        //          ( 개념 이해 부족 )
        cell.textLabel?.text = task.title
        //          ( 개념 이해 부족 )
        if task.done{
            //      만약 task가 done ( 할일 완료 ) 되면
            cell.accessoryType = .checkmark
            //      checkmark를 추가해준다.
        } else{
            cell.accessoryType = .none
            //      아니라면 그냥 둬
        }
        return cell
    }
    
    func saveTasks() {
        //     tasks에 저장값을 추가하기 위한 저장소.
        let data = self.tasks.map {
            [
                "title": $0.title,
                "done": $0.done
            ] as [String : Any]
        }
        //     ( 개념 이해 부족 )
        let userDefaults = UserDefaults.standard
        //     userDefaults로써 기기에 저장을 하겠다는걸 정의 하기위한 변수선언. ( 의도 : 코드의 간략화 )
        userDefaults.set(data, forKey: "tasks")
        //     userDefaults로써 기기에 저장을 하겠다는걸 선언 하는 코드. 키값은 'tasks' 로 지정하며 역할은 비밀번호 개념이다.
        
    }
    //        저장하는 코드가 없음 ( userdefaults 에 추가되어야 함 )
    //        디코딩 > 인코딩 되는 방법으로 저장해야 함
    
    func loadTasks(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        //        todolist에 추가한 메모값을 저장시키는 역할. UserDefaults.standard를 변수화 하여 key를 지정해주고,
        //        메모에 입력되는값이 모든타입이기때문에 Any로 선언해준다.
        self.tasks = data.compactMap{
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
            //      ( 추가 이해 필요 )
        }
    }
    
//        func numberOfSections(in tableView: UITableView) -> Int {
//            //      section의 갯수를 정의해준다. 즉 header와 tableViewCell을 하나로보고 몇개를 추가할지 정의하는셈.
//            return 1
//        }

        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            //     Section Header에 나타날 글자를 정하는 코드
            return "\(section)"
            //     section의 순서만큼을 표시해라. ex) 1번째 section = 0 , 2번째 section = 1 '''.
        }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
}
