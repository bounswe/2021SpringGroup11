/* eslint-disable */
// const { getProfileData } = require('./helper');

import { keyChanger } from './utils';

test('change object key', () => {
  const myObj = {
    id: 1,
    name: 'bob',
  };

  expect(keyChanger(myObj, 'id', 'ID')['ID']).toBe(myObj['id']);
});
