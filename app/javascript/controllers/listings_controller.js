import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="listings"
export default class extends Controller {
  connect() {
  }
  reset(event) {
    // reset search
    document.getElementById("query").value=""
    event.preventDefault();
    location.reload();
    window.location.href = '/';
  }
}
