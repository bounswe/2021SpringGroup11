// import { render, screen } from '@testing-library/react';
import * as React from 'react';
import { Provider } from 'react-redux';
import renderer from 'react-test-renderer';
import configureStore from 'redux-mock-store';
import Activity from '../index';

// @ts-ignore
const mockStore = configureStore([]);

describe('tests if the text is rendered correctly', () => {
  let store;
  // @ts-ignore
  let component;

  beforeEach(() => {
    store = mockStore({
      activity: { username: 'eren2' },
    });

    component = renderer.create(
      <Provider store={store}>
        <Activity />
      </Provider>,
    );
  });

  it.todo('should render with given state from Redux store');

  it.todo('should dispatch an action on button click');
});
