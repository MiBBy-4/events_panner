const changeDatetimeType = (event) => {
  const dateField = document.getElementById('event_datetime');
  event.checked ? dateField.setAttribute('type', 'date') : dateField.setAttribute('type', 'datetime-local');
};
