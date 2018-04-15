//
//  ITunesSearchPresenter.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation

import Foundation
import PromiseKit


protocol ITunesSearchPresenterType {
    func showSongs(searchString:String,fresh:Bool)
}

class ITunesSearchPresenter : ITunesSearchPresenterType {
    
    private weak var view : SearchViewControllerType?
    private var repository : ITunesSearchRepositoryType;
    
    init(view: SearchViewControllerType,repository:ITunesSearchRepositoryType) {
        self.repository = repository
        self.view = view
    }
    
    public func showSongs(searchString:String,fresh:Bool) {
        view?.showProgress()
        firstly {
            return self.repository.getSongs(searchString: searchString, fresh: fresh)}.done{ result in
                self.view?.updateSongModels(songModels: result)
                }.ensure {
                    self.view?.hideHUD()
                }.catch { error in
                    if let e = error as? APIError{
//                        self.view?.showError(title: "Error", text: e.message) {
//                            if e.code == ApiErrorCode.unauthorized.rawValue {
//                                self.eventBus.trigger(event: .logoutRequested)
//                            }
//                        }
                    }
//                    self.view?.showError(title: "Error", text: "Error while getting data")
            }
//        }
        
    }
}

