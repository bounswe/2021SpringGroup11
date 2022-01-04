/* eslint-disable */
// const { getProfileData } = require('./helper');

import { GET_USER_URL } from '../../utils/endpoints';
import { getUserDataURLGenerate, getUsername } from './helper';

test('test UserDataURLGenerate', () => {
  expect(getUserDataURLGenerate('alice')).toBe(`${GET_USER_URL}alice/`);
});

test('test getUsername(username) with specified username', () => {
  expect(getUsername('alice')).toBe(`alice`);
});

test('test getUsername(username) without specified username at test env', () => {
  expect(getUsername('')).toBe(undefined);
});
