//
//  ContentView.swift
//  ListOfEmailApps
//
//  Created by Vladimir Stasenko on 03.02.2023.
//

import SwiftUI

struct ContentView: View {

    var listOfMailApps = [MailAppModel]()
    @State var isConfirming = false

    var body: some View {
        VStack {
            Button {
                self.isConfirming = true
            } label: {
                Text("Check my inbox")
            }
            .confirmationDialog("User is choosing email app to navigate",
                                isPresented: $isConfirming,
                                presenting: listOfMailApps) { apps in
                ForEach(listOfMailApps) { app in
                    Button {
                        UIApplication.shared.open(app.urlScheme)
                    } label: {
                        Text(app.name)
                    }
                }

            } message: { detail in
                Text("Choose mail app")
            }
        }
    }

    init() {
        listOfMailApps = getListOfMailApps()
    }

    func getListOfMailApps() -> [MailAppModel] {
        var listOfMailApps = [MailAppModel]()
        let mailUrl = URL(string: "mailto://")!
        let gmailUrl = URL(string: "googlegmail://")!
        let yahooMail = URL(string: "ymail://")!
        let outlookUrl = URL(string: "ms-outlook://")!
        let airmailUrl = URL(string: "airmail://")!

        if UIApplication.shared.canOpenURL(mailUrl) {
            listOfMailApps.append(MailAppModel(name: "Apple Mail", urlScheme: mailUrl))
        }
        if UIApplication.shared.canOpenURL(gmailUrl) {
            listOfMailApps.append(MailAppModel(name: "Google Mail", urlScheme: gmailUrl))
        }
        if UIApplication.shared.canOpenURL(yahooMail) {
            listOfMailApps.append(MailAppModel(name: "Yahoo Mail", urlScheme: yahooMail))
        }
        if UIApplication.shared.canOpenURL(outlookUrl) {
            listOfMailApps.append(MailAppModel(name: "Outlook", urlScheme: outlookUrl))
        }
        if UIApplication.shared.canOpenURL(airmailUrl) {
            listOfMailApps.append(MailAppModel(name: "Air mail", urlScheme: airmailUrl))
        }

        return listOfMailApps
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MailAppModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let urlScheme: URL
}
