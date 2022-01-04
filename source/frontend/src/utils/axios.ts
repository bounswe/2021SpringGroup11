import axios from 'axios';
import store from '../store';

const instance = axios.create();

function checkStatus(response: any) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  }
  // this will edited according to backend
  throw new Error(response.statusText);
}

export function post(url: any, options: any, config = {}) {
  const token = store.getState().login.authInfo && store.getState().login.authInfo.token;
  const header = {
    headers: {
      Authorization: token ? `Bearer ${token}` : '',
      'Content-Type': 'application/json',
      Accept: 'application/json',
      'Access-Control-Allow-Origin': '*',
    },
  };
  return axios.post(url, options, { ...header, ...config }).then(checkStatus);
}

export function get(url: any, options?: any) {
  const token = store.getState().login.authInfo && store.getState().login.authInfo.token;
  const header = {
    headers: {
      Authorization: token ? `Bearer ${token}` : '',
      'Content-Type': 'application/json',
      Accept: 'application/json',
      'Access-Control-Allow-Origin': '*',
      ...options,
    },
  };
  return axios.get(url, { ...header }).then(checkStatus);
}

export default instance;
