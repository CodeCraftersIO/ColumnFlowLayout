//
//  Created by Pierluigi Cifani on 20/09/2018.
//  Copyright © 2018 The Left Bit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        return UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
    }()

    var flowLayout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.pinToSuperview()
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        cell.configureFor(viewModel: self.mockData[indexPath.item])
        return cell
    }
}


extension ViewController {
    var mockData: [PostCollectionViewCell.VM] {
        return [
            PostCollectionViewCell.VM(
                photo: UIImage(named: "post1")!,
                title: "Pork tail",
                description: "Bacon ipsum dolor amet ground round ham shoulder burgdoggen. Swine ribeye brisket pork belly bresaola strip steak ground round ham turducken capicola corned beef filet mignon jowl spare ribs",
                authorName: "Code Crafters",
                authorAvatar: UIImage.init(named: "codecrafters")!
            ),
            PostCollectionViewCell.VM(
                photo: UIImage(named: "post2")!,
                title: "Meatball",
                description: "Tenderloin frankfurter ham kielbasa short loin tri-tip kevin tongue beef ribs boudin.",
                authorName: "Code Crafters",
                authorAvatar: UIImage(named: "codecrafters")!
            ),
            PostCollectionViewCell.VM(
                photo: UIImage(named: "post3")!,
                title: "T-bone",
                description: "Spare ribs porchetta landjaeger pork filet mignon swine leberkas tri-tip venison pork loin alcatra turducken brisket kielba.",
                authorName: "Code Crafters",
                authorAvatar: UIImage(named: "codecrafters")!
            ),
            PostCollectionViewCell.VM(
                photo: UIImage(named: "post4")!,
                title: "Capicola ground round rump shank",
                description: "Biltong shankle venison swine. Doner short loin venison, alcatra buffalo beef burgdoggen. Swine beef ribs turducken, rump pig beef filet mignon landjaeger.",
                authorName: "Code Crafters",
                authorAvatar: UIImage(named: "codecrafters")!
            ),
            PostCollectionViewCell.VM(
                photo: UIImage(named: "post5")!,
                title: "Drumstick",
                description: "Pancetta bresaola leberkas, buffalo meatball alcatra swine chicken ham hock chuck. Ground round t-bone buffalo, strip steak meatball chuck tenderloin burgdoggen ball tip jowl fatback tongue tail.",
                authorName: "Code Crafters",
                authorAvatar: UIImage(named: "codecrafters")!
            )
        ]
    }
}
