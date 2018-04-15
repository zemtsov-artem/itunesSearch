//
//  DependencyContainer.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 13/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation
import Dip

extension DependencyContainer {
    
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            let itunesProvider = CoreProvider<ITunesSearchTarget>()
            container.register{ITunesSearchClient(provider: itunesProvider) as ITunesSearchClientType}
            
            container.register(.singleton){ITunesSearchRepository(client: try! container.resolve()) as ITunesSearchRepositoryType}
            
            let itunesSearchPresenter = container.register{(view : SearchViewControllerType) in ITunesSearchPresenter(view: view, repository: try! container.resolve())}
            container.register(itunesSearchPresenter, type: ITunesSearchPresenterType.self)
            
           
        }
    }
}

