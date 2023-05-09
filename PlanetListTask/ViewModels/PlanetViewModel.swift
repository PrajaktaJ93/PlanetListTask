//
//  PlanetService.swift
//  PlanetListTask
//
//  Created by Prajakta on 09/05/23.
//

import Foundation

class PlanetViewModel {

    var arrPlanet = [Planet]()
    var nextPageUrl = ""
    
    /// This function is gateway to generic API calling function. Also called to get planet list.
    func getPlanetList(url: String,
                        completionBlock: @escaping ([Planet]?) -> Void) {
        NetworkUtility.shared.fetchDataFromApiWith(urlString: url, completionBlock: { [weak self] (model: PlanetList?) in
            if let model = model, let list = model.planet, list.count > 0 {
                self?.nextPageUrl = model.next ?? ""
                for result in list {
                    if !(self?.arrPlanet.contains(where: { $0.url! == result.url! }))! {
                        self?.arrPlanet.append(result)
                    }
                }
                completionBlock(self?.arrPlanet)
            }
        })
    }
}


