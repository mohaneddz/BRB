import * as LucideIcons from 'lucide-react-native';
import type { LucideIcon } from 'lucide-react-native';
import { ViewStyle } from 'react-native';

type Props = {
  name: string;
  color?: string;
  size?: number;
  style?: ViewStyle;
};

export default function Icon(props: Props) {
  const IconComponent = (LucideIcons as any)[props.name];

  if (!IconComponent) {
    console.warn(`Icon "${props.name}" not found in Lucide icons`);
    return null;
  }

  return (
    <IconComponent
      className=""
      size={props.size || 24}
      color={props.color}
      style={[{ marginBottom: -3 }, props.style]}
    />
  );
}
