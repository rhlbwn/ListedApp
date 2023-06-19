//
//  DashboardViewModel.swift
//  ListedApp
//
//  Created by Rahul Bawane on 18/06/23.
//

import Foundation

enum LandingPageSection {
    case user
    case graph
    case analytics
    case viewAnalytics
    case linkType
    case links
    case viewAllLinks
    case chat
    case faq
}

enum LinkTypes: String {
    case recent = "Recent Links"
    case top = "Top Links"
}

protocol DashboardViewModelToViewProtocol {
    func reloadDashboardData()
}

class DashboardViewModel {
    var sections = [LandingPageSection]()
    var dashboardData: DashboardData?
    var delegate: DashboardViewModelToViewProtocol!
    var selectedLinkType = LinkTypes.recent
    
    func getData() {
        self.sections.removeAll()
        NetworkHelper.shared.dataTask(apiUrl: "dashboardNew", httpMethod: .get, paramms: nil) { success, responseData in
            print(success)
            if let responseData = responseData, success {
                do {
                    let dashboardData = try JSONDecoder().decode(DashboardData.self, from: responseData)
                    print(dashboardData)
                    self.dashboardData = dashboardData
                    self.sections = [.user, .graph, .analytics, .viewAnalytics, .linkType, .links, .viewAllLinks, .chat, .faq]
                    self.delegate.reloadDashboardData()
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData ?? Data(), options: [])
                    print(json)
                    if let json = json as? [String: Any], let message = json["message"] as? String {
                        print(message)
                    } else {
                        print("Something went wrong")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getUserName() -> String {
        return "Rahul Bawane"
    }
    
    func getChartsData() -> [String: Int]? {
        return self.dashboardData?.data.overallURLChart
    }
    
    func getAnalyticsData() -> [String: String] {
        var data = [String: String]()
        data["Total Links"] = "\(self.dashboardData?.totalLinks ?? 0)"
        data["Total Clicks"] = "\(self.dashboardData?.totalClicks ?? 0)"
        data["Today Clicks"] = "\(self.dashboardData?.todayClicks ?? 0)"
        data["Top Source"] = self.dashboardData?.topSource
        data["Top Location"] = self.dashboardData?.topLocation
        return data
    }
    
    func getSelectedLinkType() -> LinkTypes {
        return self.selectedLinkType
    }
    
    func getLinksCount() -> Int {
        if self.selectedLinkType == .recent {
            return self.dashboardData?.data.recentLinks.count ?? 0
        } else {
            return self.dashboardData?.data.topLinks.count ?? 0
        }
    }
    
    func getLinkData(index: Int) -> Link? {
        if self.selectedLinkType == .recent {
            return self.dashboardData?.data.recentLinks[index]
        } else {
            return self.dashboardData?.data.topLinks[index]
        }
    }
}
