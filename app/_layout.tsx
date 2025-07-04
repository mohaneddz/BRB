import { useFonts } from 'expo-font';
import { Stack } from 'expo-router';
import React from 'react';

import '@/styles/style.css'

export default function RootLayout() {
  const [fontsLoaded] = useFonts({
    'ZenDots': require('../assets/fonts/ZenDots-Regular.ttf'),
  });

  if (!fontsLoaded) return null;

  return (
      <Stack>
        <Stack.Screen name="pages" options={{ headerShown: false }} />
      </Stack>
  );
}