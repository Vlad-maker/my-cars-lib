import {useEffect} from 'react';
import {useParams} from 'react-router';
import {Badge} from '@astryxdesign/core/Badge';
import {Banner} from '@astryxdesign/core/Banner';
import {BreadcrumbItem, Breadcrumbs} from '@astryxdesign/core/Breadcrumbs';
import {Button} from '@astryxdesign/core/Button';
import {Card} from '@astryxdesign/core/Card';
import {Grid} from '@astryxdesign/core/Grid';
import {Heading} from '@astryxdesign/core/Heading';
import {HStack} from '@astryxdesign/core/HStack';
import {MetadataList, MetadataListItem} from '@astryxdesign/core/MetadataList';
import {Skeleton} from '@astryxdesign/core/Skeleton';
import {Text} from '@astryxdesign/core/Text';
import {VStack} from '@astryxdesign/core/VStack';
import type {CarDetail} from '../api/types';
import {Gallery} from '../components/Gallery';
import {SpecsSection} from '../components/SpecsSection';
import {formatYears} from '../lib/format';
import {useCarsStore} from '../store/carsStore';
import {NotFoundPage} from './NotFoundPage';

export function CarPage() {
  const {slug = ''} = useParams();
  const car = useCarsStore((s) => s.details[slug]);
  const status = useCarsStore((s) => s.detailStatus[slug] ?? 'idle');
  const loadCar = useCarsStore((s) => s.loadCar);

  useEffect(() => {
    void loadCar(slug);
  }, [slug, loadCar]);

  useEffect(() => {
    document.title = car ? `${car.brand.name} ${car.model} — My Cars Lib` : 'My Cars Lib';
  }, [car]);

  if (status === 'not-found') {
    return <NotFoundPage title="Автомобиль не найден" />;
  }

  if (status === 'error') {
    return (
      <Banner
        status="error"
        title="Не удалось загрузить автомобиль"
        description="Проверьте, что бэкенд запущен, и попробуйте ещё раз."
        collapsible={false}
        endContent={<Button label="На главную" href="/" />}
      />
    );
  }

  if (!car) {
    return (
      <VStack gap={4}>
        <Skeleton height={32} width="40%" />
        <Skeleton height={420} index={1} />
        <Skeleton height={200} index={2} />
      </VStack>
    );
  }

  return <CarView car={car} />;
}

function CarView({car}: {car: CarDetail}) {
  const title = `${car.brand.name} ${car.model}`;

  return (
    <VStack gap={6}>
      <Breadcrumbs>
        <BreadcrumbItem href="/">Все автомобили</BreadcrumbItem>
        <BreadcrumbItem>{title}</BreadcrumbItem>
      </Breadcrumbs>

      <VStack gap={2}>
        <Heading level={1}>{title}</Heading>
        <HStack gap={1} wrap="wrap">
          <Badge label={car.generation} />
          <Badge label={car.body_type} />
          <Badge variant="blue" label={`${car.specs.power_hp} л.с.`} />
        </HStack>
      </VStack>

      <Grid columns={{minWidth: 340}} gap={6} align="start">
        <Gallery images={car.images} title={title} />

        <VStack gap={4}>
          <Card>
            <VStack gap={3}>
              <Heading level={2}>Основная информация</Heading>
              <Text as="p">{car.description}</Text>
              <MetadataList>
                <MetadataListItem label="Марка">{car.brand.name}</MetadataListItem>
                <MetadataListItem label="Модель">{car.model}</MetadataListItem>
                <MetadataListItem label="Поколение">{car.generation}</MetadataListItem>
                <MetadataListItem label="Годы выпуска">{formatYears(car.year_from, car.year_to)}</MetadataListItem>
                <MetadataListItem label="Кузов">{car.body_type}</MetadataListItem>
                <MetadataListItem label="Класс">{car.car_class}</MetadataListItem>
              </MetadataList>
            </VStack>
          </Card>

          <Card variant="muted">
            <VStack gap={3}>
              <Heading level={3}>Где купить</Heading>
              <HStack gap={2} wrap="wrap">
                <Button
                  variant="primary"
                  label="Купить на auto.ru"
                  href={car.links.auto_ru}
                  target="_blank"
                  rel="noopener noreferrer"
                />
                <Button label="Купить на Авито" href={car.links.avito} target="_blank" rel="noopener noreferrer" />
              </HStack>
            </VStack>
          </Card>
        </VStack>
      </Grid>

      <SpecsSection specs={car.specs} />

      <Card>
        <VStack gap={3}>
          <VStack gap={1}>
            <Heading level={2}>История марки {car.brand.name}</Heading>
            <Text type="supporting">
              {car.brand.country} · основана в {car.brand.founded_year} году
            </Text>
          </VStack>
          {car.brand.history.split('\n\n').map((paragraph, i) => (
            <Text as="p" key={i}>
              {paragraph}
            </Text>
          ))}
        </VStack>
      </Card>
    </VStack>
  );
}
