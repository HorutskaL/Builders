Build Instructions:

================== GRADLE ================

To build jar artifacts, run the following command:

       >gradle init

       >Select type of project to generate:1

        >Select build script DSL:1

Change two files in root project directory:
settings.gradle

    rootProject.name = 'builders'
    include 'admin'
    include 'services'
    include 'utils'
    include 'web'

and
build.gradle

     plugins {
         id 'java'
         id 'war'
     }

     subprojects {
         repositories {
             mavenCentral()
         }

         apply plugin: 'java'

         dependencies {
             compileOnly 'javax.servlet:javax.servlet-api:4.0.1'
             testImplementation 'junit:junit:4.13.2'
         }
     }

     project(':admin') {
         dependencies {
             implementation project(':services')
             implementation project(':utils')
             compileOnly 'javax.servlet:javax.servlet-api:4.0.1'
             testImplementation 'junit:junit:4.13.2'
         }

         jar {
             archiveBaseName.set('admin')
             setBuildDir('build/libs')
         }
     }
     project(':utils') {
         jar.enabled =false
     }
     project(':services') {
         jar.enabled=false
     }


     project(':web') {
         dependencies {
             implementation project(':services')
             implementation project(':utils')
             compileOnly 'javax.servlet:javax.servlet-api:4.0.1'
             testImplementation 'junit:junit:4.13.2'
         }
         jar.enabled=false
         war {
             archiveBaseName ='web'
         }
     }
     test {
         useJUnitPlatform()
     }

Use command to build archive:

 >gradle :admin:jar

 >gradle :web:war

 Use command to run tests
 >gradle test

 ================= MAVEN =================
Use terminal commands from project root

To only build the admin module (jar artifact):
mvn clean install -pl admin

To only build the web module (war artifact):
mvn clean install -pl web

To run tests:
mvn test



