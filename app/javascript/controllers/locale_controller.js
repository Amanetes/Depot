import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="locale"
export default class extends Controller {
  static targets = [ "sumbit" ]

  initialize() {
    this.submitTarget.style.display = 'none'
  }
}
