<h1 align="center"> 📑 Minitalk </h1>

<p align="center">
<img alt="Static Badge" src="https://img.shields.io/badge/42-S%C3%A3o_Paulo-orange"> <img alt="Static Badge" src="https://img.shields.io/badge/language-c-green">  <img alt="Static Badge" src="https://img.shields.io/badge/submitted_in-fev%2F24-orange">
</p>

>This project involves creating a communication program consisting of a client and a server.

<h2> ✏ About </h2>


<h2> ⚙ Requirements </h2>

- The executable files must be named `client` and `server`.
- A Makefile must be provided to compile the source files without relinking.
- The project can utilize the `libft` library.
- Thorough error handling is required to prevent unexpected program termination and memory leaks.
- Each program can have one global variable, justified by its use.
- Only specific functions can be used to complete the mandatory part, including standard I/O, signal handling, process management, and memory management functions.

<h2>  📝 Instructions </h2>

- The server must be launched first and print its PID after startup.
- The client takes two parameters: the server PID and the string to send.
- The client sends the provided string to the server.
- Upon receiving the string, the server promptly prints it.
- The server should handle multiple client connections without requiring restarts.
- Communication between the client and server is exclusively done using UNIX signals.

<h2> 🌟 Bonus Part </h2>

<h4> ⭐ Requirements </h4>

- The server acknowledges every message received by sending back a signal to the client.
- Support for Unicode characters.

</markdown>
