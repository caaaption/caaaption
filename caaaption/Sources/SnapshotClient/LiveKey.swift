import Apollo
import ApolloAPI
import ApolloHelpers
import Dependencies
import Foundation
import SnapshotModel

extension SnapshotClient: DependencyKey {
  public static let liveValue = Self.live()

  public static func live() -> Self {
    let url = URL(string: "https://hub.snapshot.org/graphql")!
    let apolloClient = ApolloClient(url: url)
    return Self(
      proposal: { id in
        let query = SnapshotModel.ProposalQuery(id: id)
        return apolloClient.watch(query: query)
      },
      proposals: { spaceName in
        let query = SnapshotModel.ProposalsQuery(spaceName: spaceName)
        return apolloClient.watch(query: query)
      },
      spaces: {
//        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//          　　　　　　　　　fatalError("フォルダURL取得エラー")
//        }
//
//        if !FileManager.default.fileExists(atPath: NSHomeDirectory() + "/Documents/" + "bookdata.json"){
//          fatalError("JSONが存在しない")
//        }
//
//        let fileURL = dirURL.appendingPathComponent("bookdata.json")
//
//        guard let data = try? Data(contentsOf: fileURL) else {
//          　　　　　　　　fatalError("JSON読み込みエラー")
//        }
//
//        let decoder = JSONDecoder()
//        guard let bookdata = try? decoder.decode([Bookdata].self, from: data) else {
//          fatalError("JSONデコードエラー")
//        }
        
        return []
      }
    )
  }
}
