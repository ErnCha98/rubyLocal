import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

// Connects to data-controller="todo-filter"
export default class extends Controller {
  static targets = [ "filter" ];

  async filter() {
    if (this.filterTarget) {
      const params = { status_filter: this.filterTarget.value };
      const response = await post("/todos/filter", {
          body: params,
          contentType: 'application/json',
          responseKind: 'turbo-stream'
      });
      if (!response.ok) {
          console.log('error fetching the turbo stream', response);
      } else {
        return response;
      }
    }
  }
};
