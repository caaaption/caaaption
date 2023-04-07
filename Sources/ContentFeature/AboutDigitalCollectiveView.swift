import SwiftUI

struct AboutDigitalCollectiveView: View {
  var body: some View {
    Text("about digital collectibles")
      .font(.footnote)
      .foregroundColor(Color.systemGray2)

    Spacer().frame(height: 8)

    Text("ZINE - Seeding Infinite Games with Eternal")
      .font(.title3)
      .bold()

    Spacer().frame(height: 8)

    Text("by 0x50aF...6513")

    Spacer().frame(height: 12)

    Text("Eternal’s Reggie James and Zora’s Dee Goens and Jacob Horne chat semiotic technology in the Eternal Studio in New York City, November 2022.\nhttps://zine.zora.co/eternal-reggie-james")
      .font(.footnote)
      .foregroundColor(Color.systemGray2)

    HStack(spacing: 4) {
      Color.red
        .frame(width: 24)
      Color.blue
        .frame(width: 24)
      Color.green
        .frame(width: 24)
      Text("+8 others minted")
        .font(.footnote)
    }
    .frame(height: 24)
  }
}

struct AboutDigitalCollectiveViewPreviews: PreviewProvider {
  static var previews: some View {
    Text("Hello, world!")
  }
}
