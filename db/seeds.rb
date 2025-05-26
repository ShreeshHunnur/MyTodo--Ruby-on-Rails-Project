#
Todo.destroy_all

# Sample todo names and descriptions
todo_names = [
  "Complete Project Documentation",
  "Review Pull Requests",
  "Update Dependencies",
  "Fix Bug in Authentication",
  "Implement New Feature",
  "Write Unit Tests",
  "Deploy to Production",
  "Optimize Database Queries",
  "Update API Documentation",
  "Refactor Legacy Code",
  "Setup CI/CD Pipeline",
  "Conduct Code Review",
  "Update Security Patches",
  "Create User Guide",
  "Design New Interface",
  "Backup Database",
  "Monitor System Performance",
  "Update Server Configuration",
  "Implement Error Logging",
  "Create Backup Strategy"
]

descriptions = [
  "Need to complete the technical documentation for the new features.",
  "Review and merge pending pull requests from team members.",
  "Update all project dependencies to their latest stable versions.",
  "Fix authentication bug reported by users in production.",
  "Implement the new user dashboard feature as per requirements.",
  "Write comprehensive unit tests for the new modules.",
  "Prepare and execute production deployment with zero downtime.",
  "Analyze and optimize slow database queries in the application.",
  "Update API documentation with new endpoints and changes.",
  "Refactor old code to improve maintainability and performance.",
  "Set up continuous integration and deployment pipeline.",
  "Conduct thorough code review for the latest changes.",
  "Apply latest security patches to all systems.",
  "Create comprehensive user guide for the new features.",
  "Design and implement new user interface components.",
  "Perform regular database backup and verify integrity.",
  "Monitor and analyze system performance metrics.",
  "Update server configurations for better performance.",
  "Implement comprehensive error logging system.",
  "Create and test backup strategy for all systems."
]

states = ['pending', 'doing', 'done']

20.times do |i|
  Todo.create!(
    name: todo_names[i],
    description: descriptions[i],
    state: states.sample,
    created_at: rand(1..30).days.ago,
    updated_at: rand(1..30).days.ago
  )
end

puts "Created #{Todo.count} todos!"
