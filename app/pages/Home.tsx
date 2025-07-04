// @ts-ignore
import Looper from '@/assets/svg/looper.svg';
import { Image, Text, View } from 'react-native';

export default function TabOneScreen() {
  return (
    <View className='bg-bg-dark h-full w-full flex-1 items-center justify-center'>
      <View className='relative w-full h-full flex-1 items-center justify-center'>
        <Looper height="100%" width="100%" />
        <Text className='absolute text-text-disabled/40 text-6xl font-sans' >OFF</Text>
      </View>
    </View>
  );
}
