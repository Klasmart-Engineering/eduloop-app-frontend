# Eduloop Quiz App

A prototype application build in flutter for the web but with the foundations to expand to other platforms.

Core feature is being able to add local users and take part in a quiz answering multiple choice questions and try to get a new highscore! (There is confetti!)
## Getting Started

This project is currently setup as a web application with deployment configuration for VSCode. 

Note: Flutter web apps do not currently have access to flavours like IOS and Android can, so an [alternative has been implemented](https://sebastien-arbogast.com/2022/05/02/multi-environment-flutter-projects-with-flavors/#Preparing_Your_Web_App).
## In VS Code
You can choose to run this in dev or prod mode using one of the VS Code task configurations, these use the underlying bash scripts detailed in the terminal section.
## By Terminal 
In the task folder you will find some bash scripts to make running the solution in your prefered environment easier. 

### Web

As mentioned earlier, web does not support flavours so we provide a way to: 
1) Provide seperate entry points (and configuration) for development and production
2) Provide different assets, for example a different favicon to help you identify the dev site. 

The purpose of these small bash scripts is to ensure when building to dev or production, we target the right entry point and also copy any environment-specific files over before running the solution or building it. 

#### run_dev / run_prod
Run in your terminal at the base of the repo:
```sh tasks/web/run_dev.sh```

#### build_dev 
At present we only have a github pages environment that hosts the dev build, so you must commit the built assets after you run this command. 

```sh tasks/build_dev.sh```
