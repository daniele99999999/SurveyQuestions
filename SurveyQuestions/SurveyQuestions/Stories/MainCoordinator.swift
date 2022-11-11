//  
//  MainCoordinator.swift
//

import Foundation
import UIKit

struct MainCoordinator {
    private (set) weak var rootController: UINavigationController?
}

// MARK: Start
extension MainCoordinator: CoordinatorProtocol {
    func start() {
        self.flowHome(animated: false)
    }
}

// MARK: Create
private extension MainCoordinator {
    func createHome() -> UIViewController {
        let vm = HomeViewModel()
        vm.output.startSurvey = {
            DispatchQueue.main.async { self.flowSurvey(animated: true) }
        }
        let vc = HomeViewController(viewModel: vm)
        return vc
    }
    
    func createSurvey() -> UIViewController {
        let dataTask = DataTaskService(session: URLSession(configuration: .default))
        let network = NetworkService(dataTask: dataTask)
        let api = ApiService(baseURL: Resources.Api.baseURL, networkService: network)
        let vm = SurveyViewModel(api: api, bannerDuration: Resources.Misc.bannerDuration)
        let vc = SurveyViewController(viewModel: vm)
        return vc
    }
}

// MARK: Flow
private extension MainCoordinator {
    func flowHome(animated: Bool = true) {
        let vc = self.createHome()
        self.rootController?.pushViewController(vc, animated: animated)
    }
    
    func flowSurvey(animated: Bool = true) {
        let vc = self.createSurvey()
        self.rootController?.pushViewController(vc, animated: animated)
    }
}

