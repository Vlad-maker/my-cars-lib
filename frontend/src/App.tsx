import {Route, Routes} from 'react-router';
import {AppLayout} from './components/AppLayout';
import {CarPage} from './pages/CarPage';
import {HomePage} from './pages/HomePage';
import {NotFoundPage} from './pages/NotFoundPage';

export function App() {
  return (
    <Routes>
      <Route element={<AppLayout />}>
        <Route index element={<HomePage />} />
        <Route path="cars/:slug" element={<CarPage />} />
        <Route path="*" element={<NotFoundPage />} />
      </Route>
    </Routes>
  );
}
