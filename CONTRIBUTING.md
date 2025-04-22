# Project Contribution Guide

## Code Standards

### 1. Code Generation Rules
- All generated code must be in English
- Variable names, function names, and class names must be in English
- Code comments can be in Chinese or English (English preferred)
- Error messages and log messages can be in Chinese or English (English preferred)

### 2. Code Style
- Follow the official Dart style guide
- Use 2 spaces for indentation
- Lines should not exceed 80 characters
- Use single quotes instead of double quotes
- Add spaces around operators
- Add spaces after commas

### 3. Naming Conventions
- Class names use UpperCamelCase
- Variable and method names use lowerCamelCase
- Constant names use UPPER_CASE
- Private members start with underscore `_`
- File names use lowercase letters with underscores between words

## Communication Standards

### 1. Language Usage
- Team communication can be in Chinese or English
- Code reviews can be in Chinese or English
- Documentation comments can be in Chinese or English
- Commit messages can be in Chinese or English (English preferred)

### 2. Commit Standards
- Commit messages should clearly describe changes
- Use present tense for changes
- Commit messages should be concise but descriptive
- Reference issue numbers if related to a specific issue

### 3. Documentation Standards
- README files must include both Chinese and English versions
- API documentation should be in English
- User documentation can be in the language of the target audience

## Development Process

### 1. Branch Management
- Main branch: `main` or `master`
- Development branch: `develop`
- Feature branch: `feature/feature-name`
- Fix branch: `fix/issue-description`
- Release branch: `release/version-number`

### 2. Code Review
- All code changes must go through code review
- Code review should focus on code quality, performance, and security
- Code review comments should be specific and constructive

### 3. Testing Requirements
- All new features must include unit tests
- Critical features must include integration tests
- Test coverage should be maintained above 80%

## Tool Usage

### 1. Cursor IDE
- When using Cursor for code generation, ensure the code follows the above standards
- Generated code must be reviewed and modified by humans
- When using Cursor's AI features, ensure prompts are clear and specific

### 2. Version Control
- Use Git for version control
- Follow the branch management strategy above
- Commit code regularly and maintain clear commit history

### 3. Continuous Integration
- All code changes must pass CI process
- Failed builds must be fixed immediately
- Keep the build process fast and reliable

## Security Standards

### 1. Sensitive Information
- Do not hardcode sensitive information in code
- Use environment variables or configuration files for sensitive information
- Ensure sensitive information is not committed to version control

### 2. Dependency Management
- Update dependencies regularly
- Check for security vulnerabilities in dependencies
- Use fixed versions for dependencies

### 3. Code Security
- Avoid using unsafe APIs
- Validate all user input
- Use parameterized queries to prevent SQL injection

## Performance Standards

### 1. Code Performance
- Avoid unnecessary computations
- Use appropriate data structures
- Optimize loops and recursion

### 2. Resource Usage
- Release resources promptly
- Avoid memory leaks
- Optimize network requests

### 3. Response Time
- Keep UI responsive
- Optimize loading times
- Use appropriate caching strategies 