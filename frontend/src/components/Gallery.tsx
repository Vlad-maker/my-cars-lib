import {useState} from 'react';
import * as stylex from '@stylexjs/stylex';
import {AspectRatio} from '@astryxdesign/core/AspectRatio';
import {Card} from '@astryxdesign/core/Card';
import {HStack} from '@astryxdesign/core/HStack';
import {Link} from '@astryxdesign/core/Link';
import {Text} from '@astryxdesign/core/Text';
import {Thumbnail} from '@astryxdesign/core/Thumbnail';
import {VStack} from '@astryxdesign/core/VStack';
import type {CarImage} from '../api/types';

const styles = stylex.create({
  image: {
    width: '100%',
    height: '100%',
    objectFit: 'cover',
    display: 'block',
  },
  selected: {
    outlineWidth: 2,
    outlineStyle: 'solid',
    outlineColor: 'currentColor',
    outlineOffset: 2,
  },
});

interface GalleryProps {
  images: CarImage[];
  title: string;
}

/** Main photo + thumbnails, with attribution required by CC licenses (AC-2.1). */
export function Gallery({images, title}: GalleryProps) {
  const [index, setIndex] = useState(0);
  const current = images[index] ?? images[0];

  if (!current) {
    return (
      <Card>
        <Text type="supporting">Фотографий пока нет</Text>
      </Card>
    );
  }

  return (
    <VStack gap={2}>
      <Card padding={0}>
        <AspectRatio ratio={16 / 9} fit="cover">
          <img src={current.url} alt={`${title}, фото ${index + 1}`} {...stylex.props(styles.image)} />
        </AspectRatio>
      </Card>

      <Text type="supporting" size="sm">
        Фото: {current.author} ·{' '}
        <Link href={current.source_url} target="_blank" isExternalLink>
          {current.license}, Wikimedia Commons
        </Link>
      </Text>

      {images.length > 1 && (
        <HStack gap={2} wrap="wrap">
          {images.map((img, i) => (
            <Thumbnail
              key={img.url}
              src={img.url}
              alt={`${title}, миниатюра ${i + 1}`}
              label={`Фото ${i + 1}`}
              onClick={() => setIndex(i)}
              xstyle={i === index ? styles.selected : undefined}
            />
          ))}
        </HStack>
      )}
    </VStack>
  );
}
