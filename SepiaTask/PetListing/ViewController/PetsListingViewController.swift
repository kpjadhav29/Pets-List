//
//  ViewController.swift
//  SepiaTask
//
//  Created by Kiran Jadhav on 29/11/22.
//

import UIKit

class PetsListingViewController: UIViewController {

    @IBOutlet weak var petsTableview: UITableView!
    lazy var petsVM: PetsViewModel = {
            return PetsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPetsData()
    }

}

extension PetsListingViewController{
    
    func getPetsData(){
        self.title = String.petsNavtitle
        petsVM.getPetsData()
        self.petsTableview.reloadData()
    }
    
}

extension PetsListingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsVM.arrPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.petSTableViewCellIdentifire) as? PetsTableViewCell
        cell!.setupData(petData: petsVM.arrPets[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PetsDetailViewController.instanceFromStoryboard(contentURL: petsVM.arrPets[indexPath.row].content_url!)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
