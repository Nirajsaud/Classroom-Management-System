# Pathshala - Classroom Management System

Pathshala is a Java-based classroom management web application designed to digitize and simplify classroom operations in educational institutions. The system provides a centralized platform where administrators, teachers, and students can efficiently manage classrooms, learning materials, notices, and communication through role-based access.

The project was developed using Java Servlets, JSP, MySQL, and Apache Tomcat following the MVC (Model-View-Controller) architecture pattern as part of the CS5054NI Advanced Programming Technologies group coursework.

---

## Problem Statement

Traditional classroom management in many schools and educational institutions still relies heavily on manual communication, physical notices, scattered learning materials, and disconnected systems. This often creates problems such as:

- Difficulty sharing classroom resources efficiently
- Lack of centralized communication between teachers and students
- Poor organization of classroom notices and materials
- Time-consuming administrative management
- Limited accessibility to learning resources outside the classroom
- Inefficient tracking of classrooms, teachers, and students

Pathshala was developed to solve these issues by providing a centralized digital classroom management platform where administrators, teachers, and students can interact through a single system.

The system improves communication, simplifies classroom operations, and provides organized access to educational resources through role-based functionality.

### How Pathshala Solves These Problems

- Centralized management of classrooms, teachers, and students
- Easy upload and access to classroom materials
- Real-time classroom notices and announcements
- Role-based dashboards for different users
- Simplified administrative operations
- Improved accessibility to learning resources
- Organized digital record management
- Enhanced communication between teachers and students

---

## Features

### Admin Features
- Manage teachers
- Manage students
- Manage classrooms
- Manage subjects
- View and manage contact messages
- Access admin dashboard and analytics

### Teacher Features
- View assigned classrooms
- Upload learning materials
- Post classroom notices
- Manage teacher profile
- View notifications

### Student Features
- View enrolled classrooms
- Access uploaded learning materials
- View classroom notices
- Manage student profile
- View notifications

### General Features
- User authentication and authorization
- Role-based navigation and access control
- Profile update with image upload
- Session management
- Responsive JSP-based frontend
- Servlet-based backend architecture
- MySQL database integration

---

## Tech Stack

### Backend
- Java
- Jakarta Servlets
- JSP (JavaServer Pages)
- JSTL

### Frontend
- HTML5
- CSS3
- JavaScript

### Database
- MySQL

### Tools & Server
- Apache Tomcat 10.1
- Maven
- Eclipse IDE

---

## Project Structure

```text
Classroom-Management-System/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/pathshala/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── filter/
│       │       ├── model/
│       │       ├── service/
│       │       └── utils/
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── views/
│           ├── css/
│           ├── images/
│           ├── js/
│           ├── uploads/
│           ├── index.jsp
│           ├── about.jsp
│           └── contact.jsp
│
├── pom.xml
└── README.md