# Exchange Rate Prices

## Project Information
- Figma Design: [View Design](https://www.figma.com/file/Gd13gQCvkEyCo9Ef4r9Crz/Exchange-rate-app?type=design&node-id=0%3A1&mode=design&t=38OfvHVTwz7gq1v0-1)
- Note: The rate currency is missing in the description. A 'Cat currency' 🐱 is used as a placeholder.
- Configuration: Added custom `analysis_options.yaml`.

## Thought Processes
- **GIT Policy**:
    - Initial Commit: A single commit for the base of the project, integrating logic and visual elements together.
    - Subsequent Commits: Prefer smaller commits, especially for crucial logic changes.
- **Widget Separation**:
    - Strategy: Keep widgets in their screen files for smaller screens. Move to a widget folder if the screen is large or widgets are reusable.
- **Testing**:
    - Integration and Unit tests could be created here for a Bloc logic and API communication. Also End to end tests would be an option for the design and states. I treat it as out of scope and not necessary at the moment.

## Ideas
- Change `historyLength` from Float to Int for better data type suitability.
- Separate the model for different endpoints if detailed information expands.
- iOS and Android versions need more refinement before release.
- Addition of an app icon would enhance visual appeal.

