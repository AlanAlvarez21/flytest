
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
    const eventType = this.element.dataset.eventType;
    this.element.classList.add(`flash-${eventType}`);

    setTimeout(() => {
      this.element.remove();
    }, 3000);
  }
}