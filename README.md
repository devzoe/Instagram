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
