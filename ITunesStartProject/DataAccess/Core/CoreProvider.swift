//
//  CoreProvider.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

public enum CoreProviderError: Error {
    case serializationFailed
}

open class CoreProvider<T: APITarget>: MoyaProvider<ConfigurableTarget> {
    open func request<D: Decodable>(_ target: T) -> Promise<D> {
        return Promise<D> { resolver in
            request(ConfigurableTarget(target: target)){ result in
                switch result {
                case let .success(response):
                    do {
                        let decoder = JSONDecoder()
                        let data = try response.filterSuccessfulStatusCodes().data
                        let resultData = try decoder.decode(D.self, from: data)
                        resolver.fulfill(resultData)
                    }
                    catch MoyaError.statusCode(let response) {
                        do {
                            let decoder = JSONDecoder()
                            let resultData = try decoder.decode(APIError.self, from: response.data)
                            resolver.reject(resultData)
                        }
                        catch {
                            resolver.reject(CoreProviderError.serializationFailed)
                        }
                    }
                    catch {
                        resolver.reject(CoreProviderError.serializationFailed)
                    }
                case let .failure(error):
                    do {
                        let decoder = JSONDecoder()
                        if let data = error.response?.data {
                            let resultData = try decoder.decode(APIError.self, from: data)
                            resolver.reject(resultData)
                        }
                        resolver.reject(error)
                    }
                    catch {
                        resolver.reject(error)
                    }
                }
            }
        }
    }
}


