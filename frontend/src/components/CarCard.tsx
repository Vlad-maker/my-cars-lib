import * as stylex from '@stylexjs/stylex';
import {AspectRatio} from '@astryxdesign/core/AspectRatio';
import {Badge} from '@astryxdesign/core/Badge';
import {ClickableCard} from '@astryxdesign/core/ClickableCard';
import {Heading} from '@astryxdesign/core/Heading';
import {HStack} from '@astryxdesign/core/HStack';
import {Text} from '@astryxdesign/core/Text';
import {VStack} from '@astryxdesign/core/VStack';
import type {CarSummary} from '../api/types';
import {formatYears} from '../lib/format';

const styles = stylex.create({
  image: {
    width: '100%',
    height: '100%',
    objectFit: 'cover',
    display: 'block',
  },
});

export function CarCard({car}: {car: CarSummary}) {
  const title = `${car.brand} ${car.model}`;

  return (
    <ClickableCard href={`/cars/${car.slug}`} label={title} padding={0} elevation="low">
      <AspectRatio ratio={16 / 10} fit="cover">
        {car.cover_image_url ? (
          <img src={car.cover_image_url} alt={title} loading="lazy" {...stylex.props(styles.image)} />
        ) : (
          <div />
        )}
      </AspectRatio>
      <VStack gap={2} padding={3}>
        <Heading level={3} maxLines={1}>
          {title}
        </Heading>
        <Text type="supporting">
          {car.generation} · {formatYears(car.year_from, car.year_to)}
        </Text>
        <HStack gap={1} wrap="wrap">
          <Badge label={car.body_type} />
          <Badge variant="blue" label={`${car.power_hp} л.с.`} />
        </HStack>
      </VStack>
    </ClickableCard>
  );
}
