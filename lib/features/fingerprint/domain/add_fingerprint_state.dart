enum AddFpState {
  none('Waiting'),
  fetchingApiKey('Fetching API key...'),
  connectingToDevice('Connecting to device...'),
  started('Place your finger on the sensor'),
  removeFinger('Remove your finger'),
  placeFinger('Place your finger on the sensor again'),
  success('Success');

  const AddFpState(this.title);

  final String title;
}
