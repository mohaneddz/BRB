import { Stack } from 'expo-router';
import { View, Text } from '@/components/Styled';

export default function NotFoundScreen() {
  return (
    <>
      <Stack.Screen options={{ title: 'Oops!' }} />
      <View className='flex-1 items-center justify-center bg-white dark:bg-gray-900'>
        <Text className='text-2xl font-bold text-gray-900 dark:text-white'>
          NOT FOUND
        </Text>
      </View>
    </>
  );
}

