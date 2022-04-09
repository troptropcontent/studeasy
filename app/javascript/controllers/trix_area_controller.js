import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const attachFilesButton = this.element.querySelector("[data-trix-action='attachFiles']")
    console.log(attachFilesButton.parentElement)
    attachFilesButton.parentElement.remove()
  }
}
