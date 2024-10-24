<img src="https://skillicons.dev/icons?i=flutter,dart" />
<br>

# Fixer App
Fixer App is a mobile application built using Flutter that provides users with real-time currency exchange rates, currency conversions, and historical exchange data. The app integrates seamlessly with the Fixer Backend to deliver up-to-date financial information on the go.

## Table of Contents
1. Overview
2. Features
3. Installation
4. Configuration
5. Screenshots
6. Contributing
7. License
   
## Overview
The Fixer App is designed to offer a simple and intuitive user experience for accessing currency exchange rates and performing currency conversions. Built using Flutter, the app runs on both iOS and Android devices. It connects to the Fixer Backend to fetch real-time data and provides users with additional features like historical rates for financial analysis.

## Features
Real-time currency rates: Get the latest exchange rates from various currencies.

Currency converter: Quickly convert amounts between different currencies.

Historical exchange rates: View past exchange rates for specific dates.

Favorites: Save your most frequently used currencies for quick access.

Responsive UI: A sleek and intuitive design with dark mode support.

## Installation
To set up the Fixer App on your local machine, follow these steps:

1. Clone the repository: ```git clone https://github.com/Cominde/fixer_app.git```
2. Navigate into the project directory: ```cd fixer_app```
3. Install dependencies: ```flutter pub get```
4. Set up your backend connection and necessary API keys (see Configuration).
5. Run the app on an emulator or physical device: ```flutter run```
   
## Configuration
Before running the app, ensure you have the necessary API keys from the Fixer Backend and configure them in the app. You will need to set up the API URL and key in your project settings.

1. Create a .env file in the root directory of the project.
2. Add your configuration variables:
````
API_URL=https://api.fixer.io
API_KEY=your_api_key
````
3. Make sure the backend is up and running to fetch real-time data.

## Screenshots
Here are some sample screenshots of the Fixer App:

### Onbourding Screen
<img src="https://github.com/user-attachments/assets/fe70e012-36d6-4b03-bdf6-d1b37f91efde" alt="Onbourding Screen" width="300">

### Sign-in Screen
<img src="https://github.com/user-attachments/assets/c83798bc-643d-47f3-a6b2-a148513c0b73" alt="Sign-in Screen" width="300">
<img src="https://github.com/user-attachments/assets/4c44f747-b693-48d2-bf7b-c86b620398da" alt="Sign-in Screen" width="300">

### Home Screen
<img src="https://github.com/user-attachments/assets/6669baa9-e32f-4029-9597-7c65108ebc1b" alt="Home Screen" width="300">

### Service Screen
<img src="https://github.com/user-attachments/assets/83eb702c-6bc0-43c3-be42-7962f2db3945" alt="Service Screen" width="300">
<img src="https://github.com/user-attachments/assets/bce70b3d-c259-433b-816c-c42873b82c1e" alt="Service Screen" width="300">

### Profile Screen
<img src="https://github.com/user-attachments/assets/bd020ecc-f766-423f-9971-e4d753799087" alt="Profile Screen" width="300">
<img src="https://github.com/user-attachments/assets/93376890-f48a-4d86-8d2f-3e0164bc3dbf" alt="Profile Screen" width="300">

### New Update Screen
<img src="https://github.com/user-attachments/assets/97bd36d1-180c-4f7a-92e6-b1ac30819342" alt="New Update Screen" width="300">

## Contributing
We welcome contributions to improve this mobile application. To contribute:

## Fork the repository.
1. Create a new branch: ```git checkout -b feature-name```.
2. Make your changes and commit them: ```git commit -m 'Add some feature'```.
3. Push to the branch: ```git push origin feature-name```.
4. Open a pull request.
   
## License
This project is licensed under the MIT License. See the LICENSE file for more information.
