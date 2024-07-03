# Pokemon App

                                                    
                                  📱🐱‍👤🐉💻 Pokemon Application Documentation 📱🐱‍👤🐉💻
                                  
                                  
## Overview

Welcome to the Pokemon App! This app is designed to provide users with a comprehensive Pokedex, details about various items, 
and information on different regions within the Pokemon universe. Built with Flutter, this app ensures a smooth and responsive user 
experience, with features tailored for Android devices.

## Features

⚪ Pokedex:

    ◽ View a list of Pokemon.
    ◽ Search for Pokemon by name.
    ◽ Click on a Pokemon to see detailed information, including a voice description that can be toggled on/off in the settings.

⚪ Items:

    ◽ View a list of all items.
    ◽ Click on an item to see detailed information and related items, including a voice description.
    
⚪ Regions:

    ◽ View a list of regions.
    ◽ Click on a region to see locations, species of Pokemon found in that region, and types of Pokemon.
    

## Installation

### Prerequisites

◽ Ensure you have Flutter installed. You can download it from Flutter's official website.
◽ Make sure your Android device or emulator is set up for development.

### Steps

1. Clone the repository:
   git clone [https://github.com/EmmaDev-1/Pokedex.git](https://github.com/EmmaDev-1/Pokedex.git)
   
2. Navigate to the project directory:
  cd Pokedex

3. Install dependencies:
  flutter pub get

4. Run the app on your Android device or emulator:
     flutter run


## App Structure

This app follows the MVVM (Model-View-ViewModel) design pattern, ensuring a clean and maintainable codebase.

◽ Provider: Used for state management.
◽ http: Used for making network requests.
◽ cached_network_image: Used for efficient image loading and caching.
◽ flutter_tts: Used for text-to-speech functionalities.


## minSdkVersion

◽ The minimum SDK version required to run this app is 21.


## Usage

### Pokedex

◽ Navigate to the Pokedex section to see a list of Pokemon.
◽ Use the search bar to find Pokemon by name.
◽ Click on a Pokemon to view detailed information and hear a voice description, which can be disabled in the settings.

### Items

◽ Navigate to the Items section to see a list of items.
◽ Click on an item to view detailed information and related items, with an option for a voice description.

### Regions

◽ Navigate to the Regions section to see a list of regions.
◽ Click on a region to view locations, species of Pokemon, and types of Pokemon found there.


## Version Control

This project uses Git for version control. You can find the repository on GitHub: [My Repositories](https://github.com/EmmaDev-1?tab=repositories)


## Contributing

If you wish to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature-branch).
3. Make your changes and commit them (git commit -m 'Add some feature').
4. Push to the branch (git push origin feature-branch).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
