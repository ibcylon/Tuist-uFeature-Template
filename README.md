# Tuist uFeature Template

Tuist는 처음에 .pbxproj conflict를 해결하기 위해서 사용했었다. 노수진님의 RIBs 강의 듣고 모듈화에 관심을 가지게 됐고, 기록 및 나중에 사용하고자 Template을 만들기 되었다.

# 아키텍처

Clean Architecture Layer인 Data / Domain / Presentation의 구조를 uFeature(마이크로 피처) 아키텍처로 적용하였습니다.

<details>
<summary><h3>uFeature란</h3></summary>
<div markdown="1">
<img width="567" alt="Untitled" src="https://github.com/ibcylon/Tuist-uFeature-Template/assets/25360781/cb5471e8-492b-44e9-8357-318e34b1beeb">

출처 [Building uFeatures Slide](https://speakerdeck.com/pepibumur/building-ufeatures?slide=34) 

앱이 커지면서 팀 작업간의 병목이 생기면서 등장. 다른 피처가 필요하게 될 경우, 개발될 때까지 기다려야 하고, 앱의 스케일에 따라 빌드 속도도 느려지게 됨. 모듈로 나눠 모듈 별로 빌드할 수 있다.

구현 방법은 3가지 존재한다. 

- Tuist
- SwiftGen
- SPM의 Package

</div>
</details>
  
# 피처 모듈 구조
![tuist document - uFeature Architecture](https://github.com/ibcylon/Tuist-uFeature-Template/assets/25360781/62636ee9-a244-4beb-9365-50052cda52a1)

tuist document - uFeature Architecture

- **FeatureInterface**: Feature가 사용할 Domain
Model, <<UseCase>>, <<Repository>> 그리고 모듈을 인스턴스하기 위한 <<Coordinator>>, <<Builder>>
- **Feature**: Implement로 Business Logic과 UI 구현. 
Feature UIKit 그리고 UseCase, Coordinator, Builder의 구현체
- **FeatureTesting**: Demo App과 unitTest에 사용될 Test Mock 객체를 구현. 이를 위해 interface를 의존
- **FeatureTests**: Test를 위한 Target으로 로직 테스트 위해 Mock을 가지고 있는 Testing 의존. VM 테스트를 위해 Feature를 의존
- **FeatureExample**: Demo App Target으로 피처 단위 앱을 빌드. 
로직 테스트 위해 Testing 의존. 실 서비스(네트워크) 테스트 위해 Data Module을 의존

# 의존성 그래프

![graph.png](/graph.png)


### 모듈


- 3rdPartyLibs: 외부 라이브러들, Test 때문에 2번 참조할 일 없는 라이브러리는 Static 이외는 Dynamic
- DSKit(DesignSystemKit): Asset인 Font, Image, Lottie 그리고 공통 UIComponents
- Networks: HTTP Client를 가지고 있음, 처음엔 Data가 의존하고 있었으나, Image Cache를 위해 Core가 의존
- BaseTest(TestCore): Test 타겟을 만들다 보니 의존할 것들이 많아서 만듦. Rx관련, FeatureTesting, Feature, XCTest(Quick, Nimble 등)
    - SOPT의 TestCore를 참조하였음 → [SOPT Repo](https://github.com/sopt-makers/SOPT-iOS/blob/develop/SOPT-iOS/Projects/Modules/TestCore/Project.swift)
    - RxRelay, RxCocoa, RxSwift 전부 의존한 이유는 unitTest Target에서 3개 전부 의존해야 Dynamic으로 처리되기 때문 → [민소네님 블로그 참조](https://minsone.github.io/ios/mac/ios-only-using-swiftpm-rxblocking-rxtest-on-unit-test)
- Core: Logger, Networks, DesignSystemKit, Util 등이 있음

### 레이어

- Domain Layer: Domain은 구현하기 나름인 것 같다. 여러 Refs를 찾아봤지만 각각 달랐다. 
나는 편의성과 필요성을 위해 만들었다.
    1. 모든 피처 인터페이스를 알아야하는 Data Layer가 의존하기 쉽게
    2. Rick and Morty API 특성 상 캐릭터, 에피소드와 로케이션 피처들이 서로 화면에서 각각 피처들로 이동할 수 있어야했다. 피처들의 Builder와 Coordinator 인터페이스를 알고 있고, 각 피처가 이들 사이를 넘나들 수 있는 새로운 Coordinator 인터페이스가 필요했다.(구현은 Feature Layer에서 책임)
- Data Layer: Data Layer로 데이터 처리, 통신을 책임진다. 피처 인터페이스들을 의존한다.
API Network통신에서 DTO를 Domain Entity로 변경하고, <<Repository>>를 구현한다.
- Feature Layer: Feature Layer로 피처들을 묶는 glue Layer 역할
    - AppRootBuilder를 책임짐. App Layer의 책임을 줄이기 위해서
    - MainTabBar / MainCoordinator구현: Feature들을 묶는 Tab
    - Onboarding, Auth, MainTab등 Launch Routing 책임
- App Layer: App Layer역할인 Data와 Feature를 조립하는(composite) 역할을 한다. 
Data의 Repositry와 Feature의 UseCase를 완성해서 의존성을 instance해서 주입한다.
편의를 위해 DI Container를 만들고 의존성을 register함 - SOPT 참조하였음.

<details>
<summary><h3>구현 기능</h3></summary>
<div markdown="1">

### Dependency Injection

- Mock Test와 변경에 따른 유연함을 위해서 모듈과 서비스에 종속성을 주입하게 만듦
편의를 위해 DIContainer를 만들어서 관리함
코드참조 - SOPT Repo
이론 - [노수진님 포스트 - 의존성 주입의 오해와 진실](https://soojin.ro/blog/dependency-injection-basics)

### Builder와 Coordinator

- 빌드 타임 감소를 위해 interface와 implement를 분리
- 의존성 관리 편의, 휴먼 에러 방지, 구현 캡슐화를 위해 Builder를 통한 모듈을 인스턴스화
- Coordinator 사용하여, Scene간의 종속성 제거를 통해 재사용성을 증가 시킴
[iOS Coordinator from Redux](https://khanlou.com/2015/10/coordinators-redux/)

### Image caching

- NSCache 이용 In-memory 캐시 구현
- File Manager 이용 Disk-cache 캐시 구현

</div>
</details>

<details>
<summary><h3>고민한 점</h3></summary>
<div markdown="1">

- Modular + Clean Architecture Layer 적용: 모듈에서 Domain과 Presentation을 누가 책임져야하는지 불분명했다.
    - Domain: 다른 피처에서 해당 Entity가 필요할 때는 어떻게 해야 하나 등의 고민을 가지고 Entity Layer를 만들지 고민. tuist uFeature 문서에서 FeatureInterface에 Model을 정의한다는 것을 보고 Interface가 책임지게 됨
    - Present: 전역적인 Present Layer를 만들게 되면 도대체 모듈 구현체에서 책임지는 게 뭔지 불분명했다. RIBs 아키텍처를 참조하여 모듈 구현부에 Builder, Router를 만듦
    - Data: RIBs에서 영감을 얻은 만큼 모듈 독립성을 위해 Repository 구현도 모듈 내에서 해야하는 건지 아니면 Data Layer를 만들어야 하는 건지 고민하게 됨. 
    중복 코드 / Repository를 소유하고 있는 Repository / 분리를 통한 유연성을 확보하기 위해 Data Layer를 만듦.
- 다른 피처 화면으로 이동 어떻게?: 서로간의 피처 화면이 필요하게 될 경우, circular dependency가 생길 우려도 있고 구현체 전부를 알아야하는 부담, 빌드 시간 증가 및 병목. Module과 Interface를 분리하여 해결.
- 하지만 전체 모듈 화면이 필요한 것이 아닌 일부화면만 필요한 경우 어떻게 해야하는가?
RIBs에서는 Coordinator를 잘게 쪼개서 해당 화면의 Coordinator와 Builder를 만들었다. 보일러 플레이트가 많아 다른 방법을 고려함.
Scene들을 internal에서 public으로 변경한 후, glue Layer(Feature Layer)에서 새로운 Coordinator를 생성. 피처들이 이 Coordinator를 알고 있어야 하기 때문에 Domain Layer를 만들고 인터페이스를 선언함.
- Network는 누가 의존하는가?: 처음엔 Data만 Network를 사용했으나 Core 단에서
Image Cache를 하면서 Network 사용할 일이 발생하였다. 팀원간에 의견이 갈렸다. 편의를 위해 Core로 Network를 내렸다.
    - Data만 의존해야 한다. Network 동작 코드는 중복될 수 있다. KingFisher를 사용하게 되면 Core단에서도 network 통신을 하게 된다. 이미지 캐시만을 위한 네트워크 코드를 만들어야 한다.
    - Core로 Network모듈을 내린다. API 정보는 Data가 가지고 있고 순수 HTTP 통신 코드만 Netowrk가 책임진다.

</div>
</details>

<details>
<summary><h3>회고</h3></summary>
<div markdown="1">

## 모듈화하면서 배운점

- 접근자에 대한 이해: internal과 private만 사용하고, public, open은 사용 경험이 많이 없었다. 모듈화하면서 접근자가 강제되면서, 제대로 정의하지 않으면 compile error가 났다. 모듈의 독립성을 최대한 지키려고 접근자 최적화에 대해 신경쓰면서 작업하게 되었다.
- Target, Project의 개념: project와 target에 대해서 이해 없이 작업하고 mono target으로만 앱을 만들어 왔다. Workspace > project > target(product type)[app, framework, library, unitTest]의 개념을 이해하고 사용할 수 있게 됨.
- Static vs Dynamic: 이론적으로만 이해하고 구분해서 사용한 경험이 없었다.
    - resource를 가지고 있는 모듈과 아닌 모듈들을 신경쓰게 됨
    cf. Tuist에서는 Static에서도 Resource물기가 가능. 
    따라서, **Static Library Target**이 defaut이고 권장됨 [공식 문서 링크](https://docs.tuist.io/building-at-scale/microfeatures)
    - static인 모듈들의 코드 복사 에러 그리고 3rd party에서 트러블이 많이 생기면서 알게 되었다.
    - ~~앱의 규모가 작아서 빌드 속도에서는 차이를 못 느꼈지만, 앱 런칭 속도는 체감할 수 있었다.~~
- Library vs Framework:
    - Framework는 bundle을 가져서 verson 관리를 가능하게 한다.
    - 라이브러리는 내가 원하는 시점에 주도권을 가지고 사용하는 것
    프레임워크는 주도권을 넘기는 것 출처  [코디네이터 패턴 이론](https://vimeo.com/144116310)
    - 이 부분은 아직 더 공부가 필요한 것 같다. Product type을 Library와 Framework으로 선택할 시 어떤 것이 더 이점이 있는지 잘 모르겠다.

## 개선이 필요한 점

- Tuist Scaffold Template:
현재 상태에서 피처를 추가하려면 FeatureName만 다른 인터페이스 보일러플레이트 코드들이 많이 필요
<<Coordinator>>, <<Builder>>, <<Repository>>, <<UseCase>> 그리고 구현체, Demo App의 AppDelegate, SceneDelegate 등. 
처음부터 scaffold를 도입하려했으나 모듈화를 이해하면서 사용하기가 쉽지 않았음. 인터페이스와 타겟들을 직접 bottom-up으로 구현해보면서 불편함을 직접 느끼고 개선 필요성을 깨닫게 됨.
- 피처 UIKit 모듈 분리:
피처를 개발하면서 다른 피처의 모델이나 Builder가 아니라, Cell등의 UIComponent 단위로 필요하게 된 경우가 생김. FeatureInterface에 /UI 폴더를 만들어서 해결했으나, UI가 필요없는 경우 최적화를 위해 만들 필요성이 생김
- UI Framework 의존성 제거: 
현재는 UIKit에 종속되어 Coordinator와 View가 UIVIewController와 navigationController가 강제 됨.
Coordinator의 책임을 분리시켜서 해결해 볼 수 있다.
    - ViewController를 Scene이라고 추상화한다
    - Coordinator가 Scene을 직접 만들지 않고 factory를 만들어 위임한다.
    - Router를 만들어 Coordinator에 명령에 따른다.
    - 화면이동과 scene을 만드는 인터페이스만 만들면 어떻게 구현하는 지를 감출 수 있으니 SwiftUI나 UIKit에 전환이 가능할 것 같다.
    [코디네이터 패턴 포스트](https://pavlepesic.medium.com/flow-coordination-pattern-5eb60cd220d5)
- Scheme
- XC Config
- GitHub Action을 이용한 CI/CD
- Storage service
현재는 이미지만 캐시되어 있으나 URLCache를 이용하여 API Data caching과
Domain Entity 캐싱

</div>
</details>

# 참조

- [사용한 API RickAndMorty](https://rickandmortyapi.com/api/character/?name=rick&status=alive)
- RIBs: 노수진님 강의 - 모듈화가 필요한 이유, 모듈들로부터 의존성을 제거하는 법, SPM을 이용하여 모듈화, Builder, Router, Dependency Injection, AppRootComposition
- [tuist uFeature document](https://docs.tuist.io/building-at-scale/microfeatures) - uFeature 등장 배경 및 이론 및 Tuist를 이용한 구현 방법
- [tuist modular example - archived](https://github.com/tuist/example) - Target Template Helper
- tuist uFeature ref의 slide1 - [Building uFeatures](https://speakerdeck.com/pepibumur/building-ufeatures) - 모듈러 이론
- [developing modular app](https://speakerdeck.com/pepibumur/developing-modular-apps-on-ios) - 모듈러 이론
- [29cm tuist 포스트](https://medium.com/29cm/tuist-%EB%A1%9C-%EA%B0%80%EB%8A%94-%EC%97%AC%EC%A0%95-part2-tuist-%EC%97%90%EC%84%9C-%EC%98%A4%ED%94%88%EC%86%8C%EC%8A%A4-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC-%EA%B4%80%EB%A6%AC%ED%95%98%EA%B8%B0-8d1bb7efb941) - 오픈 소스 라이브러리 관리
- [펌핑 레포](https://github.com/depromeet/Pumping-iOS/) - 피처모듈의 타겟들 구조
- [SOPT 레포](https://github.com/sopt-makers/SOPT-iOS/tree/develop) - Target + Template 그리고 전반적인 구조
- [민소네 iOS example.com](https://iosexample.com/tuist-based-ios-application-project-template/) - Demo app tartet 구현과 3rd party framework 빌드
- [김종권님 블로그 - 의존성 그래프 주의 사항](https://ios-development.tistory.com/1305)
- [그린님 블로그 - Tuist Lottie resource synthesizer](https://green1229.tistory.com/348)
