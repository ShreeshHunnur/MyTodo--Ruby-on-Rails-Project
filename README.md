# Modern Todo Application

A sleek, modern Todo application built with Ruby on Rails, featuring a beautiful UI and robust functionality.

## Features

### Core Features
- Create, read, update, and delete todos
- Track todo status (Pending, Doing, Done)
- Search todos by name
- Filter todos by status
- Responsive design for all devices
- Modern, clean user interface
- Real-time status updates
- Flash notifications for user feedback

### UI/UX Features
- Gradient headers and accents
- Subtle background design
- Animated flash messages
- Interactive buttons with icons
- Status badges with color coding
- Card-based layout
- Responsive tables
- Mobile-friendly design

## Tech Stack

- **Framework**: Ruby on Rails
- **Database**: SQLite (development), PostgreSQL (production)
- **Frontend**: 
  - HTML5
  - CSS3 (with modern features)
  - JavaScript (with importmaps)
- **Icons**: Heroicons (SVG)
- **Fonts**: Inter and Space Grotesk

## Prerequisites

- Ruby 3.0.0 or higher
- Rails 7.0.0 or higher
- SQLite3
- Node.js and Yarn (for asset compilation)

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd my_first_app
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Seed the database with sample data:
   ```bash
   rails db:seed
   ```

5. Start the Rails server:
   ```bash
   rails server
   ```

6. Visit `http://localhost:3000` in your browser

## Database Schema

### Todo Model
- `name`: string (required)
- `description`: text
- `state`: string (enum: pending, doing, done)
- `created_at`: datetime
- `updated_at`: datetime

## Project Structure

```
my_first_app/
├── app/
│   ├── controllers/
│   │   └── todos_controller.rb
│   ├── models/
│   │   └── todo.rb
│   ├── views/
│   │   └── todos/
│   │       ├── index.html.erb
│   │       ├── show.html.erb
│   │       ├── new.html.erb
│   │       └── edit.html.erb
│   └── assets/
│       └── stylesheets/
│           └── todos.css
├── db/
│   ├── migrate/
│   └── seeds.rb
└── config/
    └── routes.rb
```

## Features in Detail

### Todo Management
- Create new todos with name, description, and initial state
- View detailed information about each todo
- Edit existing todos
- Delete todos with confirmation
- Update todo status directly from the list

### Search and Filter
- Search todos by name
- Filter todos by status (Pending, Doing, Done)
- Combined search and filter functionality

### UI Components
- **Header**: Gradient title with action buttons
- **Cards**: Clean, modern card layout for content
- **Tables**: Responsive tables with hover effects
- **Buttons**: Interactive buttons with icons
- **Status Badges**: Color-coded status indicators
- **Flash Messages**: Animated notifications
- **Forms**: Styled form inputs and selects

### Responsive Design
- Adapts to all screen sizes
- Mobile-first approach
- Collapsible elements on smaller screens
- Touch-friendly interface

## Styling

The application uses modern CSS features:
- CSS Variables for theming
- Flexbox for layouts
- CSS Grid for complex layouts
- Modern color schemes
- Subtle animations and transitions
- Responsive design patterns

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Heroicons for the beautiful SVG icons
- Google Fonts for the typography
- Ruby on Rails team for the amazing framework
