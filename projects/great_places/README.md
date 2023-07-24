<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">Great places</h3>

  <p align="center">
    App for store your favorite places
    <br />
    <a href="https://github.com/HelioPC/flutter_course"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/HelioPC/flutter_course">View Demo</a>
    ·
    <a href="https://github.com/HelioPC/flutter_course/issues">Report Bug</a>
    ·
    <a href="https://github.com/HelioPC/flutter_course/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<!-- <img src="./screenshots/home.png" width=300 height=600 /> -->

An app built from Leonardo's course of Cod3r

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

SDK Flutter and Dart Language.

* [![Flutter][Flutter.dart]][Flutter-url]
* [![Dart][Dart.dart]][Dart-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

To start with, you should have a reasonably powerful machine, say 8GB of RAM.
You must be connected to the internet and have git configured on your machine to be able to clone the repository.
The flutter SDK must be installed and configured, as well as android studio with at least one emulator, to run the mobile application.
To get a local copy up and running follow these simple example steps.

### Prerequisites

* flutter
  ```sh
  flutter upgrade
  ```
  ```sh
  flutter doctor -v
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/HelioPC/flutter_course.git
   ```
2. Navigate to great places directory
   ```sh
   cd projects/great_places
   ```
3. Install flutter packages
   ```sh
   flutter pub get
   ```
4. Create a `.env` file and paste the contents of `.env.example` into it.
   ```sh
   touch .env ; cat .env.example > .env
   ```
5. Edit the `.env` file and add your google maps API
   ```sh
   nano .env
   ```
6. Start an emulator and make sure it's running
   ```sh
   flutter devices
   ```
7. Run the flutter application
   ```sh
   flutter run [-d EMULATOR_ID]
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage
<!--
<img src="./screenshots/form.png" width=300 height=600 />
<img src="./screenshots/submited.png" width=300 height=600 />
<img src="./screenshots/home.png" width=300 height=600 />
<img src="./screenshots/detail.png" width=300 height=600 />
<img src="./screenshots/terminal.png" width=600 height=600 />
-->
`Add later`

_For more examples, please refer to the [Documentation](#acknowledgments)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] List great places
- [x] Add a great place
- [x] Remove a great place
- [x] Detail a great place
  - [x] See great place location on map

See the [open issues](https://github.com/HelioPC/flutter_course/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

My Name - [eliude_c](https://discord.com/) - My discord

Project Link: [https://github.com/HelioPC/flutter_course/tree/main/projects/great_places](https://github.com/HelioPC/flutter_course/tree/main/projects/great_places)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Fultter docs](https://docs.flutter.dev)
* [Google cloud](https://cloud.google.com)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/HelioPC/flutter_course.svg?style=for-the-badge
[contributors-url]: https://github.com/HelioPC/flutter_course/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/HelioPC/flutter_course.svg?style=for-the-badge
[forks-url]: https://github.com/HelioPC/flutter_course/network/members
[stars-shield]: https://img.shields.io/github/stars/HelioPC/flutter_course.svg?style=for-the-badge
[stars-url]: https://github.com/HelioPC/flutter_course/stargazers
[issues-shield]: https://img.shields.io/github/issues/HelioPC/flutter_course.svg?style=for-the-badge
[issues-url]: https://github.com/HelioPC/flutter_course/issues
[product-screenshot]: screenshot/home.png
[Flutter.dart]: https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white
[Flutter-url]: https://flutter.dev/
[Dart.dart]: https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white
[Dart-url]: https://dart.dev