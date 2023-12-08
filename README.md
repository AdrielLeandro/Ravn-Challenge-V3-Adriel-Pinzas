# Ravn Challenge iOS Application

## Project Overview

This application was created using Swift and UIkit. It is localized in English and Spanish.

### Setup/Running Instructions

1. Open the Xcode project.
2. Build and run the app on your iOS device or simulator.
3. I used Xcode 15.

### Screenshots

<img width="1224" alt="Screenshot 2023-12-08 at 00 50 32" src="https://github.com/AdrielLeandro/Ravn-Challenge-V3-Adriel-Pinzas/assets/49699779/a53a9503-cd83-4d4a-961b-f9770ef1f3d3">

You can find a video [here](./Screenshots/Screen-Recording.mp4).

## Architecture and reasoning

### Architecture

I am using here clean architecture patterns because i think it improves the scalability of the app and separates the logic of the app with the business layer that the app has. Also, it creates layers of abstraction that are needed to be able to change certain layers of the app without affecting the rest of them.

### Testing

Because the classes are conforming protocols, I was able to create mocks for them. I usually use a library called Sourcery, but I also wanted to show that I understand the principles of creating mocks, how they can be used and such.

For testing, I decided to test the main classes that I will be interacting the most like the interactors.

## Libraries used

*Apollo SDK*: I used this one to have the graphql models generated based on the schema presented. In the middle of them and the rest of the app, I created the app own objects, to be sure that if there is a change on the schema or in the query, it doesn't affect the app and the changes can be localized only in certain parts of the app.
