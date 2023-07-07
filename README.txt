        Build Instructions:

================= GRADLE ================

To build the JAR artifact for the admin module, run the following command from the project root:
./gradlew :admin:jar

To build the WAR artifact for the admin module, use the following command:
./gradlew :web:war

To run tests, execute the following command:
./gradlew test

================= MAVEN =================

To build the project using Maven, run the following command from the project root:
mvn clean install

To build only the admin module (JAR artifact), use the following command:
mvn clean install -pl admin

To build only the web module (WAR artifact), use the following command:
mvn clean install -pl web

To run tests, execute the following command:
mvn test
------
