//
//  Presenter.swift
//  CryptoViper
//
//  Created by Altan on 30.05.2023.
//

import Foundation

//Talks to -> Interactor, router, view
//Class, protocol

protocol AnyPresenter {
    var router : AnyRouter? {get set} //Hem okunması hem de değerin değiştirilmesi için {get set} ekledik.
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorViewDidDownloadCrypto(result: Result<[Crypto], Error>) //Veri geldiğinde view kendini güncellesin diye bu fonksiyonu yazıyoruz.
}

class CryptoPresenter : AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        
        //Değerler atanınca yapılacak işlemler.
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorViewDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "error")
        }
    }
    
    
}
