
# # SurveyQuestions

## Description
This is a proposed solution for a CodeChallenge about building an app that shows an Home screen with a button for start a Survey with a certain number of questions to retrieve from an API. When a user insert an answer. The UI will be updated accordingly,

These are Guidelines & Requirements:
Do not waste your time on fancy UI. We are more interested in your code structure decisions. And since our team heavily invests on multiple methods of software verification, unit tests or any other form of testing would be highly appreciated.

## Architecture
The architecture implemented its built on MVVM + Coordinator.
Every screen Its built around a ViewModel and a ViewController, with all the UI managed by a custom UIView attacched to the root of UIViewController. The Coordinator is responsible for the navigation between ViewControllers. BEcause there is no need about some fancy offline functionality, viewmodels are using directly the API services, wiuthout any abstraction layer between persistence and network services (like for example with a Repository pattern).
Every component its built with protocols and dependency injection, for make every piece of logic more reliable and testable.
Because of lack of experience with reactive programming, the current implementation of MVVM it's built around closures, to mimic the behaivor of reactive frameworks. There are Unit Tests for viewmodels and services.

## Notes
For lack of time, Datasource object it's not fully tested and VM for list and cells are not completely decoupled.

## Requirements
Target SDK 16.1. 
Developed on Xcode 14.1

## Installation & Execution
There are no external dependencies, so open the project and run.

## Author

Daniele

## Licenza

SurveyQuestions it's available under MIT License. See LICENSE file for more information
