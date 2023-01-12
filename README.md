# 개발일지

## 2022-12-31 개발 일지
- git 공부
- splash 스크린 제작
- 회원가입 & 로그인 페이지 메인 페이지 제작 : 시작하는 스토리보드 변경을 위해 info plist 변경
- 로그인 view 제작
- main tab bar 뼈대 제작
- extension : UIButton, UITextField, UIViewController

## 2023-01-01 개발 일지
- 회원가입 뷰 제작
- 메인 홈 뷰 제작 : 컨테이너 뷰 2개로 스토리 뷰 부분은 collection view, 피드 뷰 부분은 table view로 했는데 그러면 피드를 스크롤할 때 스토리 부분이 여전히 상단에 고정됨. 테이블 뷰 안에 콜렉션 뷰를 넣어주는 방식으로 고치기. 
- Base View Controller : navigation bar color.
- extension : TabmanViewController, UIColor, UIFont, String
- 로그인 화면 : 아이디, 패스워드 입력 안 할 시 alert, datamanager로 토큰 받아오기
- 인스타그램 폰트 추가 

## 2023-01-02 개발 일지 
- extension : Date
- 회원가입 뷰에서 생일 뷰 : textfield와 datePicker
- 자주 쓰는 UIColor 추가 : 회원가입 뷰의 next button color
- 회원가입 화면 수정 : 모든 버튼이 textfield의 동작에 따라 isEnabled가 달라지도록 수정 -> textfield delegate사용.
- 유효성 검사 적용 중


## 2023.01.03 개발 일지
- sign in api 연결
- sign up api 연결
- sign up view 수정 : email형식 검사
- profile view : 전체 뷰
- profile post : tab man 적용 
### 해결해야 하는 이슈
- 🚨 tab man : TMBarItem에 이미지가 적용되지 않는 문제 -> collection view header로 바꾸기로 했으므로 해결할 필요 사라짐

## 2023.01.04 개발 일지 
- posts/feeds api 연결
- profiles/{userIdx} 연결 : 나중에 test userIdx말고 내 userIdx로 바꿔줘야 함.

### 해결해야 하는 이슈
- 🚨 feed view : table view cell 안에 page view 적용하는 문제 : 적용했으나 스와이프 가능하도록 수정.
- 🚨 profile view : scroll 가능을 위해 테이블 뷰-> 셀 2가지 채택 -> 아래 셀 내부 컬렉션 뷰. 이런식으로 진행해야 함. 탭맨은 클래스이므로 테이블 셀 안에서 적용할 수가 없음. 다른 방법을 찾아야 함. 여기서 view pager, collection view, scroll view 등... 많이 찾아보기. 
- 🚨 위의 문제는 collection view header로 해결하기 

## 2023.01.05 개발 일지
- 프로필 뷰 : collection view 추가 -> 나의 게시글 썸네일 보여주기
- 게시글 업로드 선택 뷰
- 게시글 업로드 뷰
- 게시글 이미지 선택 : 여러 이미지 선택을 위해 BSImagePicker 사용
- 이미지 url 얻어오기 위해 firebase사용
- 이미지 컨트롤러 : userDefaults에 url저장해서 rootView를 CreatePostViewController로 전환

### 해결해야 하는 이슈
- 🚨 결국 프로필 뷰 스크롤 문제는 계속 해결해야 함...
- 🚨 게시물 업로드 : 이미지 뷰 잘못 나오는 것 수정


## 2023.01.06
- 게시물 조회 api 연결
- 게시물 삭제 api 연결
- 게시물 수정 api 연결 시도

### 공부
- 루트 뷰 : https://steven8.tistory.com/31

## 2023.01.07
- api 연결 테스트 : 회원탈퇴 성공. 팔로우 성공. 로그아웃 성공. 비밀번호찾기 실패. 프로필조회성공. 프로필 편집 성공. 팔로워 성공. 팔로잉 성공. 댓글 생성 성공. 댓글 삭제 성공. 댓글 좋아요 성공. 최근 검색 기록 조회 성공. 검색 성공. 검색 삭제 성공
- 비밀번호 찾기 : 인증 코드 없이 진행하기로 함.
- 댓글 삭제 : commentIdx는 어디서 얻어서 보내나(게시물 조회에서).
- 검색 : request에 word 
- 게시물 수정 api 연결
- 프로필 편집 조회 api 연결
- 프로필 편집 api 연결
- 최근 검색어 조회 api 연결
- 계정 검색 api 연결 
- 게시물 정보를 이용해서 댓글 조회 뷰 생성
- 댓글 생성 api 연결
- 댓글 삭제 api 연결

## 2023.01.08
- 프로필 뷰 수정 : 소개글, 웹사이트 여부에 따라 프로필 편집 버튼의 topAnchor가 달라지도록 수정

## 2023.01.09
- dismiss 한 후 push하는 법 : root view 가 uitabbarcontroller이므로 push가 안 됨. 
- 게시물 작성 썸네일 문제 해결
- 전체적인 ui 수정

## 2023.01.10
- 해야할 일 : 팔로우, 팔로워, 다른 유저 프로필 조회, 스토리, 추천 친구, 검색 삭제, 댓글 뷰 수정, 알고리즘 추천, 게시물 좋아요, 댓글 좋아요, 좋아요 리스트, 댓글 좋아요 리스트.
- 스냅킷, compositional layout 공부
- 댓글 뷰 수정 : 헤더뷰 추가, 스냅킷 사용
- 팔로워, 팔로잉 api 연결

## 2023.01.11
- 내 프로필 -> (userIdx=내 Idx) -> 팔로우 조회/팔로잉 조회 -> (profileIdx=다른 유저의 userIdx) -> 다른 유저 프로필 -> (userIdx=다른 유저의 userIdx) -> 다른 유저 프로필의 팔로우 조회/팔로잉 조회
- 알고리즘 추천 게시물 api 연결
- 개인 정보 설정 조회 & 개인 정보 설정 변경 api 연결
- api 연결 
    
    - 회원가입
    - 로그인
    - 게시글 조회
    - 게시글 작성
    - 게시글 수정
    - 게시글 삭제
    - 피드 조회
    - 프로필 편집 조회
    - 프로필 편집
    - 프로필 조회
    - 팔로워 조회
    - 팔로잉 조회
    - 댓글 생성
    - 댓글 삭제
    - 검색
    - 최근 검색 기록 조회
    - 알고리즘 추천 게시물
    - 로그아웃
    - 개인 정보 설정 조회
    - 개인 정보 설정 변경
    
## 2023.01.12
- 팔로우, 팔로잉 조회할 때 profileIdx & userIdx 문제 
- 다시 돌아올 때 업데이트 해줘야 함. 
- 팔로우 팔로잉 조회 시 : userIdx 문제...
- 검색 삭제 api 연결
- 회원 탈퇴 api 연결
- table view reuse 문제 해결 : prepareForReuse 함수에서 초기화
- 전체적인 ui 수정
