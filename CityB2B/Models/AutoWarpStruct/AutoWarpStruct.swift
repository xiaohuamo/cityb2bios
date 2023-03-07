import SwiftUI

struct ViewKey<Element>: PreferenceKey {
    typealias Value = [Element]
    static var defaultValue: Value { Value() }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct BindID<ID: Hashable, Value: Hashable>: Hashable {
    let id: ID
    let value: Value
}

struct WidthWithID<ID: Hashable>: ViewModifier {
    typealias Element = BindID<ID, CGFloat>
    let id: ID
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Spacer().preference(
                    key: ViewKey<Element>.self,
                    value: [Element(id: id, value: geo.size.width)]
                )
            }
        )
    }
}

struct FrameWidth: Hashable {
    let frameWidth: CGFloat
}

struct FrameWidthPreference: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Spacer().preference(
                    key: ViewKey<FrameWidth>.self,
                    value: [FrameWidth(frameWidth: geo.size.width)]
                )
            }
        )
    }
}

struct FrameHeight: Hashable {
    let frameHeight: CGFloat
}

struct FrameHeightPreference: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: ViewKey<FrameHeight>.self,
                    value: [FrameHeight(frameHeight: geo.size.height)]
                )
            }
        )
    }
}
