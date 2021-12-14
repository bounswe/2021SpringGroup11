import renderRoutes from './utils/renderRoutes';
import history from './utils/history';
import { Router } from 'react-router-dom';
import React, { useEffect, useState, Suspense } from 'react';

import { createTheme, LinearProgress, ThemeProvider } from '@mui/material';
import { Provider } from 'react-redux';
import store from './store';
import 'react-toastify/dist/ReactToastify.css';
import { ToastContainer } from 'react-toastify';

const theme = createTheme();

export function App() {
  return (
    <Provider store={store}>
      <ThemeProvider theme={theme}>
        <Router history={history}>
          <Suspense fallback={<LinearProgress />}>{renderRoutes()}</Suspense>
        </Router>
        <ToastContainer limit={5} />
      </ThemeProvider>
    </Provider>
  );
}
