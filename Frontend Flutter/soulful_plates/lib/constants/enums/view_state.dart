// Defines the various states the UI can be in
enum ViewStateEnum {
  idle, // Default state, nothing happening
  busy, // Data is being loaded or operations are in progress
  error, // An error occurred
  empty, // No data available
  populated // Data successfully loaded and available
}
