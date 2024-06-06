# Coffee App by Lucas West

Hey BrainInHand team, welcome to my Coffee App. Below is a brief rundown of what I've done, I spent around 6 hours creating this app. I hope it meets your expectations!

## Overview

To get started, I first wanted to adopt the same tech stack that you guys use at Brain In Hand, so I got to importing Realm for data persistence. I then also wanted to adhere to the MVVM architecture for two main reasons:

- It's a very simple architecture that works well with this small app.
- Ian mentioned you guys use it in your codebase, so why not!

## Development Process

### Project Scope and API Review

- Scoped the project and reviewed the API via Postman to get an idea of what data I was going to be receiving.

### Network Calls and UI

- Performed network calls and assembled functional views with minimal UI.
- Kept views simple, splitting logic into smaller components to keep the code readable.

### Data Persistence

- Persisted data using Realm, focusing on keeping the implementation straightforward.

### Unit Testing

- Tested data persistence with mock data.
- Conducted unit tests on basic functions and logic to ensure expected outcomes.

While using SwiftUI HostingController limited my ability to test certain navigation behaviours compared to UIKit UIHostingController, I focused on data persistence and basic logic unit tests. Although the Coffee API is beyond our control, these tests serve well for demonstration purposes.

## Challenges and Learnings

A challenge for me was understanding and using Realm, however after spending some time on it I found it to be interesting. There were a lot of crashes! However once I got everything up and running it all flowed smoothly and persisted as I expected.

## Summary

Overall, I believe the app has everything asked for. If I missed anything out, I'd love to know. I have little experience with data persistence, having only briefly touched Core Data, so if what I've done is incorrect or if there's a better approach, I'd love to know why and how!

Thank you for setting it, I look forward to hearing from you soon!
