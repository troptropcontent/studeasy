import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "files" ]

  handleFileInput({target: {files}}) {
    const array = Array.from(files)
    const fileNames = array.map(file => file.name ).join()
    this.filesTarget.value =  fileNames
  }
}
