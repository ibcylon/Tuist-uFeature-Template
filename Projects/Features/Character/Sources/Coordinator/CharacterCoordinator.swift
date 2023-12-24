
import UIKit
import Core
import Domain

public final class CharacterCoordinator: BaseCoordinator, CharacterCoordinating {

  public var delegate: CharacterCoordinatorDelegate?

  @Injected public var characterUseCase: FetchCharacterUseCaseInterface

  public init(
    rootViewControllable: ViewControllable
  ) {
    super.init(rootViewController: rootViewControllable)
  }

  public override func start() {
    characterHomeFlow()
  }

  // MARK: Private
  public func characterHomeFlow() {
    let viewModel = CharacterListViewModel(useCase: characterUseCase)

    viewModel.delegate = self
    let viewController = CharacterListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.setViewControllers([viewController])
  }

  public func characterDetailFlow(_ item: RMCharacter) {
    RMLogger.ui.debug("Character detail FLow ")
  }
}

extension CharacterCoordinator: CharacterSearchDelegate {
  func presentItem(item: RMCharacter) {
    self.characterDetailFlow(item)
  }
  func logout() {
    self.viewControllable.setViewControllers([])
    self.delegate?.detach(self)
  }
  func searchButtonTap() {
    RMLogger.ui.debug("Character search Flow ")
  }
}
