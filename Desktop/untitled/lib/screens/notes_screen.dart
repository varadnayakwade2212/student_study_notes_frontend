import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  final String topic;

  const NoteScreen({
    super.key,
    required this.topic,
  });

  String getNote() {
    final notes = {

      // ================= JAVA =================

      'Java Features':
      'Java is simple, object-oriented, secure, robust and platform independent.',

      'Class and Object':
      'Class is a blueprint. Object is an instance of a class.',

      'Tokens and Data Types':
      'Tokens are basic elements of Java. Data types are Primitive and Non-primitive.',

      'Variables and Typecasting':
      'Variable stores data. Typecasting converts one data type into another.',

      'Operators':
      'Arithmetic, Relational, Logical and Assignment operators are commonly used.',

      'Decision Making':
      'if, if-else and switch are used for decision making.',

      'Loops':
      'for, while and do-while are used to repeat statements.',

      'Arrays':
      'Array stores multiple values of the same data type.',

      'Strings':
      'String is a sequence of characters and is immutable.',

      'StringBuffer':
      'StringBuffer is mutable and allows modification of strings.',

      'Constructors and Methods':
      'Constructor initializes an object. Method performs a specific task.',

      'Overloading':
      'Same method or constructor name with different parameters is called overloading.',

      'Garbage Collection':
      'Garbage collection automatically removes unused objects from memory.',

      'Visibility Control':
      'Access modifiers are public, private, protected and default.',

      'Inheritance':
      'Inheritance allows a child class to acquire properties of a parent class.',

      'Single Inheritance':
      'One child class inherits from one parent class.',

      'Multilevel Inheritance':
      'Inheritance occurs in levels such as A → B → C.',

      'Hierarchical Inheritance':
      'Multiple child classes inherit from one parent class.',

      'Method Overriding':
      'Child class provides its own version of a parent class method.',

      'Final Keyword':
      'Final variable cannot change and final method cannot be overridden.',

      'Abstract Class':
      'Abstract class cannot be directly instantiated.',

      'Interfaces':
      'Interface defines methods that a class implements.',

      'Packages':
      'Package is a collection of related classes and interfaces.',

      'Errors and Exceptions':
      'Errors are serious problems. Exceptions are abnormal conditions that can be handled.',

      'try and catch':
      'try contains risky code and catch handles the exception.',

      'throw and throws':
      'throw explicitly throws an exception. throws declares an exception.',

      'finally':
      'finally block executes whether an exception occurs or not.',

      'Built-in Exceptions':
      'Examples: ArithmeticException, NullPointerException and ArrayIndexOutOfBoundsException.',

      'User-defined Exceptions':
      'Programmer-created exceptions are called user-defined exceptions.',

      'Multithreading':
      'Multithreading allows multiple tasks to execute concurrently.',

      'Thread Class':
      'Thread class is used to create and control threads.',

      'Runnable Interface':
      'Runnable interface can be implemented to create a thread.',

      'Thread Life Cycle':
      'Main states are New, Runnable, Running, Waiting and Terminated.',

      'Thread Methods':
      'Common methods are start(), run(), sleep() and join().',

      'Thread Priority':
      'Thread priority ranges from 1 to 10.',

      'Synchronization':
      'Synchronization controls access to shared resources.',

      'AWT Components':
      'AWT provides GUI components such as Button, Label and TextField.',

      'Containers and Frame':
      'Container holds components. Frame is a top-level window.',

      'Buttons and Labels':
      'Button performs an action. Label displays text.',

      'Layout Managers':
      'Layout managers arrange components in a container.',

      'FlowLayout':
      'FlowLayout arranges components from left to right.',

      'BorderLayout':
      'BorderLayout uses North, South, East, West and Center.',

      'GridLayout':
      'GridLayout arranges components in rows and columns.',

      'AWT vs Swing':
      'AWT uses native components. Swing provides lightweight components.',

      'Swing Components':
      'JFrame, JPanel, JLabel, JButton and JTextField are common Swing components.',

      'Event Handling':
      'Event handling responds to user actions.',

      'ActionListener':
      'ActionListener handles action events such as button clicks.',

      'MouseListener':
      'MouseListener handles mouse events.',

      'KeyListener':
      'KeyListener handles keyboard events.',

      'Socket':
      'Socket provides communication between two computers over a network.',

      'Client and Server':
      'Client requests a service. Server provides the service.',

      'Proxy Server':
      'Proxy acts as an intermediate system between client and server.',

      'Internet Addressing':
      'IP address identifies a device on a network.',

      'InetAddress':
      'InetAddress represents an IP address and host name.',

      'TCP/IP Sockets':
      'TCP provides reliable and connection-oriented communication.',

      'Datagram Packets':
      'Datagram packets provide connectionless communication using UDP.',

      'URL':
      'URL represents the address of a resource on the internet.',

      'URLConnection':
      'URLConnection provides a connection to a URL resource.',

      'JDBC':
      'JDBC stands for Java Database Connectivity. It connects Java applications with databases.',

      'Two-tier Architecture':
      'Client application directly communicates with the database.',

      'Three-tier Architecture':
      'It contains presentation, application and database layers.',

      'JDBC Drivers':
      'JDBC drivers provide communication between Java and database.',

      'DriverManager':
      'DriverManager manages JDBC drivers and database connections.',

      'Connection':
      'Connection represents a connection between Java application and database.',

      'Statement':
      'Statement is used to execute SQL statements.',

      'PreparedStatement':
      'PreparedStatement executes parameterized SQL statements.',

      'ResultSet':
      'ResultSet stores data returned by a SELECT query.',


      // ================= C PROGRAMMING =================

      'C Introduction':
      'C is a general-purpose, procedural programming language.\n\n'
          'Features: Simple, Fast, Portable and Structured.',

      'Variables and Data Types':
      'Variable stores data in memory.\n\n'
          'Common types: int, float, char and double.',

      'Operators':
      'Operators perform operations on data.\n\n'
          'Types: Arithmetic, Relational, Logical and Assignment.',

      'Decision Making':
      'if, if-else and switch are used for decision making.',

      'Loops':
      'for, while and do-while are used for repetition.',

      'Arrays':
      'Array stores multiple values of the same data type.',

      'Strings':
      'String is a collection of characters terminated by null character \\0.',

      'Functions':
      'Function is a block of code used to perform a specific task.',

      'Pointers':
      'Pointer is a variable that stores the address of another variable.',

      'Structures':
      'Structure groups different data types under one name.',


      // ================= DBMS =================

      'Introduction to DBMS':
      'DBMS is software used to create, store, manage and retrieve data.',

      'DBMS Architecture':
      'DBMS architecture describes how users interact with the database system.',

      'Data Models':
      'Data models describe how data is stored and related.\n\n'
          'Examples: Hierarchical, Network and Relational.',

      'Keys':
      'Keys identify records in a table.\n\n'
          'Examples: Primary Key, Foreign Key and Candidate Key.',

      'DDL and DML':
      'DDL: CREATE, ALTER, DROP.\n\n'
          'DML: INSERT, UPDATE, DELETE.',

      'SQL':
      'SQL stands for Structured Query Language.\n'
          'It is used to manage relational databases.',

      'Joins':
      'Joins combine data from two or more tables.\n\n'
          'Types: Inner, Left, Right and Full Join.',

      'Views':
      'View is a virtual table based on an SQL query.',

      'Triggers':
      'Trigger is automatically executed when a database event occurs.',

      'PostgreSQL':
      'PostgreSQL is an open-source relational database management system.',


      // ================= COMPUTER NETWORKS =================

      'Introduction to Computer Networks':
      'Computer network is a group of connected devices that share data and resources.',

      'Network Topologies':
      'Topology describes network arrangement.\n\n'
          'Types: Bus, Star, Ring, Mesh and Tree.',

      'OSI Model':
      'OSI has 7 layers:\n'
          'Physical, Data Link, Network, Transport, Session, Presentation and Application.',

      'TCP/IP Model':
      'TCP/IP model is used for internet communication.\n\n'
          'Layers: Network Access, Internet, Transport and Application.',

      'Transmission Media':
      'Transmission media carries data between devices.\n\n'
          'Types: Guided and Unguided media.',

      'Twisted Pair':
      'Twisted pair consists of two insulated copper wires twisted together.',

      'Fiber Optic':
      'Fiber optic cable transmits data using light.\n'
          'It provides high speed and long-distance communication.',

      'Satellite Communication':
      'Satellite communication uses satellites to transmit signals over long distances.',

      'Multiplexing':
      'Multiplexing combines multiple signals into one communication channel.',

      'TDM and FDM':
      'TDM divides channel by time.\n'
          'FDM divides channel by frequency.',

      'Packet Switching':
      'Data is divided into packets and transmitted through the network.',

      'Circuit Switching':
      'A dedicated communication path is established between sender and receiver.',

      'Wireless LAN 802.11':
      'IEEE 802.11 is a standard used for Wireless LAN or Wi-Fi.',
    };

    return notes[topic] ?? 'Notes will be added soon.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Short Notes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              getNote(),
              style: const TextStyle(
                fontSize: 17,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}