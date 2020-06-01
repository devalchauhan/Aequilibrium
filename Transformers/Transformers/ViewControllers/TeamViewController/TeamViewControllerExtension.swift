//
//  TeamViewControllerExtension.swift
//  Transformers
//
//  Created by Deval Chauhan on 01/06/20.
//  Copyright © 2020 Deval. All rights reserved.
//

import MYPassthrough
extension TeamViewController {
    func configuration() {
        PassthroughManager.shared.labelCommonConfigurator = {
            labelDescriptor in
            
            labelDescriptor.label.font = .systemFont(ofSize: 18)
            labelDescriptor.widthControl = .precise(300)
        }
        PassthroughManager.shared.infoCommonConfigurator = {
            infoDescriptor in
            
            infoDescriptor.label.font = .systemFont(ofSize: 18)
            infoDescriptor.widthControl = .precise(300)
        }
        PassthroughManager.shared.closeButton.setTitle("Skip", for: .normal)
    }
    func appGuide() {
        configuration()
        PassthroughManager.shared.display(tasks: [intro(),createTransformerIntro(),editDeleteTranformerIntro(),warIntro()]) {
            isUserSkipDemo in
        }
    }
    func intro() -> PassthroughTask {
        let infoDesc = InfoDescriptor(for: "Welcome to the demo of Transformers. Let's see what it can do. Tap the screen")
        var infoTask = PassthroughTask(with: [])
        infoTask.infoDescriptor = infoDesc
        return infoTask
    }
    func createTransformerIntro() -> PassthroughTask {
        let infoDesc = InfoDescriptor(for: "You can create new Transformers by clicking plus icon located at top right corner of navigation bar.")
        var infoTask = PassthroughTask(with: [])
        infoTask.infoDescriptor = infoDesc
        return infoTask
    }
    func editDeleteTranformerIntro() -> PassthroughTask {
        let infoDesc = InfoDescriptor(for: "You can edit / delete Transformers by swiping cell from right to left once you create the Transformers.")
        var infoTask = PassthroughTask(with: [])
        infoTask.infoDescriptor = infoDesc
        return infoTask
    }
    func warIntro() -> PassthroughTask {
        let infoDesc = InfoDescriptor(for: "You can start battle between Transformers by clicking WAR button located at center bottom.")
        var infoTask = PassthroughTask(with: [])
        infoTask.infoDescriptor = infoDesc
        return infoTask
    }
}
