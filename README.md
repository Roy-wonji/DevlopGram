## ⛺️개발그램(출시 예정)

### 목차
- [프로젝트](#projects)
- [UML](#uml)
- [실행 화면](#실행-화면)
- [키워드](#키워드)
- [구현 내용](#구현내용)
    - [고민했던점 && 로직구현](#고민했던점--로직구현)
- [배운개념](#배운개념)


### 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.0-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-13.0-blue)]()

### Projects
### 개발자를 위한 인스타그램 프로젝트  
🗓 프로젝트 소개 :개발자를 위한 인스타그램 프로젝트 !</br>
🗓 기간 : 2022.04.26 ~   </br>
🗓 팀원: [로이](https://github.com/Roy-wonji)



### UML


</br>

### 실행 화면


</br>

### 키워드 
 - `코드베이스UI`
 - `UICOLLECTIONVIEW`
 - `UINAVIGATION`
 - `비동기 , 동기`
 - `UINAVIGATION`
 - `MVVM 디자인 패턴 `
 - `Firebase 로그인 `
 - `Firebase 사용방법 `
 - `Firebase 로그인한 유저의 정보 저장 `
 - `custom button , textfield`
 - `확장자로 빼서 레이아웃 `
 - `GCD`
     - `DispatchQueue`
     - `DispatchGroup`
- `searchbar`
- `로그인 / 로그아웃`
- `다크모드`

### 구현내용
- 코드 베이스로 UI구현
- 앱을 비동기 동기 과정을 사용해서 구현 
- MVVM 디자인 패턴을 사용해서 앱을 최대한 클린 아키텍쳐로 구현
- UICollectioview를 코드로 구현 
- 파이어 베이스 연동 및  podfile을 사용해서 앱에 추가하는 걸 구현 
- 검색창에 등록한 프로필 구현 
- 프로필을 누르면 업로드한 사진 별로 올라가게 구현 
- 검색할때 이름 순으로 필터를 걸어서 구현 
- 다크모드 구현 
- 로그인 한 계정이 다른경우 프로필 사진및 이름이 변경하게 구현 

### 고민했던점 && 로직구현 
 - 처음으로 mvc 말고 mvvm 디자인 패턴으로 구현을 하려고 하니까 view model안에는 어떤 로직을 구현을 해야 하는 어려웠습니다 . ㅠㅠㅠㅠ
 - 앱을 동작을 했을때 로그인이 되면 메인 화면으로 보이고 아니면 로그인 화면으로 구현 하는 방식을 어떨게 할지 고민을 했습니다.
 - 메인쓰레드에서 앱에 정보가 많아지면  앱이 버벅일수 있어서  버벅이는 걸  방지 하기 위해서 비동기 동기 프로그램을 사용해서 앱이 버벅이지 않고 구현을 하도록 했습니다.
 - 파이어베이스 연동및 로그인했을때 api를 연동을 하면서 데이터를 받아오고 넘겨주는 부분은  네트워킹에  api 라는 파일  구현 해서 최대한 분리 하면서 구현을 했습니다 .
 - 최대한 한 파일안에  한 구조체 및 클래스가 사용하려고 노력을 하면서 , 하드코딩을 피하면서 최대한 클린 아키텍쳐로 구현을 했습니다.
 - 프로필로 가서 사진 이 다르게 나오게 구현을 할려면  사진이 조금 늦게 올라오는건 사진이 업로드 하는과정에서 비동기적이 작업을 해야되서 비동기적인 작업을 구현을 했습니다.
 - table뷰에 가입한 계정및 이름이 순서대로 나오게 구현 및 이름을 순서대로 구현하면서 map을 핕터를 걸면서 구현을 했습니다.
 - 다크 모드를 구현을 할때 각 컬러의 set을 설정해주면서 컬러를 구현을 했습니다 
 - 다른계정으로 로그인을 하면 로그인 한 계정이름 , 사진 이 업로드 하게 되게 구현및 사진이 업로드 할때는 비동기 처리로 구현을 했습니다. 

### 배운개념
#### DispatchQueue를 사용하면서  작업량이 많은 코드는 GCD로 구현을 했습니다 

```swift=
 func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser ==  nil  {
            DispatchQueue.main.async {
                let controller = LoginController()
                let  navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion:  nil)
            }
        }
    }
```

#### 코드로 tababrcontroller 구현을 할때  tabbar를 눌렀을떄와 안눌렀을때 아이콘을 다르게 구현을 했습니다

```swift=
 private func configureViewControllers() {
        view.backgroundColor = .white
        let layout =  UICollectionViewFlowLayout( )
        let feed = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"),  selectedImage:  #imageLiteral(resourceName: "home_selected") , rootViewController: FeedController(collectionViewLayout: layout))
        let search = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_selected"),  selectedImage:  #imageLiteral(resourceName: "search_selected") , rootViewController: SearchController())
        let imageSelector = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"),  selectedImage:  #imageLiteral(resourceName: "plus_unselected") , rootViewController: ImageSelectorController())
        let notifications = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"),  selectedImage:  #imageLiteral(resourceName: "like_selected") , rootViewController: NotificationController())
        let profile = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"),  selectedImage:  #imageLiteral(resourceName: "profile_selected") , rootViewController: ProfileController())
        viewControllers = [feed , search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    //MARK: - tabbar 의 이미지가 선택 되었을때랑 안선택 되었을때 이미지 선택 해주는 함수
    private func tempateNavigationController(unselectedImage: UIImage, selectedImage: UIImage , rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.tintColor = .black
        return navigation
    }
```
#### 파이어베이스 로그인을 했을때 로그아웃을 했을떄서버와 통신이 안되면 에러 처리를 프린트를 해주었습니다  

```swift=
 @objc func handleLogin() {
        guard let email = emailTextField.text else  { return }
        guard let password = passwordTextField.text else  { return }
        
        AuthService.logUseIn(withEmail: email, password: password) { (result,  error ) in
            if let error = error {
                print("DEBUG: Falied to log user in  \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

 @objc func handleSignUp() {
        guard let email = emailTextField.text else  { return }
        guard let password = passwordTextField.text else  { return }
        guard let fullname = fullNameTextField.text else  { return }
        guard let username = userNameTextField.text?.lowercased() else  { return }
        guard let profileImage = self.profileImage else { return }

        let crendentials = AuthCredentials(email: email, password: password,
                                         fullname: fullname, username: username,
                                         profileImage: profileImage)
        
        AuthService.registerUser(withCredential: crendentials) { error in
            if let error = error {
                print("DEBUG: Falied to register user \(error.localizedDescription)")
                return
            }
            print("DEBUG:Sucessfully registered user with firestore...")
            self.dismiss(animated: true, completion: nil)
        }
    }
```
## Step2
### 유저 업데이트 및 데이터 받아오기 
```swift=
struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            print("\(String(describing: snapshot?.data()))")
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
```

### 로그인 했을때  사용자가 다르면  프로필에  업데이트 하게 구현
```swift=

protocol AuthenticationDelegate: class {
    func authenticationDidComplete()
}

extension MainTabViewController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

```

###  검색  탭에  searchCell 구현

```swift=
final class SearchController:  UITableViewController {
    //MARK: - Properties
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureTableView()
        
    }
    
    private func configureTableView() {
        view.backgroundColor = .backgroundColor
        tableView.register(UserCell.self, forCellReuseIdentifier: CellIdentifier.searchReuseIdentifier)
        tableView.rowHeight = 64
    }
}

//MARK: - UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchReuseIdentifier, for:  indexPath)
        cell.backgroundColor = .backgroundColor
        return cell
    }
}

```

### 사용자들 수 만큼 테이블뷰에 나오게 구현

```swift=
//MARK: - firebase 에서 사용자 정보 받아 오기
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User (dictionary: $0.data() )  })
            completion(users)
        }
    }

```

### 테이블 뷰에 현재 등록 되있는 계정 사진및 정보 구현
```swift=
truct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}

```

### 검색창 구현
```swift=
private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
```

### Commit 규칙
> 커밋 제목은 최대 50자 입력 </br>
본문은 한 줄 최대 72자 입력 </br>
Commit 메세지 </br>

🪛[chore]: 코드 수정, 내부 파일 수정. </br>
✨[feat]: 새로운 기능 구현. </br>
🎨[style]: 스타일 관련 기능.(코드의 구조/형태 개선) </br>
➕[add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가 </br>
🔧[file]: 새로운 파일 생성, 삭제 시 </br>
🐛[fix]: 버그, 오류 해결. </br>
🔥[del]: 쓸모없는 코드/파일 삭제. </br>
📝[docs]: README나 WIKI 등의 문서 개정. </br>
💄[mod]: storyboard 파일,UI 수정한 경우. </br>
✏️[correct]: 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다. </br>
🚚[move]: 프로젝트 내 파일이나 코드(리소스)의 이동. </br>
⏪️[rename]: 파일 이름 변경이 있을 때 사용합니다. </br>
⚡️[improve]: 향상이 있을 때 사용합니다. </br>
♻️[refactor]: 전면 수정이 있을 때 사용합니다. </br>
🔀[merge]: 다른브렌치를 merge 할 때 사용합니다. </br>
✅ [test]: 테스트 코드를 작성할 때 사용합니다. </br>

### Commit Body 규칙
> 제목 끝에 마침표(.) 금지 </br>
한글로 작성 </br>
브랜치 이름 규칙

- `STEP1`, `STEP2`, `STEP3`
