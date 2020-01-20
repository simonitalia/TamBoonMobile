# TamBoonMobile App

*//App Objective*
- The aim of this app is to allow a user to make a donation to a charity of their choice, from a pre-defined list of curated charities.

**//Development notes**
//general
- App could have been developed with a lot less code and inside main VC, however, since this is a practical test to evaluate knowledge and understanding, I utilized concepts and coding standards that although not necessary, better help demonstrate knowledge
- Used completion handler over delegate protocol to demonstrate knowledge in completion handler methods
- Used a combination of defining data models as structs (value type) and classes (reference type) + initializers to demonstrate knowledge of both types
- In most cases handled errors (network or bad server responses) fro debugging purposes and (if applicable) trigger an Alert to user. In places where error is not handled, used FUTURE placeholder comments to identify where triggering UI Alerts to user could go if building app in full.

**//Tests**
- Wrote some tests and UI tests to demonstrate test knowledge, but obviously tests do not over entirety of app due to time constraints
- Each test ideally should have a single Assert, however for the sake of time, included multiple where appropriate

**//Security**
- GET image from insecure http:
    - Initially intended to force https using URLComponents but since remote server cert doesn’t match the image hosting server, this caused a TLS trust issue. I could have gone the route of securing this (like with SSL pinning) however being a test app, i didn’t. If this was a real world app of course would have. Instead I added an exception only to whitelist the image server domain, rather than an blanket http exception..
- POST donation payload is not submitted securely
- POST donation payload, used mock data except for donation amount which is user generated

**//Version control / Commits**
- Bundled few changes in single commit, but in real world would commit, smaller, independent / isolated changes
- Also worked only in master, where in real world, a new branch would be cerated for each change, tested, then merged into master etc

**//Supported device(s) / iOS Version(s)**
- iPhone (developed with iPhone 11) / iOS 13+

