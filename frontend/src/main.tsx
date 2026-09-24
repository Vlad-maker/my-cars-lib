import {StrictMode} from 'react';
import {createRoot} from 'react-dom/client';
import {BrowserRouter} from 'react-router';
import {Theme} from '@astryxdesign/core/theme';
import {neutralTheme} from '@astryxdesign/theme-neutral/built';
import '@astryxdesign/core/reset.css';
import '@astryxdesign/theme-neutral/theme.css';
import './index.css';
import {App} from './App';

const root = document.getElementById('root');
if (!root) {
  throw new Error('#root element is missing in index.html');
}

createRoot(root).render(
  <StrictMode>
    {/* Theme scopes Astryx design tokens (fonts, colors) to the app. */}
    <Theme theme={neutralTheme}>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </Theme>
  </StrictMode>,
);
