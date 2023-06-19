
## Package Dependencies
```mermaid
graph TD;
    AppFeature-->WidgetTabFeature;
    AppFeature-->OnboardFeature;
    WidgetSearchFeature-->BalanceWidgetFeature;
    WidgetSearchFeature-->VoteWidgetFeature;
    WidgetSearchFeature-->POAPWidgetFeature;
    WidgetSearchFeature-->GasPriceWidgetFeature;
    AccountFeature-->ServerConfig;
    AccountFeature-->ContributorFeature;
    ContributorFeature-->SwiftUIHelpers;
    ContributorFeature-->PlaceholderAsyncImage;
    BalanceWidgetFeature-->SwiftUIHelpers;
    VoteWidgetFeature-->SwiftUIHelpers;
    OnboardFeature-->ServerConfig;
    OnboardFeature-->SwiftUIHelpers;
    POAPWidgetFeature-->SwiftUIHelpers;
    GasPriceWidgetFeature-->SwiftUIHelpers;
    WidgetTabFeature-->WidgetSearchFeature;
    WidgetTabFeature-->AccountFeature;
```