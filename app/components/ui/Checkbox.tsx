import { View, Text } from '@/components/Styled';
import { Pressable } from 'react-native';

interface CheckboxProps {
  checked: boolean;
  onToggle: () => void;
  label?: string;
}

export default function CustomCheckbox({ checked, onToggle, label }: CheckboxProps) {
  return (
    <View className='flex-1 flex flex-row items-center justify-between'>
      {label && <Text className='text-white'>{label}</Text>}
      <Pressable
        className={`w-6 h-6 rounded border-2 items-center justify-center ${
          checked 
            ? 'bg-red-500 border-red-500' 
            : 'bg-transparent border-gray-500'
        }`}
        onPress={onToggle}
      >
        {checked && (
          <View className='w-3 h-3 bg-white rounded-sm' />
        )}
      </Pressable>
    </View>
  );
}