//
//  ViewController.swift
//  Konsijerz
//
//  Created by Nikola Ilic on 7.7.23..
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Parking.jpg")
        backgroundImage.contentMode = .scaleAspectFill
        
        view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        self.mojaTabela.dataSource = self
        self.mojaTabela.delegate = self
        
        mojaTabela.tintColor = .brown
        
        parkirani.loadFromFile()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkirani.prisutniParkirani.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celija = tableView.dequeueReusableCell(withIdentifier: "cell")
        let izabraniAuto = parkirani.prisutniParkirani[indexPath.row]
        celija?.textLabel?.text = izabraniAuto.marka
        celija?.detailTextLabel?.text = izabraniAuto.registracija
      
        return celija!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imeVozaca.text = parkirani.prisutniParkirani[indexPath.row].vozac
        brojRegistracije.text = parkirani.prisutniParkirani[indexPath.row].registracija
        brojOsoba.text = String(parkirani.prisutniParkirani[indexPath.row].brojOsoba)
        markaAuta.text = parkirani.prisutniParkirani[indexPath.row].marka
        lokacijaAuta.text = parkirani.prisutniParkirani[indexPath.row].lokacija
        
    }
    
    
    
    @IBOutlet weak var mojaTabela: UITableView!
    
    
    @IBOutlet weak var imeVozaca: UITextField!
    
    @IBOutlet weak var brojRegistracije: UITextField!
    
    
    @IBOutlet weak var brojOsoba: UITextField!
    
    
    @IBOutlet weak var markaAuta: UITextField!
    
    @IBOutlet weak var lokacijaAuta: UITextField!
    
    
  
    
    
    @IBAction func acDodati(_ sender: Any) {
        dodati ()
    }
    
    @IBAction func acIzbrisati(_ sender: Any) {
        izbrisati ()
    }
    
    func dodati() {
        guard let vozacIme = imeVozaca.text,
              let registracijaBroj = brojRegistracije.text,
              let osobeBrojTekst = brojOsoba.text,
              let brojOsoba = Int(osobeBrojTekst),
              let marka = markaAuta.text,
              let lokacija = lokacijaAuta.text
            
             
        else {
            print("Pogrešno uneti podaci")
            return
        }

        
        reset()
        parkirani.upisiauto(vozac: vozacIme, marka: marka, registracija: registracijaBroj, lokacija: lokacija, brojOsoba: brojOsoba)
        
        parkirani.saveToFile()
        
        
        self.mojaTabela.reloadData()
        azurirajPrikazParkingMesta()
    }
    
    func reset () {
        imeVozaca.text = ""
        self.brojOsoba.text = ""
        brojRegistracije.text = ""
        markaAuta.text = ""
        lokacijaAuta.text = ""
        brojParkiranihVozila.text = ""
        
    }

    func izbrisati() {
        if let selectedRow = self.mojaTabela.indexPathForSelectedRow?.row {
           let a = parkirani.prisutniParkirani[selectedRow].id
          
            for i in 0...parkirani.sviParkirani.count - 1 {
                if parkirani.sviParkirani[i].id == a {
                    parkirani.sviParkirani[i].vremeIzlaska = Date()
                    
                }
            }
           
            
            mojaTabela.reloadData()
        }
        
       
        
        reset()
        

        self.mojaTabela.reloadData()
        
        azurirajPrikazParkingMesta()
        parkirani.saveToFile()
    }


    func formatirajVreme(_ vreme: TimeInterval) -> String {
        let sati = Int(vreme) / 3600
        let minuti = (Int(vreme) % 3600) / 60
      
        
        return String(format: "%02d:%02d", sati, minuti)
    }


    func azurirajPrikazParkingMesta() {
        let parkiraniAutomobili = parkirani.brojParkiranih
    
        brojParkiranihVozila.text = "\(parkiraniAutomobili)"
    }
    
   
    
    

        
   
    
    @IBOutlet weak var lokacijaParkingMesta: UITextField!
    
    
    @IBOutlet weak var brojParkiranihVozila: UITextField!
    
    
    @IBOutlet weak var vremeParkingaLabel: UILabel!
    
    
    
    
    
    @IBOutlet weak var pretragaVozila: UITextField!
    
   
   
    @IBAction func acPretraga(_ sender: Any) {
        pretraga()
    }
    

    func pretraga() {
        let pretraziti = pretragaVozila.text ?? ""
        let rezultati = parkirani.prisutniParkirani.filter { $0.registracija == pretraziti || $0.vozac == pretraziti }
        lokacijaParkingMesta.text = rezultati.first?.lokacija ?? "Nema rezultata"
        pretragaVozila.text = ""

    }
    
    
   



    
    
    
    
    }
      
    
    
    
    
    
    


