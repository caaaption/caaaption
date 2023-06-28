## Package Dependencies
```mermaid
graph TD;
    AppFeature-->WidgetTabFeature;
    AppFeature-->OnboardFeature;
    WidgetSearchFeature-->AnalyticsReducer;
    WidgetSearchFeature-->BalanceWidgetFeature;
    WidgetSearchFeature-->VoteWidgetFeature;
    WidgetSearchFeature-->POAPWidgetFeature;
    WidgetSearchFeature-->GasPriceWidgetFeature;
    AccountFeature-->LinkFeature;
    AccountFeature-->ContributorFeature;
    ContributorFeature-->SwiftUIHelpers;
    ContributorFeature-->PlaceholderAsyncImage;
    BalanceWidgetFeature-->SwiftUIHelpers;
    VoteWidgetFeature-->SwiftUIHelpers;
    OnboardFeature-->SwiftUIHelpers;
    POAPWidgetFeature-->SwiftUIHelpers;
    GasPriceWidgetFeature-->SwiftUIHelpers;
    WidgetTabFeature-->WidgetSearchFeature;
    WidgetTabFeature-->AccountFeature;
```