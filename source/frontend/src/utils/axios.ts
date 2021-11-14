import axios from 'axios';
import store from '../store';

const instance = axios.create();

function checkStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  }
  // this will edited according to backend
  throw new Error(response.statusText);
}

export function post(url, options, config) {
  const token = store.getState().login.authInfo && store.getState().login.authInfo.accessToken;
  const header = {
    headers: {
      Authorization: token ? `Bearer ${token}` : '',
      'Content-Type': 'application/json',
      Accept: 'application/json',
    },
  };
  return axios.post(url, options, { ...header, ...config }).then(checkStatus);
}

export function get(url, options) {
  const token = store.getState().login.authInfo && store.getState().login.authInfo.accessToken;
  const header = {
    headers: {
      Authorization: token ? `Bearer ${token}` : '',
      'Content-Type': 'application/json',
      Accept: 'application/json',
      ...options,
    },
  };
  return axios.get(url, { ...header }).then(checkStatus);
}

export default instance;
