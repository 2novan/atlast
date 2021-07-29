import { Controller } from "stimulus"
export default class extends Controller {
  static targets = [ "loader" ]
  connect() {
    setTimeout(() => {
      this.loaderTarget.remove();
    }, 10000)
  }
}
