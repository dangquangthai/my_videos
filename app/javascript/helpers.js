window.turboFetch = function(url, options = {}) {
  const { method, callback, payload } = options;

  const requestParams = {
    method: method || 'GET',
    headers: {
      Accept: "text/vnd.turbo-stream.html",
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
  };

  if (payload) {
    if (typeof payload === 'string') {
      requestParams.body = payload;
    } else {
      requestParams.body = JSON.stringify(payload);
    }
  }

  fetch(url, requestParams).then(r => r.text()).then(html => {
    Turbo.renderStreamMessage(html)
    return true
  }).then(data => {
    if (callback) {
      callback(data);
    }
  });
};
