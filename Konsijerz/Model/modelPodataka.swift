//
//  modelPodataka.swift
//  Konsijerz
//
//  Created by Nikola Ilic on 7.7.23..
//

import Foundation


struct Automobil: Codable {
    var id: Int
    var vozac: String
    var marka: String
    var registracija: String
    var lokacija: String
    var brojOsoba: Int
    var prisutan: Bool
    var vreme: Date
    var vremeIzlaska: Date?
  
    
    init (id: Int,
          vozac: String,
          marka: String,
          registracija: String,
          lokacija: String,
          brojOsoba: Int
          
          
    )
    
    {
        self.id = id
        self.vozac = vozac
        self.marka = marka
        self.registracija = registracija
        self.lokacija = lokacija
        self.brojOsoba = brojOsoba
        self.prisutan = true
        self.vreme = Date()
        self.vremeIzlaska = nil
        
    }

    
    func ukupnoVremeParkiranogVozila() -> TimeInterval {
        guard let izlaznoVreme = self.vremeIzlaska else {
            return 0
        }
        
        return izlaznoVreme.timeIntervalSince(self.vreme)
    }

    

    
}



struct Parking: Codable {
   
    var prisutniParkirani: [Automobil]  {
        return sviParkirani.filter{$0.vremeIzlaska == nil}
    }
    var sviParkirani: [Automobil] = []
    
    
    
    mutating func upisiauto (
                             vozac: String,
                             marka: String,
                             registracija: String,
                             lokacija: String,
                             brojOsoba: Int
                             
                            ) {
                                let id = sviParkirani.count
                                let auto = Automobil(id: id, vozac: vozac, marka: marka, registracija: registracija, lokacija: lokacija, brojOsoba: brojOsoba)
                                sviParkirani.append(auto)
                              
                                 
                                 
                                
                                saveToFile()
                                loadFromFile()
                                
                }
    

    
    func kreirajJSON() -> String {
          let encoder = JSONEncoder()
          guard let encoded = try? encoder.encode(self) else {
            return ""
          }
          guard let json = String(data: encoded, encoding: .utf8) else {
            return ""
          }
         
          return json
          
        }
    
    func getDocumentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
       
      print(paths[0])
       
      return paths[0]
       
    }
    
    
    mutating func loadFromFile() {
        let fileName = getDocumentsDirectory().appendingPathComponent("parking.json")
        
        do {
            let jsonData = try Data(contentsOf: fileName)
            let jsonDecoder = JSONDecoder()
            let objekat = try jsonDecoder.decode(Parking.self, from: jsonData)
            
            self.sviParkirani = objekat.sviParkirani
        } catch {
            print("Greska: \(error)")
        }
    }
    

        
    func saveToFile() {
        let contentToSave = self.kreirajJSON()
        let filename = getDocumentsDirectory().appendingPathComponent("parking.json")
        
        do {
            try contentToSave.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Greska: \(error)")
        }
    }
    

  


    
    mutating func isparkiRajAuto (id: Int) {
        self.sviParkirani[id].prisutan = false
        self.sviParkirani[id].vremeIzlaska = Date()
        
        
        saveToFile()
        
      
    
   }
    
    var brojParkiranih: Int {
        var count = 0
        
        for auto in self.prisutniParkirani {
            count += auto.prisutan ? 1 : 0
        }
        return count
    }
    
    
    var brojIkadaParkiranih: Int {
        return sviParkirani.count
    }
    
    func brojParkiranihZaDatum (datum: Date) -> Int {
        return sviParkirani.count
    }
    
 

    
    
    
  
}


var parkirani = Parking()



