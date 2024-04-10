# Soulful Plates

This project demonstrates building a secure mobile application with Spring Boot, utilizing JSON Web Tokens (JWT) for authentication. It showcases Spring Boot's streamlined approach to integrating security, data persistence, app services, and validation.

This project demonstrates how to build a secure mobile application with Spring Boot using JSON Web Tokens (JWT) for authentication. It showcases the integration of security, data persistence (JPA), validation, and app services in a Spring Boot application, focusing on securing RESTful APIs with JWT.

This project demonstrates cross-platform mobile application development with Flutter to create Android and iOS applications using shared code in the Dart language. It showcases dynamic UI creation using Flutter widgets and seamless API integration for a Spring Boot backend.

## Prerequisites

Ensure you have the following installed on your system before proceeding:

- **Java JDK 17**: Necessary for compiling and running the Java application.
- **Maven**: For project building and dependency management.
- **MySQL**: As the relational database management system for the project.
- **Install Flutter SDK:** Go through [Flutter Dev](https://docs.flutter.dev/get-started/install) for more detailed information on installation and environment setup.
- **Setup Intellij Or Android Studio** Follow installation guidelines for [Intellij Setup](https://docs.flutter.dev/get-started/install/windows/mobile?tab=download)
- **Android Emulator** Install the [Android SDK](https://docs.flutter.dev/get-started/install/windows/mobile?tab=download#configure-your-target-android-device) component and create Virtual device to verify the application.

Verify your Java and Maven installations by running `java -version` and `mvn -version` in your terminal and run `flutter doctor` to verify flutter installation.

## Setting Up the Development Environment

### Database Setup

1. Install MySQL and create a new database named `soulfulplates`:

```sql
CREATE DATABASE soulfulplates;
```

## Project Dependencies

Here's a detailed look at the project's dependencies, including their purpose and links to their Maven Central Repository pages.

### Spring Boot Starters

Starters are a set of convenient dependency descriptors that you can include in your application.

- **Spring Boot Starter Data JPA**

    - **Purpose**: Simplifies data persistence with JPA.
    - [Maven Central](https://search.maven.org/artifact/org.springframework.boot/spring-boot-starter-data-jpa)
    - [Spring Data JPA Reference](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/)

- **Spring Boot Starter Security**

    - **Purpose**: Adds authentication and authorization capabilities.
    - [Maven Central](https://search.maven.org/artifact/org.springframework.boot/spring-boot-starter-security)
    - [Spring Security Reference](https://docs.spring.io/spring-security/site/docs/current/reference/html5/)

- **Spring Boot Starter Validation**

    - **Purpose**: Supports method validation with Hibernate Validator.
    - [Maven Central](https://search.maven.org/artifact/org.springframework.boot/spring-boot-starter-validation)
    - [Spring Validation Reference](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#validation)

- **Spring Boot Starter Web**
    - **Purpose**: Facilitates building web and RESTful applications.
    - [Maven Central](https://search.maven.org/artifact/org.springframework.boot/spring-boot-starter-web)
    - [Spring Web Reference](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-developing-web-applications)

### Database Connector

- **MySQL Connector/J**
    - **Purpose**: Connects your application to MySQL databases.
    - [Maven Central](https://search.maven.org/artifact/mysql/mysql-connector-java)
    - [MySQL Connector/J Documentation](https://dev.mysql.com/doc/connector-j/8.0/en/)

### JSON Web Token Support

- **JJWT (Java JWT)**
    - **Purpose**: A Java library for creating and parsing JSON Web Tokens.
    - [Maven Central for jjwt-api](https://search.maven.org/artifact/io.jsonwebtoken/jjwt-api)
    - [Maven Central for jjwt-impl](https://search.maven.org/artifact/io.jsonwebtoken/jjwt-impl)
    - [Maven Central for jjwt-jackson](https://search.maven.org/artifact/io.jsonwebtoken/jjwt-jackson)
    - [JJWT GitHub Repository](https://github.com/jwtk/jjwt)

### Testing

- **Spring Boot Starter Test**

    - **Purpose**: Facilitates testing of Spring Boot applications.
    - [Maven Central](https://search.maven.org/artifact/org.springframework.boot/spring-boot-starter-test)

- **Spring Security Test**

    - **Purpose**: Provides support for testing Spring Security.
    - [Maven Central](https://search.maven.org/artifact/org.springframework.security/spring-security-test)

- **JUnit**
    - **Purpose**: A framework for writing and running tests in Java.
    - [Maven Central](https://search.maven.org/artifact/junit/junit)
    - [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/)

### Code Enhancement

- **Project Lombok**
    - **Purpose**: Simplifies Java code and reduces boilerplate.
    - [Maven Central](https://search.maven.org/artifact/org.projectlombok/lombok)
    - [Project Lombok](https://projectlombok.org/)

## Running the Project's Backend Locally

To run the project on your local machine, follow these steps:

1. **Clone the Repository**

   First, clone the project repository to your local machine using the following command in your terminal:

```bash
git clone <repository-url>

Make sure to replace `<repository-url>` with the actual URL of the project's repository.
Eg: https://git.cs.dal.ca/courses/2024-winter/csci5308/Group11.git
```

2. **Navigate to the Project Directory**

Change into the project directory by running:

```bash
cd Backend-Spring-Boot

`Backend-Spring-Boot` is the name of the backend in the cloned repository. Adjust the command according to the actual directory name if it's changed.
```

3. **Build the Project**

Build the project and run the tests by executing the following Maven command:

```bash
mvn clean install

This command compiles the project and runs any configured tests. It's important to ensure that the build and tests pass before trying to run the application.
```

4. **Run the Application**

Finally, start the Spring Boot application with:

```bash
mvn spring-boot:run

This command starts the application on your local machine. By default, the application will be accessible at `http://localhost:8080`.
```

You can now interact with the application through your web browser or API testing tools like Postman.

## Setting up the Frontend Environment

### Environment Setup

1. **Install Flutter:** If you haven't already, follow the [official Flutter installation instructions](https://flutter.dev/docs/get-started/install) for your operating system.

2. **Clone the Repositories:**
    - Buyer Application: Navigate to `Frontend Flutter/soulful_plates` and clone the repository.
    - Seller Application: Navigate to `Frontend Flutter/soulful_plates_client` and clone the repository.

3. **Install Dependencies:**
    - For Buyer Application: Run `flutter pub get` in the `soulful_plates` directory.
    - For Seller Application: Run `flutter pub get` in the `soulful_plates_client` directory and inside the `soulful_plates` directory.

4. **IOS Setup (Optional for Android):**
    - For Buyer Application: Navigate to `soulful_plates/ios` and run `pod install`.
    - For Seller Application: Navigate to `soulful_plates_client/ios` and run `pod install`.

## Project Dependencies

Here's a detailed look of Flutter application's dependencies, including their purpose and links to their packages page.

### Flutter Dependencies

Below are the dependencies used in the Flutter project:

1.  **cupertino_icons:** ^1.0.2
    - Flutter's default icon package to widgets.
2.  **get:** 4.6.5
    - State management library used for maintaining different state of the application.
3.  **intl:** 0.18.1
    - Localization library for converting the time and date in flutter application.
4.  **package_info_plus:** ^4.2.0
    - Package info library provided information regarding the run time environment type such as Android or IOS.
5.  **connectivity_plus:** ^5.0.2
    - This plugin give's status updates about the internet and wifi status at run time.
6.  **cached_network_image:** ^3.3.1
    - For loading the images via URLs into the application.
7.  **flutter_svg:** ^2.0.9
    - Plugin which can helps in showing the SVG image in the android and ios devices.
8.  **fluttertoast:** ^8.2.4
    - Shows the toast messages for information and success messages.
9.  **jwt_decode:** ^0.3.1
    - It will decodes the Java Web Token and will give information regarding the expiry time and all.
10.  **shared_preferences:** ^2.2.2
    - To save and retrieve the basic details to the local cache in android/ios devices.
11.  **internet_connection_checker:** ^1.0.0+1
    - It will ping to the server and returns if network connection is available or no.
12.  **dio:**
    - API calling library used in android to make Rest API calls.
13.  **shimmer:**
    - For animation and loaders using the shimmer library.
14.  **flutter_inappwebview:** ^5.8.0
    -  To show case the about and information pages used webview library.
15.  **url_launcher:** ^6.1.14
    -  It helps to open the native device components such as the calls, maps and etc.
16.  **carousel_slider:** ^4.0.0
    - It gives the sliding window in the application to show case the popular images and content in slider.
17.  **dropdown_search:** ^5.0.6
    - Helps in searching in the long dropdown data.
18.  **geolocator:** ^10.1.0
    - Will convert the selected google map location to the address.
19.  **cart_stepper:** ^4.3.0
    - Helps to increase and decrease numbers of count of item stepper.
20.  **map_location_picker:** ^1.2.8+3
    - It will choose the user's location from map and returns the value of latitude and longitude.

## How to Run Flutter Application

After completing the setup steps, you can run each application separately:

### Buyer Application

1. **Run on Emulator/Simulator:** Execute `flutter run` in the `soulful_plates` directory to run the buyer application on an emulator/simulator.

2. **Run on Physical Device:** Connect your device via wireless debugging or usb cable to the system and execute `flutter run` in the `soulful_plates` directory to run the buyer application on your device.

### Seller Application

1. **Run on Emulator/Simulator:** Execute `flutter run` in the `soulful_plates_client` directory to run the seller application on an emulator/simulator.

2. **Run on Physical Device:** Connect your device via wireless debugging or usb cable to the system and execute `flutter run` in the `soulful_plates_client` directory to run the seller application on your device.

### Deployment or Create Executable File

To deploy each application for production, follow these steps:

1. **Build APK/IPA:** Run `flutter build apk --release` in the respective application directory (`soulful_plates` or `soulful_plates_client`) to generate the APK/IPA file.


# Use Case scenarios

Complete Application work flow as per the stories and implementation0.

### 1. Seller and User Registration and Authentication
Both user and seller application contains the Registration and authentication flow. As we have two separate application for the Buyer and Seller we have two work flows During and After the Login.
- Seller:
    - Seller will see the Login screen as a starting point of the application and from where He/She can register or login to the application.
    - Once the Login process is completed We will verify if Seller is the new user or existing one if seller is new user we will ask for store details.
    - Once we have store details we will ask for the store address and after successfully creation of seller account and store. Seller will be redirected to the Dashboard screen.

- Buyer
    - Buyer will see the Login Screen as a starting point of the application and from where He/She can register or login to the application.
    - If Buyer is new to the application we will ask for location for which He/She wanted to create account.

![Screenshot 1](https://i.ibb.co/rvnyD2Z/Buyer-Login.png)
![Screenshot 1](https://i.ibb.co/nbdjpjM/Sign-up-Screen.png)
![Screenshot-1](https://i.ibb.co/2vbk5zj/Reset-via-email.png)
![Screenshot-1](https://i.ibb.co/5sk0WMQ/Reset-password.png)
![Screenshot-1](https://i.ibb.co/Jy0JHKn/Reset-password-fill.png)

### 2. Seller Profile, Store setup, update and showcase
Seller will ask for insert the store details and the address details of the store and able to update it later form the store details screen.
- Seller:
    - Seller will able to create the store.
    - Add the store address and able to edit the store details.

![Screenshot 1](https://i.ibb.co/mTh0BtL/Seller-profile-SignIn.png)
![Screenshot 1](https://i.ibb.co/Ry80rmH/Seller-Profile-Add.png)
![Screenshot 1](https://i.ibb.co/Yj4HT7d/Seller-location.png)
![Screenshot 1](https://i.ibb.co/mz4Mnxd/Seller-location-insert.png)
![Screenshot 1](https://i.ibb.co/BnscnzT/Seller-dashboard.png)

### 3. Settings and Notifications
User and Seller is able to update the notification preferences form the Settings screen where he can also able to use other feature of application.
![Screenshot 1](https://i.ibb.co/3dnd8XS/Seller-Settings.png)
![Screenshot 1](https://i.ibb.co/qjJH8mb/Buyer-Setting.png)

### 4. Menu Creation and Management
Seller is able to create the Menu and able to edit menu whenever needed such as enable or disable the items in stock and so on.
- We have Category and then Subcategories and then Menu items inside sub category for more user friendly menu.
  ![Screenshot 1](https://i.ibb.co/sWk50TW/Categorized-Menu-Item.png)

### 5. User Dashboard with Nearby Restaurants
Buyer is able to see the Near by Restaurants based on his/her location. Nearby restaurants are visible on the Home screen of the Buyer application.
![Screenshot 1](https://i.ibb.co/6vgWGj2/Buyer-Home-Screen.png)
![Screenshot 1](https://i.ibb.co/kQ8PcSC/Restaurant.png)

### 6. Wishlist
Buyer is able to include the items He/She likes into the wishlist and able to edit the wishlist when needed.
![Screenshot 1](https://i.ibb.co/HV3dx9P/Wishlist.png)

### 7. User Profile and Location Management
Buyer is able to include multiple address in the application so He/She can able to switch the delivery location. Buyer is able to edit the user profile later on.
![Screenshot 1](https://i.ibb.co/2qPwdB6/Buyer-Saved-Location.png)
![Screenshot 1](https://i.ibb.co/hHS97w7/Buyer-Profile.png)

### 8. Rating- Review for Order Seller Flagging system
Buyer is able to rate the order after the order completion. Seller is able to see the order feedback and the rating in the order details screen.
![Screenshot 1](https://i.ibb.co/sbNk2Cm/Feedback.png)

### 9. Order Tracking and Restaurant Listing
Buyer is able to see the Live orders in the menu and also able to see the near by restaurant.
![Screenshot 1](https://i.ibb.co/CK18VkZ/Transaction-Buyer.png)

### 10. Cart Management
Buyer is able to add items from restaurant details screen to the cart and in the view cart screen buyer is able to edit items if needed and will be able to create the order.

![Screenshot 1](https://i.ibb.co/KF4LqxK/View-cart.png)
![Screenshot 1](https://i.ibb.co/KrB8ZsP/Cart-Payment-Blank.png)
![Screenshot 1](https://i.ibb.co/QPX4Sv0/Cart-Payment.png)
![Screenshot 1](https://i.ibb.co/vwxrg6k/Order-Success.png)

### 11. Order and Transaction History: User
Buyer is able to see the all previous order which are completed and also able to filter them. Buyer also able to see the transactions made from the application.
![Screenshot 1](https://i.ibb.co/9pbFKf4/Order-History-buyer.png)

### 12. Seller Dashboard with Statistics and Live Orders
Seller is able to see the Live orders on the Home screen and able to switch the order status whenever needed apart from this seller is also able to call the user if needed.
![Screenshot 1](https://i.ibb.co/P9FJ6Kj/Seller-Home-Screen.png)
![Screenshot 1](https://i.ibb.co/gttdCYY/Change-statistics-month-wise.png)

### 13. Order, Payment and Transactions Histories: Seller
Seller is able to see all the previous orders, payments made by buyers and the transaction history in the history screen.
![Screenshot 1](https://i.ibb.co/jDp8P0F/Seller-Transaction-with-filters.png)
![Screenshot 1](https://i.ibb.co/ncrkJ9B/Seller-Transaction.png)

### 14. Order Listing and Management
Seller will able to see the Live order in the application and able to track the status whenever needed.
![Screenshot 1](https://i.ibb.co/R68BCfs/Live-Order-status-change.png)
![Screenshot 1](https://i.ibb.co/RSNjDCD/Order-History-Completed.png)
![Screenshot 1](https://i.ibb.co/vmwQW8C/Order-history-for-Seller.png)

## License

This project is licensed under the MIT License.
