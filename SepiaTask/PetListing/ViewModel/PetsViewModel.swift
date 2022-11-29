//
//  PetsViewModel.swift
//  SepiaTask
//
//  Created by Kiran Jadhav on 29/11/22.
//

import UIKit

class PetsViewModel: NSObject {
    
    var arrPets: [Pets] = [Pets]()
    
    func getPetsData() {
        if let path = Bundle.main.path(forResource: String.jsonFilepetsList, ofType: String.jsonFileFormat) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let pets = jsonResult["pets"] as? [Any] {
                    
                    for data in pets {
                        let arrPet = Pets(petData: data as! [String : Any] )
                        arrPets.append(arrPet)
                    }
                    
                }
            } catch {
                // handle error here
            }
        }
    }
    
}
