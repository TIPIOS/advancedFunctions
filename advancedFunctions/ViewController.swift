//
//  ViewController.swift
//  advancedFunctions
//
//  Created by Luc Derosne on 21/09/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Motard {
        let prenom: String
        let age: Int
        let becanes: [String]
    }
    
    let MotardsTab = [Motard(prenom: "Bob", age: 28, becanes: ["Ténéré", "Solex"]), Motard(prenom: "Robert", age: 58, becanes: ["Piaggo mp3", "Tracer Yamaha", "Terrot 125"]), Motard(prenom: "Julie", age: 34, becanes: ["BWW 1200 RT"]), Motard(prenom: "Raymond", age: 50, becanes: ["Vespa"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapUseCases()
        flatMapUseCases()
        compactMapUseCases()
        reduceUseCases()
        filterUseCases()
    }
    
    func mapUseCases() {
        // .map
        // calculer un tableau de prix TTC
        let prixHT = [12.4, 56.3, 24.3, 14.8]
        let prixTTC = prixHT.map( { Float( $0 * 1.20 )})
        print(prixTTC) // [14.88, 67.56, 29.16, 17.76]
        
        // extraire les valeurs d'un dictionnaire
        let dicoClefsValeurs: [Int: String] = [1: "Lundi", 2: "Mardi", 3: "Mercredi", 4: "Jeudi ", 5: "Vendredi", 6: "Samedi", 7: "Dimanche"]
        let valeurs = dicoClefsValeurs.map{ $1 }
        print(valeurs) // ["Dimanche", "Vendredi", "Mardi", "Jeudi ", "Lundi", "Mercredi", "Samedi"]
        
        // changer la casse d'un tableau de String
        let valeursUpper = valeurs.map { $0.uppercased() }
        print(valeursUpper) // ["SAMEDI", "MARDI", "VENDREDI", "JEUDI ", "MERCREDI", "LUNDI", "DIMANCHE"]
        
        // convertir les nombres d'un tableau en chaîne de caractères
        let scores = [0,69,101, 51]
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: "fr_FR")
        let words = scores.map { formatter.string(from: $0 as NSNumber)! }
        print(words) // ["zéro", "soixante-neuf", "cent un", "cinquante-et-un"]
        
        // compter les lettres des chaînes de caractéres
        let countLettersWords = words.map { $0.count }
        print(countLettersWords) // [4, 13, 7, 15]
        
        // convertir des unités de distance (Km en Miles)
        let fromParisKm = ["Marseille":772.0, "Caen":234.0, "Pont lévêque":189.0, "Nantes":380.0]
        let fromParisMiles = fromParisKm.map { name, km in km * 0.621371 }
        print(fromParisMiles) // [479.698412, 236.12098, 145.400814, 117.439119]
        
        // transformer des nombres en chaines de caractères
        let tableDeNombres = [2, 3, 5, 7, 11, 19, 23]
        let tableDeChaine = tableDeNombres.map { String($0) }
        print(tableDeChaine) // ["2", "3", "5", "7", "11", "19", "23"]
        
        // conversion de degré fahrenheit en degré celcius
        let tabFahrenheit = [-60.0, -6.0, 29.0, 100.0, 404.0]
        let tabCelcius = tabFahrenheit.map { ($0 - 32) * 5 / 9 }
        print(tabCelcius) // [-40.0, -20.0, 0.0, 37.0, 100.0]
        
    }
    
    func flatMapUseCases() {
        // .flatMap
        // aplatir un tableau de tableau
        let tabOfTabs = [[5, "AZERTY", 9], ["4", 5, "6"], [7, "8", 9]]
        let tabAPlat = tabOfTabs.flatMap({ $0 })
        print(tabAPlat) // [5, "AZERTY", 9, "4", 5, "6", 7, "8", 9]
        
        // extraire les extrêmes
        let notesParTrimestre = [[15, 8, 12], [5, 13, 10, 19], [14, 9, 12, 10, 16]]
        let meilleuresNotes = notesParTrimestre.flatMap({ $0.filter({ $0 > 14 }) })
        print(meilleuresNotes) // [15, 19, 16]
        
        let becanes = MotardsTab.flatMap( { $0.becanes })
        print(becanes)
        //["Ténéré", "Solex", "Piaggo mp3", "Tracer Yamaha", "Terrot 125", "BWW 1200 RT"]
        let becanesMap = MotardsTab.map( { $0.becanes })
        print(becanesMap)
        // [["Ténéré", "Solex"], ["Piaggo mp3", "Tracer Yamaha", "Terrot 125"], ["BWW 1200 RT"]]
        
        //let beatles: [String?] = ["John", nil, "Paul", nil, "George", "Ringo"]
        //let beatlesNoNil = beatles.flatMap { $0 }  deprecated cause nil dans le tableau
        
        // Mise à plat d'une collection de tableaux d'emojis
        let tout = [ "drapeaux": ["🏴‍☠️", "🏁", "🇫🇷", "🇺🇸"],
                     "fruits": ["🚙", "✈️", "🛵", "🚜"]
        ]
        let mojis = tout.flatMap { $0.value }
        print(mojis) // ["🚙", "✈️", "🛵", "🚜", "🏴‍☠️", "🏁", "🇫🇷", "🇺🇸"]
        
    }
    
    /// <#Description#>
    func compactMapUseCases() {
        
        let beatles: [String?] = ["John", nil, "Paul", nil, "George", "Ringo"]
        let beatlesNoNil2 = beatles.compactMap { $0.map { $0.uppercased()} }
        print(beatlesNoNil2) // ["John", "Paul", "George", "Ringo"]
        
        let enVrac = ["ALLO la base ?", "33", "docteur",  "51"]
        let entiers = enVrac.compactMap { Int($0) }
        // ou encore => let entiers = enVrac.compactMap(Int.init)
        print(entiers)
    }
    
    /// <#Description#>
    func reduceUseCases() {
        let mesGains: [Int] = [230, 540, 350, 700, 450, 300]
        let total = mesGains.reduce(0, +)
        print(total) // 2570
        let total2 = mesGains.reduce(0, { $0 + $1 })
        print(total2)  // 2570
        
        let mesNombres: [Int] = [5, 4, 2, 3]
        let produit = mesNombres.reduce(3, *)
        print(produit) // 360
        let produit2 = mesNombres.reduce(3, { $0 * $1 })
        print(produit2) // 360
        
        let bouts = ["le vif Zéphir"," jubile"," sur les kumqwats"]
        let unBout = bouts.reduce("") { $0 + $1}
        print(unBout) // le vif Zéphir jubile sur les kumqwats
        let unBout2 = bouts.reduce("",+)
        print(unBout2) // le vif Zéphir jubile sur les kumqwats
        
        // calculer une moyenne de note
        let mesNotes = [12.1, 14.3, 10.0, 9.3]
        let moyenne:Double = mesNotes.reduce(0.0) { $0 + ($1 / Double(mesNotes.count)) }
        print(moyenne) // 11.425
    }
    
    func filterUseCases() {
        
        let mesTabDeChiffres = [[4,9,3],[2,12,15],[5,18]]
        let divPar3 = mesTabDeChiffres.flatMap { intArray in intArray.filter { $0 % 3 == 0 }  }
        print(divPar3) // [9, 3, 12, 15, 18]
        
        // tableau des prénoms des  motards de plus 50 ans et plus
        let plusDe50ans = MotardsTab.filter({ $0.age > 49 }).map({ $0.prenom})
        print(plusDe50ans) // ["Robert", "Raymond"]
        
        let nombresPairs  = (0...20).filter { $0.isMultiple(of: 2) }
        print(nombresPairs) // [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
        let nombresImpairs = (0...20).filter { !nombresPairs.contains($0) }
        print(nombresImpairs) // [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
        
    }
    
    
    
}

