import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="tom-select"
export default class extends Controller {
  connect() {
    new TomSelect(this.element, {
      sortField: {
        field: "text",
        direction: "asc"
      }
    })

    // new TomSelect('#bookmark_movie_id',{
    //   sortField: {
    //     field: "text",
    //     direction: "asc"
    //   }
    // });

  }
}
