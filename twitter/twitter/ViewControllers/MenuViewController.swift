//
//  MenuViewController.swift
//  twitter
//
//  Created by christopher ketant on 11/5/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct ContainerizedViewController {
        var title: String!
        var viewController: UIViewController!
    }
    @IBOutlet weak var tableView: UITableView!
    private var timelineViewNavigationController: UIViewController!
    private var profileViewNavigationController: UIViewController!
    private var mentionsViewNavigationController: UIViewController!
    var hamburgerViewController: HamburgerViewController!
    var viewControllers: [ContainerizedViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.timelineViewNavigationController = storyboard.instantiateViewController(
            withIdentifier: "timelineNavigationController"
        )
        self.profileViewNavigationController = storyboard.instantiateViewController(
            withIdentifier: "profileNavigationController"
        )
        
        var containerizedTimeline = ContainerizedViewController()
        containerizedTimeline.title = "Timeline"
        containerizedTimeline.viewController = self.timelineViewNavigationController
        var containerizedProfile = ContainerizedViewController()
        containerizedProfile.title = "Me"
        containerizedProfile.viewController = self.profileViewNavigationController
        
        self.viewControllers.append(containerizedTimeline)
        self.viewControllers.append(containerizedProfile)
        self.hamburgerViewController.contentViewController = self.profileViewNavigationController
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! MenuTableViewCell
        let containerizedViewController = self.viewControllers[indexPath.row]
        cell.menuTitleLabel.text = containerizedViewController.title
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.hamburgerViewController.contentViewController = self.viewControllers[indexPath.row].viewController
    }
}
