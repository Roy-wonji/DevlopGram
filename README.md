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
🗓 팀원: [로이](https://github.com/Roy-wonji) </br>
🗓 리뷰어: [릴리](https://github.com/yeahg-dev) </br>
🗓 리뷰: [PR](https://github.com/Roy-wonji/DevlopGram/pulls)


### UML

![Group 2225-min](https://user-images.githubusercontent.com/75601594/172851770-976b2531-eb77-403b-bd59-a3aba18a760e.jpg)

</br>

### UI 

![Group 5](https://user-images.githubusercontent.com/75601594/172876715-8473e30a-5933-4740-b376-affcc355f0c0.jpg)



### 실행 화면

![KakaoTalk_Video_2022-06-04-14-46-18](https://user-images.githubusercontent.com/75601594/172851799-a3100b59-8418-47fe-bb95-8085c17ea82b.gif)

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
- 피드를 올리면 올린 계정에 이름이랑 피드 사진및 글이 올라가게 구현
- 댓글을 달면 댓글 단 계정 및 이름이 timestamp로 나오게 구현
- 좋아요를 누리면 계시글에 좋아요 카운트가 증가하면서 버튼 색상이 바뀌게 구현

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
 - 좋아요를 눌었을때 색상을 변경하고 카운트 수 증가를 뷰델에서 구현을 했습니다

### 배운개념
#### DispatchQueue를 사용하면서  작업량이 많은 코드는 GCD로 구현을 했습니다 
```swift
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
```swift
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

```swift
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
```swift
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
```swift

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
```swift
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

```swift
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
```swift
struct UserCellViewModel {
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
```swift
private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
```
## STEP3
### 댓글창 구현 
```swift
//MARK: - API
    func fetchComments( ) {
        DispatchQueue.main.async {
            CommentService.fetchComments(forPost: self.post.postId) { comments in
                self.comments = comments
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - UI
    private func configureUI() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        navigationItem.title = "Comment"
        collectionView.backgroundColor = .backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColorAsset ?? CommentUIText.colorWrongInput]
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CellIdentifier.commentResueIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
}
```

### 사진이 업로드 한만큼 반환
```swift
//MARK: - UICollectionViewDataSource
extension ProfileController {
    //MARK: - collectionView셀 구현
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    //MARK: - collectionView  ProfileCell 셀 등록
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.profileCellIdentifier, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    //MARK: - collectionView  ProfileHeader 셀 등록
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifier.headerIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        header.viewModel = ProfileHeaderViewModel(user: user)
        return header
    }
}
//MARK: - UICollectionViewDelegate
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout() )
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
//MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButton user: User) {
        if user.isCurrentUser {
            print("DEBUG: Show edit profile here")
        } else if user.isFollowed {
            UserService.unfollowUser(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            UserService.followUser(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
}
```
### 파일업로드 및 팔로우수 구현 
```swift
    private func updateAPI() {
        DispatchQueue.main.async {
            self.checkIfUserIsFollowed()
            self.fetchUserStatus()
            self.fetchPosts()
        }
    }
    
    private func checkIfUserIsFollowed() {
        UserService.checkUserIsFollowed(uid: user.uid) { isFollowed in
            self.header.viewModel?.isFollwed = isFollowed
        }
    }
    
    private func fetchUserStatus() {
        UserService.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    private func fetchPosts() {
        PostService.fetchPost(forUser: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
```


## 고민했던점 && 궁금한점 

TabBarController 설정관련 코드는 어디에서 호출해야하는지
> 음... 이 부분에 대해선 로이의 생각이 먼저 궁금한데요~
TabBar의 설정 함수의 호출 위치를 SceneDelegate와 TabBarController 두 군데로 고민하셨는데, SceneDelegate를 고민하신 이유는 무엇이고, TabBarController에서 호출한 이유는 무엇인지 궁금합니다!
> TabbarController를 SceneDelegate 에서 호출 하는 이유는 어떤 scene을 rootviewcontroller로 지정할때 같이 tabbarcontroller를 할수 있어서 SceneDelegate에서 바로 호출 한다는생각 때매 SceneDelegate에서 호출 한다는 생각을 했습니다

TabBarControlle에서 하면 viewdidload에서 호출을 하면서 할수 있다고 생각이 들었습니다


메인스레드에서 API를 호출하고 있는 것 같습니다.
통신은 글로벌 큐로 보내어서 메인 큐는 UI업데이트 처리에 집중할 수 있도록 하는 건 어떨까요?


ViewModel의 역할
> 클린아키텍쳐에서 뷰는 뷰모델을 소유합니다. 뷰모델은 뷰로부터 이벤트를 받고, 유스케이스에서 API를 호출하여 전달받은 데이터를 뷰에 바로 뿌려줄 수 있는 형식으로 포맷팅을 하는 역할을 담당한다고 생각합니다. 특정 뷰에 보여지는 데이터를 제공하기 때문에, 뷰모델은 뷰에 종속적이지만, 뷰와 모델의 의존성을 없애주기 때문에 UI와 비지니스 로직을 분리 할 수 있고 유연한 설계를 가능하게 하고요.
제가 생각하는 뷰모델의 역할인 2가지가 로이만의 방법으로 달성되었다고 생각합니다.
뷰에 보여질 데이터를 처리하는 역할
바인딩을 통해 수동적인 뷰를 만든다
다만 개선되었으면 하는 부분이 있다면, 라인별 코멘트에도 남겼지만 뷰가 API를 호출하는 경우입니다. 뷰모델을 거치지 않고 뷰가 직접 API를 참조하게 되면 뷰와 API사이에는 의존성이 생깁니다. 뷰모델을 만들어서 의존성을 낮추고 책임을 분리해주세요!


UI처리시 main.async를 사용하는 것
```swift
 private func configure( ) {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else { return }
            self.captionLabel.text = viewModel.caption
            self.postImageView.sd_setImage(with: viewModel.imageUrl)
            self.profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
            self.userNameButton.setTitle(viewModel.username, for: .normal)
            self.likesLabel.text = viewModel.likesLabelText
            self.likeButton.tintColor = viewModel.likeButtonTintColor
            self.likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        }
    }
    configure가 호출되는 스레드가 메인스레드가 아닌 글로벌스레드라면 DispatchQueue.main.async로 감싸주시면 작성하신 것이 맞습니다:)
```

클린아키텍처
> 제가 공부했던 클린아키텍처 레퍼런스들에서는 API Service는 Usecase(비지니스로직)가 소유했었습니다. 그래서 뷰에서 API를 들고 호출하는 구조가 어색하게 느껴졌던 것 같아요.
현재 소프트웨어의 각 객체들이 클린아키텍쳐의 Entity, Usecase, Presentaion 어떤 레이어에 속하나요?
각 레이어간의 의존성에 대해 고민하고 Usecase를 추가해서 역할을 분리해보면 더 클린아키텍쳐스러워질 것 같습니다!

파일구조
> 파일 구조가 현재는 Model / ViewModel / Controller.. 로 크게 MVVM으로 나뉘어져있는데요. 
각 Scene과 연관된 뷰 컨트롤러와 뷰모델, 뷰 컴포넌트가 분리되어 있어서 찾기가 조금 어려운 것 같네요🤔
Sceme별로 연관된 뷰와 뷰모델을 모아두는 방법도 있으니 참고해보시는 것도 좋을 것 같습니다~ </br>





## Commit 규칙
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
