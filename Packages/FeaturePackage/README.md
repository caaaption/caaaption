## Package Dependencies
```mermaid
graph TD;
    AppFeature-->WidgetTabFeature;
    AppFeature-->OnboardFeature;
    WidgetSearchFeature-->VoteWidgetFeature;
    WidgetSearchFeature-->POAPWidgetFeature;
    WidgetSearchFeature-->BalanceWidgetFeature;
    WidgetSearchFeature-->GasPriceWidgetFeature;
    AccountFeature-->LinkFeature;
    AccountFeature-->ContributorFeature;
    WidgetTabFeature-->LinkFeature;
    WidgetTabFeature-->AccountFeature;
    WidgetTabFeature-->ContributorFeature;
    WidgetTabFeature-->WidgetSearchFeature;
```