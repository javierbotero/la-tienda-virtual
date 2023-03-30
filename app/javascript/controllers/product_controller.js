import { Controller } from "@hotwired/stimulus";
import { sendRequest, displayMessage, displayErrors, cleanMessage, activateCart } from '../shared/helpers';

export default class extends Controller {
  static targets = ['carousel', 'total', 'stock', 'price',
    'quantity', 'stockError', 'form', 'sendButton', 'message'];

  display(event) {
    const el = event.currentTarget;
    const index = el.getAttribute('data-order');
    const displayed = document.querySelector('div.carousel ul.pictures li.d-block');
    const toDisplay = document.querySelector(`div.carousel ul.pictures li[data-order="${index}"]`);

    displayed.classList.remove('d-block');
    displayed.classList.add('d-none');

    toDisplay.classList.remove('d-none');
    toDisplay.classList.add('d-block');
  }

  updateTotal() {
    const total = this.quantityTarget.innerHTML * this.priceTarget.innerHTML;
    this.totalTarget.innerHTML = total;
  }

  increment() {
    cleanMessage(this.messageTarget);
    const quantity = parseInt(this.quantityTarget.value);
    const result = quantity + 1;

    if (result > this.stockTarget.innerHTML) {
      this.stockErrorTarget.innerHTML = 'Not available quantity';
    } else {
      this.totalTarget.innerHTML = result * this.priceTarget.innerHTML;
    }
    this.quantityTarget.value = result;
  }

  decrement() {
    cleanMessage(this.messageTarget);
    const quantity = parseInt(this.quantityTarget.value);
    const result = quantity - 1;

    if (result > this.stockTarget.innerHTML) {
      this.stockErrorTarget.innerHTML = 'Not available quantity';
      this.quantityTarget.value = result;
    } else if (result >= 0) {
      this.totalTarget.innerHTML = result * this.priceTarget.innerHTML;
      this.quantityTarget.value = result;
    }
  }

  async submitForm(event) {
    event.preventDefault();
    cleanMessage(this.messageTarget);

    const form = this.formTarget
    const form_data = this.formData();
    const is_creating = /\/orders\/\d+/.test(form_data.action);
    const [user_id] = form_data.action.match(/\d+/g);
    const result_json = await sendRequest(form, form_data);

    if (result_json['success'] === false) {
      displayErrors(result_json['errors'], this.messageTarget);
    } else {
      const message = is_creating ? 'Added to the cart!' : 'Cart updated';
      displayMessage(message, this.messageTarget);
      if (is_creating) { activateCart(user_id, result_json['order_id']); }
    }
  }

  formData() {
    const form = this.formTarget
    const formData = new FormData(form)
    const data = {}

    for (const [key, value] of formData.entries()) {
      const keys = key.split(/\[|\]/).filter(str => str !== '');
      keys.reduce((acc, property, index) => {
        if (!acc.hasOwnProperty(property)) {
          acc[property] = index === keys.length - 1 ? value : {};
        }
        return acc[property];
      }, data);
    }

    return data;
  }

  connect() {
    this.updateTotal();
  }
}
