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
    const total = this.quantityTarget.value * this.priceTarget.innerHTML;
    this.totalTarget.innerHTML = `$ ${total}`;
  }

  increment() {
    cleanMessage(this.messageTarget);
    const quantity = parseInt(this.quantityTarget.value);
    const result = quantity + 1;

    if (result > parseInt(this.stockTarget.innerHTML)) {
      this.stockErrorTarget.innerHTML = 'Not available quantity';
    } else {
      this.totalTarget.innerHTML = `$ ${result * this.priceTarget.innerHTML}`;
    }
    this.quantityTarget.value = result;
  }

  decrement() {
    cleanMessage(this.messageTarget);
    const quantity = parseInt(this.quantityTarget.value);
    const result = quantity - 1;

    if (result > parseInt(this.stockTarget.innerHTML)) {
      this.stockErrorTarget.innerHTML = 'Not available quantity';
      this.quantityTarget.value = result;
    } else if (result >= 0) {
      this.stockErrorTarget.innerHTML = '';
      this.totalTarget.innerHTML = `$ ${result * this.priceTarget.innerHTML}`;
      this.quantityTarget.value = result;
    }
  }

  async submitForm(event) {
    event.preventDefault();
    cleanMessage(this.messageTarget);

    if (parseInt(this.quantityTarget.value) > parseInt(this.stockTarget.innerHTML)) {
      this.stockErrorTarget.innerHTML = 'Not available quantity';
      return;
    }

    const form = this.formTarget
    const form_data = this.formData();
    const is_editing = /\/orders\/\d+/.test(form.action);
    const result_json = await sendRequest(form, form_data);

    if (result_json['success'] === false) {
      displayErrors(result_json['errors'], this.messageTarget);
    } else {
      const message = is_editing ? 'Cart updated' : 'Added to the cart!';
      displayMessage(message, this.messageTarget);
      if (!is_editing) { activateCart(); }
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
