import { Controller } from "stimulus"

export default class extends Controller {
  updateBtn(event) {
    const [ data ] = event.detail; // same as const data = event.detail[0]

    this.element.outerHTML = data.html;
  }
}
