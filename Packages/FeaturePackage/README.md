## Package Dependencies
```mermaid
graph TD;
    AppFeature-->WidgetTabFeature;
    AppFeature-->OnboardFeature;
    WidgetSearchFeature-->VoteWidgetFeature;
    WidgetSearchFeature-->POAPWidgetFeature;
    WidgetSearchFeature-->BalanceWidgetFeature;
    WidgetSearchFeature-->GasPriceWidgetFeature;
    WidgetListFeature-->VoteWidgetFeature;
    WidgetListFeature-->POAPWidgetFeature;
    WidgetListFeature-->BalanceWidgetFeature;
    WidgetListFeature-->GasPriceWidgetFeature;
    AccountFeature-->LinkFeature;
    AccountFeature-->ContributorFeature;
    WidgetTabFeature-->LinkFeature;
    WidgetTabFeature-->AccountFeature;
    WidgetTabFeature-->ContributorFeature;
    WidgetTabFeature-->WidgetSearchFeature;
    AppFeatureTests-->AppFeature;
```