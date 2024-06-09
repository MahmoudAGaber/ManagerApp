# managerapp

To-Do Application
Project Description
The To-Do Application is a robust and user-friendly task management tool designed to help users efficiently manage their daily tasks. The application supports basic CRUD operations (Create, Read, Update, Delete) for tasks and leverages a RESTful API, shared preferences for data persistence, and state management to ensure a smooth user experience. The project is structured following clean architecture principles and adheres to the SOLID principles for maintainable and scalable code.

Features
Task Management: Easily add, view, edit, and delete tasks.
RESTful API: Provides endpoints for seamless task management.
Shared Preferences: Local storage for user settings and preferences.
State Management: Efficiently manages application state for a consistent user experience.
Clean Architecture: A well-organized codebase for ease of maintenance.
SOLID Principles: Adheres to best practices in software design.
Technology Stack
State Management: Managed with [Provider].

How It Works

Application Workflow
Starting the Application:

The user launches the application.
The application retrieves user settings and preferences from shared preferences to restore the previous state.
State Management:

The application uses [Provider] to manage the state of tasks and user preferences.
This ensures that changes in the UI reflect immediately and consistently without needing to refresh or reload.

Creating a Task:

The user clicks on the "Add" Floating Action button.
A form appears for entering task details (title, checkBox to completed or not).
On submission, the application sends a POST request to the /tasks endpoint, and the state is updated accordingly.

Viewing Tasks:

The user can view all tasks on the main HomeScreen.
The application makes a GET request to the /tasks endpoint to fetch tasks and updates the state to display them.

Updating a Task:

The user selects a task to edit by clicking the "task".
The task details are pre-filled in a form for easy updating.
Upon submission, a PUT request is sent to the /tasks/{id} endpoint, and the task list in the state is updated.

Deleting a Task:

The user clicks the "Delete" button next to the task they wish to remove.
A confirmation dialog is shown, and upon confirmation, a DELETE request is sent to the /tasks/{id} endpoint, and the state is updated to reflect the deletion.
