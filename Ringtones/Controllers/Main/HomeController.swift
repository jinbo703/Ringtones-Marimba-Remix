//
//  HomeController.swift
//  Music
//
//  Created by PAC on 9/26/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit
import ImageSlideshow


class HomeController: UIViewController {
    
    let cellId = "cellId"
    let cellHeaderId = "cellHeaderId"
    
    
    var songs = [SongItem]()
    var filteredSongs = [SongItem]()
    var tempSongs = [SongItem]()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK setup UI
    
    
    
    lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Featured", "Recent"])
        segment.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
//        segment.tintColor = StyleGuideManager.buttonTintColor
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(handleSegementControl), for: .valueChanged)
        return segment
    }()
    
    lazy var songsTableView: UITableView = {
        let frame = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT)
        let tableView = UITableView(frame: frame, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        self.getSongs()
        
//        self.checkIfUserLoggedIn()
        
        self.setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchController.isActive = false
    }
    
    
    private func getSongs() {
        songs = MusicMethods.getSongs()
        filteredSongs = MusicMethods.getSongs()
        tempSongs = MusicMethods.getSongs()
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
}

//MARK: handle tableview delegate

extension HomeController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongCell
        
        let song = filteredSongs[indexPath.row]
        cell.song = song
        
        let checkState = SongArrays.checkState[indexPath.row]
        if checkState == 0 {
            cell.statusImageView.tintColor = StyleGuideManager.buttonTintColor
        } else {
            cell.statusImageView.tintColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SongCell
        cell.statusImageView.tintColor = .clear
        
        SongArrays.checkState[indexPath.row] = 1
        
        UserDefaults.standard.set(SongArrays.checkState, forKey: "states")
        UserDefaults.standard.synchronize()
        
        self.handleGoingToSongPlayController(index: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            return 90
        } else if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            return 60
        }
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let frame = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: 300)
        let imageSlideShow = ImageSlideshow(frame: frame)
        
        let localSource = [ImageSource(imageString: AssetName.popImage.rawValue)!, ImageSource(imageString: AssetName.danceImage.rawValue)!, ImageSource(imageString: AssetName.hiphopImage.rawValue)!, ImageSource(imageString: AssetName.rnbImage.rawValue)!]
        
        imageSlideShow.backgroundColor = UIColor.white
        imageSlideShow.slideshowInterval = 5.0
        imageSlideShow.pageControlPosition = PageControlPosition.underScrollView
        imageSlideShow.pageControl.currentPageIndicatorTintColor = StyleGuideManager.buttonTintColor
        imageSlideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        imageSlideShow.setImageInputs(localSource)

        return imageSlideShow
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let image = UIImage(named: AssetName.popImage.rawValue)
        let imageWidth = image?.size.width
        let imageHeight = image?.size.height
        let height = (imageHeight! * DEVICE_WIDTH) / imageWidth!
        
        return height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func updateSearchResults(for searchController: UISearchController) {

//        self.searchController.searchBar.showsCancelButton = true
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            
            filteredSongs = tempSongs.filter {
                team in return (team.songTitle.lowercased().contains(searchText.lowercased()))
            }
        } else {
            
            filteredSongs = tempSongs
        }
        
        songsTableView.reloadData()
    }
    
}

//MARK: handle activity
extension HomeController {
    @objc fileprivate func handleActivity() {
        
//        self.searchController.searchBar.resignFirstResponder()
//        self.searchController.searchBar.showsCancelButton = false
        
        let url = URL(string: "https://www.facebook.com/MarimbaRemixes/")
        
        if let url = url {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: [JLYoutubeActivity()])
            present(activityViewController, animated: true, completion: nil)
        }
    }
}

//MARK: handle goingto songPlayController
extension HomeController {
    
    fileprivate func handleGoingToSongPlayController(index: Int) {
        
        let song = filteredSongs[index]
        
        let songPlayController = SongPlayController()
        songPlayController.song = song
        songPlayController.currentSongIndex = index
        songPlayController.songs = filteredSongs
        navigationController?.pushViewController(songPlayController, animated: true)
        
    }
    
}

//MARK: handle segementControll(watchlist and trending)

extension HomeController {
    
    @objc fileprivate func handleSegementControl() {
        print("selected:", segmentControl.selectedSegmentIndex)
        
        filteredSongs.removeAll()
        tempSongs.removeAll()
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            filteredSongs = MusicMethods.getSongs()
            
        } else {
            for i in 0 ..< songs.count {
                if SongArrays.checkState[i] == 1 {
                    filteredSongs.append(songs[i])
                }
            }
        }
        tempSongs = filteredSongs
        
        self.songsTableView.reloadData()
        
    }
    
    
}

//MARK: check user loged in
extension HomeController {
    
    fileprivate func checkIfUserLoggedIn() {
        self.handleLogOff()
    }
    
    @objc fileprivate func handleLogOff() {
        
        let loginController = LoginController()
        
        let navController = UINavigationController(rootViewController: loginController)
        self.present(navController, animated: false, completion: nil)
        
//        navigationController?.present(loginController, animated: false, completion: nil)
        
    }
    
}

//MARK: handle setting and logout
extension HomeController {
    
    @objc fileprivate func handleSetting() {
        
        let infoController = InfoController()
        navigationController?.pushViewController(infoController, animated: true)
        
    }
    
    @objc fileprivate func handleLogout() {
        self.showErrorAlertWithOKCancel(nil, message: AlertMessages.logoutAlertMessage.rawValue, actionBtnTitle: "Yes", otherBtnTitle: "No", action: { (action) in
            self.handleLogOff()
        }, completion: nil)
    }
    
}

//MARK: setupViews
extension HomeController {
    
    fileprivate func setupViews() {
        self.setupBackground()
        self.setupNavBar()
        self.setupTableview()
        self.setupCarouselViews()
    }
    
    private func setupCarouselViews() {
        
    }
    
    private func setupTableview() {
        
        view.addSubview(songsTableView)
        
        songsTableView.register(SongCell.self, forCellReuseIdentifier: cellId)
//        songsTableView.register(SongCellHeader.self, forHeaderFooterViewReuseIdentifier: cellHeaderId)
        
        songsTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        songsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        songsTableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor, constant: 0).isActive = true
        songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        songsTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search"
    }
    
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupNavBar() {
        
        let settingImage = UIImage(named: AssetName.informationIcon.rawValue)
        let settingButton = UIBarButtonItem(image: settingImage, style: .plain, target: self, action: #selector(handleSetting))
        settingButton.tintColor = StyleGuideManager.buttonTintColor
        navigationItem.rightBarButtonItem = settingButton
        
//        let logoutImage = UIImage(named: AssetName.logoutIcon.rawValue)
//        let logoutButton = UIBarButtonItem(image: logoutImage, style: .plain, target: self, action: #selector(handleLogout))
//        logoutButton.tintColor = StyleGuideManager.buttonTintColor
//        navigationItem.leftBarButtonItem = logoutButton
        
        let uploadImage = UIImage(named: AssetName.uploadIcon.rawValue)
        let uploadButton = UIBarButtonItem(image: uploadImage, style: .plain, target: self, action: #selector(handleActivity))
        uploadButton.tintColor = StyleGuideManager.buttonTintColor
        navigationItem.leftBarButtonItem = uploadButton
        
        navigationItem.titleView = segmentControl
    }
    
    
    
}
