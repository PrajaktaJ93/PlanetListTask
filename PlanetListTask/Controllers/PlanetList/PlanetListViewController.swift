//
//  PlanetListViewController.swift
//  PlanetListTask
//
//  Created by Prajakta on 09/05/23.
//

import UIKit

class PlanetListViewController: UIViewController  {
  
    var planetViewModel = PlanetViewModel()
    @IBOutlet weak var planetListTblView: UITableView!
    
    func setUpViewController() {
        self.navigationItem.title = AppStrings.planetList
        planetListTblView.register(UINib.init(nibName: "PlanetListTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: "PlanetListTableViewCell")
    }
    
    init(planetViewModel: PlanetViewModel) {
        self.planetViewModel = planetViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewController()
        self.callPlanetList(url: Application.URLs.getPlanetsData)
    }
    
    func callPlanetList(url: String) {
        self.planetViewModel.getPlanetList(url: url) {[weak self] list in
            self?.planetViewModel.arrPlanet = list!
            DispatchQueue.main.async {
                self?.planetListTblView.reloadData()
            }
        }
    }
}

extension PlanetListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.planetViewModel.arrPlanet.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetListTableViewCell", for: indexPath) as! PlanetListTableViewCell
        let planet = self.planetViewModel.arrPlanet[indexPath.row]
        cell.setUpCell(Planet: planet)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.planetViewModel.arrPlanet.count - 1 && self.planetViewModel.nextPageUrl != "") {
            self.callPlanetList(url: self.planetViewModel.nextPageUrl)
        }
    }

}

