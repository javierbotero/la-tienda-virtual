const sendRequest = async (form, form_data) => {
  const url = form.action
  const method = /\/orders\/\d+/.test(url) ? 'PATCH' : 'POST';
  const csrfToken = document.getElementsByName('csrf-token')[0].content

  console.log(url, '->', method);

  return await fetch(url, {
    method: method,
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(form_data)
  })
    .then(response => response.json())
    .then(data => data)
    .catch(error => error);
}

const displayErrors = (errors, message) => {
  message.classList.add('bg-danger', 'p-3', 'mb-2', 'text-white');
  message.textContent = errors.join(', ');
}

const displayMessage = (message_info, message) => {
  message.classList.add('bg-success', 'p-3', 'mb-2', 'text-white');
  message.textContent = message_info;
}

const cleanMessage = (message) => {
  while (message.classList.length > 0) {
    message.classList.remove(message.classList.item(0));
  }
  message.textContent = '';
}

const activateCart = () => {
  const li = document.getElementById('li-cart');
  const link = document.createElement('a');

  link.href = "/products";
  link.textContent = "Cart";
  link.classList.add('nav-link');
  link.classList.add('text-secondary');

  li.appendChild(link);
  li.classList.remove('d-none')
  li.classList.add('d-block');
  li.classList.add('nav-item');
}

export { sendRequest, displayErrors, displayMessage, cleanMessage, activateCart }