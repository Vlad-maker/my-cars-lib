import * as stylex from '@stylexjs/stylex';
import {AppShell} from '@astryxdesign/core/AppShell';
import {LinkProvider} from '@astryxdesign/core/Link';
import {TopNav, TopNavHeading} from '@astryxdesign/core/TopNav';
import {Link as RouterLink, Outlet} from 'react-router';

const styles = stylex.create({
  page: {
    width: '100%',
    maxWidth: 1200,
    marginInline: 'auto',
  },
});

/**
 * App frame: top navigation + centered page content.
 * LinkProvider makes every Astryx link (cards, breadcrumbs, nav) use
 * React Router's client-side navigation instead of full page reloads.
 */
export function AppLayout() {
  return (
    <LinkProvider component={RouterLink}>
      <AppShell
        contentPadding={4}
        topNav={<TopNav heading={<TopNavHeading heading="My Cars Lib" headingHref="/" />} />}>
        <div {...stylex.props(styles.page)}>
          <Outlet />
        </div>
      </AppShell>
    </LinkProvider>
  );
}
