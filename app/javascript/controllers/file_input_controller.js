import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "files" ]
  handleFileInput({target: {files}}) {
    const array = Array.from(files)
    const fileNames = array.map(file => file.name ).join()
    if (this.filesTarget.nodeName === "INPUT") {
      this.filesTarget.value =  fileNames
    } else {
      this.filesTarget.innerText =  fileNames
    }
  }
}
