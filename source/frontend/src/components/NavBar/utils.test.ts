/* eslint-disable */
// const { getProfileData } = require('./helper');

import { base64ImgDataGenerator } from './SearchBox';

test('test base64ImgDataGenerator without data field', () => {
  expect(base64ImgDataGenerator('Ym91bgo=')).toBe('data:image/png;base64,Ym91bgo=');
});

test('test base64ImgDataGenerator with data field', () => {
  expect(base64ImgDataGenerator('data:image/png;base64,Ym91bgo=')).toBe(
    'data:image/png;base64,Ym91bgo=',
  );
});
