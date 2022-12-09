import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['datetimeLocal', 'datetime', 'wholeDayEvent', 'remindContainer', 'remindField']

  changeDatetimeType(event) {
    if (event.target.checked) {
      this.eventChecked();
    } else {
      this.eventNotChecked();
    }
  };

  changeRemindAt(event) {
    if (event.target.checked) {
      this.remindContainerTarget.hidden = false;
      this.remindFieldTarget.disabled = false;
    } else {
      this.remindContainerTarget.hidden = true;
      this.remindFieldTarget.disabled = true;
    }
  };

  eventChecked() {
    this.datetimeLocalTarget.hidden = true;
    this.datetimeLocalTarget.disabled = true;
  
    this.datetimeTarget.hidden = false;
    this.datetimeTarget.disabled = false;
  };

  eventNotChecked() {
    this.datetimeLocalTarget.hidden = false;
    this.datetimeLocalTarget.disabled = false;
  
    this.datetimeTarget.hidden = true;
    this.datetimeTarget.disabled = true;
  }
}
