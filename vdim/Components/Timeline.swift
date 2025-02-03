//
//  Timeline.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/5.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {
    
    // MARK: - 界面元素
    private let tableView = UITableView()
    
    // MARK: - 数据相关
    private var dataArray = [String]()       // 数据源
    private var currentPage = 1              // 当前页码
    private var isLoading = false            // 是否正在加载
    private var hasMoreData = true           // 是否还有更多数据
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadInitialData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - 数据加载
    private func loadInitialData() {
        // 模拟首次加载数据
        dataArray = (1...20).map { "Item \($0)" }
        tableView.reloadData()
    }
    
    // MARK: - 加载更多数据
    private func loadMoreData() {
        guard !isLoading, hasMoreData else { return }
        
        isLoading = true
        tableView.tableFooterView = createFooterView()
        
        // 模拟网络请求（实际项目替换为真实API调用）
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            let newData = (1...20).map { "Item \(self.dataArray.count + $0)" }
            
            DispatchQueue.main.async {
                self.dataArray.append(contentsOf: newData)
                self.tableView.reloadData()
                self.currentPage += 1
                self.isLoading = false
                self.tableView.tableFooterView = nil
                
                // 模拟数据加载完毕的情况（真实项目根据API返回判断）
                if self.currentPage >= 5 {
                    self.hasMoreData = false
                }
            }
        }
    }
    
    // MARK: - 底部加载视图
    private func createFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = footerView.center
        activityIndicator.startAnimating()
        footerView.addSubview(activityIndicator)
        return footerView
    }
}

// MARK: - UITableView协议实现
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
}

// MARK: - 滚动检测逻辑
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        // 检测滚动到底部的条件（距离底部100pt时触发）
        if position > (contentHeight - screenHeight - 100) {
            loadMoreData()
        }
    }
}

struct Timeline: View {
    @StateObject private var networkManager = NetworkManager()
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Spacer(minLength: 12)
                ForEach(networkManager.threads, id: \.id) { thread in
                    HStack {
                        VStack (alignment: .leading, spacing: 14){
                            HStack {
                                AvatarView(url: thread.author.avatar, size: 36)
                                VStack (alignment: .leading, spacing: 6){
                                    Text(thread.author.name)
                                        .font(.system(size: 16))
                                    // TODO: Compiler is unable to typ-check in reasonable time;
//                                    Text(formatRelativeDate(thread.createdAt))
//                                        .font(.system(size: 13))
//                                        .foregroundStyle(.subheadline)
                                }
                            }
                            Text(thread.title)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 14)
                    .background(in: RoundedRectangle(cornerRadius: 6))
                }
                VStack {
                    Text("已经到底啦Σ(っ °Д °;)っ")
                        .padding(.top, 32)
                    Spacer()
                }
                .frame(width: screenSize.width - 24, height: 160)
            }
            .padding(.horizontal, 12)
            .onAppear {
                networkManager.fetchThreads()
            }
        }
    }
}

#Preview {
    HomeView()
}

