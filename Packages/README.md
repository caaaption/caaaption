```mermaid
graph TD;
    FeaturePackage-->WidgetPackage;
    FeaturePackage-->HelperPackage;
    WidgetPackage-->ClientPackage;
    ClientPackage-->GraphQLPackage;
```