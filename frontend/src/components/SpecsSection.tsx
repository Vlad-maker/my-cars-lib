import {Card} from '@astryxdesign/core/Card';
import {Grid} from '@astryxdesign/core/Grid';
import {Heading} from '@astryxdesign/core/Heading';
import {MetadataList, MetadataListItem} from '@astryxdesign/core/MetadataList';
import {Text} from '@astryxdesign/core/Text';
import {VStack} from '@astryxdesign/core/VStack';
import type {Specs} from '../api/types';
import {formatEngineVolume, withUnit} from '../lib/format';

type Row = [label: string, value: string];

function groups(s: Specs): Array<{title: string; rows: Row[]}> {
  return [
    {
      title: 'Двигатель и трансмиссия',
      rows: [
        ['Тип двигателя', s.engine_type],
        ['Объём', formatEngineVolume(s.engine_volume_cc)],
        ['Мощность', withUnit(s.power_hp, 'л.с.')],
        ['Крутящий момент', withUnit(s.torque_nm, 'Н·м')],
        ['Коробка передач', s.transmission],
        ['Привод', s.drive],
      ],
    },
    {
      title: 'Динамика и расход',
      rows: [
        ['Разгон 0–100 км/ч', withUnit(s.acceleration_s, 'с')],
        ['Максимальная скорость', withUnit(s.top_speed_kmh, 'км/ч')],
        ['Расход (смешанный)', withUnit(s.fuel_consumption_l, 'л/100 км')],
        ['Объём бака', withUnit(s.fuel_tank_l, 'л')],
      ],
    },
    {
      title: 'Размеры и масса',
      rows: [
        ['Длина × ширина × высота', `${s.length_mm} × ${s.width_mm} × ${s.height_mm} мм`],
        ['Колёсная база', withUnit(s.wheelbase_mm, 'мм')],
        ['Снаряжённая масса', withUnit(s.curb_weight_kg, 'кг')],
        ['Багажник', withUnit(s.trunk_l, 'л')],
        ['Мест', String(s.seats)],
      ],
    },
  ];
}

/** Technical specs grouped into three cards (AC-2.3). */
export function SpecsSection({specs}: {specs: Specs}) {
  return (
    <VStack gap={3}>
      <VStack gap={1}>
        <Heading level={2}>Технические характеристики</Heading>
        <Text type="supporting">Версия {specs.version_note}. Данные справочные.</Text>
      </VStack>
      <Grid columns={{minWidth: 300}} gap={4}>
        {groups(specs).map((group) => (
          <Card key={group.title}>
            <MetadataList title={<Heading level={3}>{group.title}</Heading>} label={{position: 'top'}}>
              {group.rows.map(([label, value]) => (
                <MetadataListItem key={label} label={label}>
                  {value}
                </MetadataListItem>
              ))}
            </MetadataList>
          </Card>
        ))}
      </Grid>
    </VStack>
  );
}
