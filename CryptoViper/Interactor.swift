//
//  Interactor.swift
//  CryptoViper
//
//  Created by Altan on 30.05.2023.
//

import Foundation

//Talks to -> Presenter
//Class, protocol

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            return print("error")
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in //[weak self] yazarak görünüm değiştiğinde hafızada kalmasını engelliyoruz.
            guard let data = data, error == nil else {
                self?.presenter?.interactorViewDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return print("error")
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorViewDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self?.presenter?.interactorViewDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        
        task.resume()
    }
    
    
}
