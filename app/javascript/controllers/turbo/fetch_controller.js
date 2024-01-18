import { Controller } from "@hotwired/stimulus"

//data-controller="turbo--fetch"
//data-url="/load-data-url"
//data-auto="true"
//data-method="GET|POST|PATCH|PUT|DELETE"
//data-payload="JSON.stringify({...})"
export default class extends Controller {
  initialize() {
    this.fetch = this.fetch.bind(this);
    this.fetchCompleted = this.fetchCompleted.bind(this);
  }

  connect() {
    this.payload = this.element.dataset.payload;
    this.method = this.element.dataset.method || 'GET';
    this.url = this.element.dataset.url;
    this.auto = !!this.element.dataset.auto;

    if (this.auto) {
      this.fetch();
    }

    this.addListener();
  }

  disconnect() {
    this.removeListener();
  }

  fetch() {
    this.removeListener();
    turboFetch(this.url, {method: this.method, payload: this.payload}, this.fetchCompleted);
  }

  fetchCompleted() {
    this.addListener();
  }

  removeListener() {
    this.element.removeEventListener('click', this.fetch);
  }

  addListener() {
    this.element.addEventListener('click', this.fetch);
  }
}
