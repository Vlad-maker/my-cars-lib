import {Button} from '@astryxdesign/core/Button';
import {EmptyState} from '@astryxdesign/core/EmptyState';

export function NotFoundPage({title = 'Страница не найдена'}: {title?: string}) {
  return (
    <EmptyState
      headingLevel={1}
      title={title}
      description="Возможно, ссылка устарела или в адресе опечатка."
      actions={<Button variant="primary" label="К списку автомобилей" href="/" />}
    />
  );
}
