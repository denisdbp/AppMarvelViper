//
//  ListCharactersInteractor.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import Foundation
import CryptoKit

protocol InteractorProtocol:AnyObject {
    var presenter: PresenterProtocol? {get set}
    func getComics(limit:Int)
}

class ListComicsInteractor:InteractorProtocol {
    var presenter: PresenterProtocol?
    
    private let publicKey:String = "f3194187fff2c8e279ad8ece5ba9fa6f"
    private let privateKey:String = "b84f230e73173415cf6fb62ef321bd5821dff6a0"
    private let endPoint:String = "https://gateway.marvel.com/v1/public/characters"
    
    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    private func timeStamp()->String{
        let data = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ss"
        return formatter.string(from: data)
    }
    
    private var hashMd5:String {
        return self.MD5(string: "\(self.timeStamp())\(self.privateKey)\(self.publicKey)")
    }
    
    func getComics(limit:Int) {
        guard let url = URL(string: "\(self.endPoint)?&limit=\(limit)&ts=\(self.timeStamp())&apikey=\(self.publicKey)&hash=\(self.hashMd5)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do{
                    let json = try JSONDecoder().decode(ListData.self, from: data)
                    DispatchQueue.main.async {
                        self.presenter?.fetchRequestSuccess(model: json.data.results)
                    }
                }catch{
                    self.presenter?.fetchRequestError(error: error)
                }
            }
            if let error = error {
                self.presenter?.fetchRequestError(error: error)
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode > 399 {
                    guard let error = error else {return}
                    self.presenter?.fetchRequestError(error: error)
                }
            }
        }
        task.resume()
    }
}
