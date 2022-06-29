//
//  ViewController.swift
//  KeyAppUIExample
//
//  Created by Ivan on 09.06.2022.
//

import Algorithms
import BEPureLayout
import KeyAppUI
import UIKit

class ViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let child = build()
        view.addSubview(child)
        child.autoPinEdgesToSuperviewEdges()

        view.backgroundColor = UIColor(red: 0.91, green: 0.92, blue: 0.95, alpha: 1)
    }

    func build() -> UIView {
        BEScrollView(contentInsets: .init(all: 16)) {
            BEVStack {
                TextButton(title: "TableView", style: .ghostLime, size: .medium).onTap {
                    self.present(TableViewController(), animated: true)
                }
                
                SnackBarSection(viewController: self)

                IconSection()

                TypographySection()
                
                // Buttons
                TextButtonSection()
                IconButtonSection()
            }
        }
        .setup { view in view.scrollView.keyboardDismissMode = .onDrag }
    }
}


class TableViewController: UICollectionViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .init(width: UIScreen.main.bounds.width, height: 45)
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        let collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(BaseCell.self, forCellWithReuseIdentifier: "cell")
        
        let view = UIView()
        
        self.view = view
        
        
        view.addSubview(collection)
        collection.autoPinEdgesToSuperviewEdges()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 100 }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BaseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BaseCell? ?? BaseCell(frame: .zero)
        cell.configure(with: cellItem(forRow: indexPath.row)!)
        return cell
    }
    
    func cellItem(forRow: Int) -> BaseCellItem? {
        let rightItem = BaseCellRightViewItem(
            text: nil,
            subtext: nil,
            image: nil,
            isChevronVisible: false,
            badge: nil,
            yellowBadge: nil,
            checkbox: nil,
            `switch`: nil
        )
        
        var item = BaseCellItem(
            title: "Send",
            subtitle: "23.8112 SOL",
            subtitle2: nil,
            image: nil,
            rightView: rightItem
        )
        
        switch forRow {
        case 0:
            item.rightView?.`switch` = true
        case 1:
            item.rightView?.isChevronVisible = true
        case 2:
            item.rightView?.subtext = "23.8112 SOL"
            item.rightView?.isCheckmark = true
        case 3:
            item.rightView?.subtext = "23.8112 SOL"
            item.rightView?.isChevronVisible = true
        case 4:
            item.rightView?.subtext = "23.8112 SOL"
            item.rightView?.image = UIImage(named: "info")!
        case 5:
            item.rightView?.image = UIImage(named: "info")!
        case 6:
            item.rightView?.checkbox = false
        case 7:
            item.rightView?.text = "$190.91"
            item.rightView?.subtext = "23.811 SOL"
        case 8:
            item.rightView?.text = "$190.91"
        case 9:
            item.rightView?.subtext = "23.811 SOL"
        case 11:
            item.rightView?.image = nil
            item.rightView?.badge = "9"
            item.rightView?.isChevronVisible = true
        case 12:
            item.rightView?.badge = "9"
            item.rightView?.subtext = "news"
        case 13:
            item.title = "Send"
            item.subtitle2 = "23.811 SOL\n23.811 SOL"
            item.rightView?.subtext = "23.8112 SOL"
            item.rightView?.isCheckmark = true
        case 14:
            item.title = "Send"
            item.subtitle = nil
            item.subtitle2 = "23.811 SOL\n23.811 SOL"
        case 15:
            item.title = "Send"
            item.subtitle = nil
            item.subtitle2 = "23.811 SOL\n23.811 SOL"
            item.rightView?.badge = "9"
            item.rightView?.isChevronVisible = true
            
        case 16:
            item.title = "Send"
            item.subtitle = nil
            item.subtitle2 = "23.811 SOL\n23.811 SOL"
            item.rightView?.isCheckmark = true
            
        case 17:
            item.title = "Send"
            item.subtitle = nil
            item.subtitle2 = "23.811 SOL\n23.811 SOL"
            item.rightView?.badge = "9"
            item.rightView?.subtext = "news"
            
        case 18:
            item.title = "Send"
            item.subtitle = "23.811 SOL"
            item.subtitle2 = "23.811 SOL"
            item.rightView?.isChevronVisible = true
            
        case 19:
            item.title = "Send"
            item.subtitle = "23.811 SOL"
            item.subtitle2 = "23.811 SOL"
            item.rightView?.isChevronVisible = true
            item.rightView?.subtext = "23.8112 SOL"
            
        case 20:
            item.title = "Send"
            item.subtitle = "23.811 SOL"
            item.subtitle2 = "23.811 SOL"
            item.rightView?.image = UIImage(named: "info")!
            
        case 21:
            item.title = "Send"
            item.subtitle = "23.811 SOL"
            item.subtitle2 = "23.811 SOL"
            item.rightView?.text = "$190.91"
            item.rightView?.subtext = "23.811 SOL"
            
        case 22:
            item.title = "Send"
            item.subtitle = "23.811 SOL"
            item.subtitle2 = "23.811 SOL"
            item.rightView?.subtext = "23.811 SOL"
            
        case 23:
            item.title = "Send"
            item.subtitle = "23.811 SOL"
            item.subtitle2 = "23.811 SOL"
            item.rightView = nil
            
        case 24:
            item.title = "Send"
            item.subtitle = "23.811 SOL"
            item.subtitle2 = "23.811 SOL"
            item.rightView?.isCheckmark = true
            
        case 25:
            item.title = "Send"
            item.subtitle = nil
            item.subtitle2 = "23.811 SOL\n23.811 SOL"
            item.rightView?.yellowBadge = "+$3.75"
            item.rightView?.text = "$192.21"
            
        case 26:
            item.title = "Send"
            item.subtitle = nil
            item.subtitle2 = "23.811 SOL"
            item.rightView?.isChevronVisible = true
            
        case 27:
            item.image = UIImage(named: "heart")
            item.title = "Send"
            item.subtitle = nil
            item.subtitle2 = "23.811 SOL"
            item.rightView?.isChevronVisible = true
            
        case 28:
            item.image = UIImage(named: "heart")
            item.rightView?.subtext = "23.8112 SOL"
            item.rightView?.isCheckmark = true
        case 29:
            item.image = UIImage(named: "heart")
            item.rightView?.subtext = "23.8112 SOL"
            item.rightView?.isChevronVisible = true
        case 30:
            item.image = UIImage(named: "heart")
            item.rightView?.subtext = "23.8112 SOL"
            item.rightView?.image = UIImage(named: "info")!
        case 31:
            item.image = UIImage(named: "heart")
            item.rightView?.image = UIImage(named: "info")!

        default:
            print()
        }
        return item
    }
    
}
