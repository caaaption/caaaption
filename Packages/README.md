```mermaid
graph TD;
    FeaturePackage-->WidgetPackage;
    FeaturePackage-->HelperPackage;
    HelperPackage-->ClientPackage;
    WidgetPackage-->ClientPackage;
    ClientPackage-->GraphQLPackage;
```