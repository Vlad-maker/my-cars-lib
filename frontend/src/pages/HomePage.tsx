import {useEffect, useMemo} from 'react';
import {Banner} from '@astryxdesign/core/Banner';
import {Button} from '@astryxdesign/core/Button';
import {Card} from '@astryxdesign/core/Card';
import {EmptyState} from '@astryxdesign/core/EmptyState';
import {Grid} from '@astryxdesign/core/Grid';
import {Heading} from '@astryxdesign/core/Heading';
import {Skeleton} from '@astryxdesign/core/Skeleton';
import {Text} from '@astryxdesign/core/Text';
import {TextInput} from '@astryxdesign/core/TextInput';
import {VStack} from '@astryxdesign/core/VStack';
import {CarCard} from '../components/CarCard';
import {filterCars} from '../lib/filterCars';
import {useCarsStore} from '../store/carsStore';

const GRID_COLUMNS = {minWidth: 260} as const;

export function HomePage() {
  const cars = useCarsStore((s) => s.cars);
  const status = useCarsStore((s) => s.listStatus);
  const query = useCarsStore((s) => s.query);
  const setQuery = useCarsStore((s) => s.setQuery);
  const loadCars = useCarsStore((s) => s.loadCars);

  useEffect(() => {
    void loadCars();
  }, [loadCars]);

  const visible = useMemo(() => filterCars(cars, query), [cars, query]);

  return (
    <VStack gap={5}>
      <VStack gap={2}>
        <Heading level={1}>Библиотека автомобилей</Heading>
        <Text type="large" color="secondary">
          Фото, характеристики и история марок. Найдите машину и откройте её страницу.
        </Text>
      </VStack>

      <TextInput
        label="Поиск автомобиля"
        isLabelHidden
        size="lg"
        startIcon="search"
        placeholder="Марка или модель, например «Камри» или BMW"
        value={query}
        onChange={(value) => setQuery(value)}
        hasClear
        hasAutoFocus
      />

      {status === 'error' && (
        <Banner
          status="error"
          title="Не удалось загрузить автомобили"
          description="Проверьте, что бэкенд запущен (make backend), и попробуйте ещё раз."
          collapsible={false}
          endContent={<Button label="Повторить" onClick={() => void loadCars({force: true})} />}
        />
      )}

      {(status === 'idle' || status === 'loading') && (
        <Grid columns={GRID_COLUMNS} gap={4}>
          {Array.from({length: 6}, (_, i) => (
            <Card key={i} padding={0}>
              <Skeleton height={220} index={i} />
            </Card>
          ))}
        </Grid>
      )}

      {status === 'ready' && visible.length === 0 && (
        <EmptyState
          title="Ничего не найдено"
          description={`По запросу «${query}» машин нет. Попробуйте другое название.`}
          actions={<Button label="Сбросить поиск" onClick={() => setQuery('')} />}
        />
      )}

      {status === 'ready' && visible.length > 0 && (
        <VStack gap={3}>
          <Text type="supporting">
            Найдено: {visible.length} из {cars.length}
          </Text>
          <Grid columns={GRID_COLUMNS} gap={4}>
            {visible.map((car) => (
              <CarCard key={car.slug} car={car} />
            ))}
          </Grid>
        </VStack>
      )}
    </VStack>
  );
}
