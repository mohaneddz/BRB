import { View, Text } from '@/components/Styled';
import { useState, useEffect } from 'react';
import { PanResponder, Dimensions } from 'react-native';
import Animated, { 
  useSharedValue, 
  useAnimatedStyle, 
  withSpring
} from 'react-native-reanimated';

interface SliderProps {
  value: number;
  onValueChange: (value: number) => void;
  min?: number;
  max?: number;
  step?: number;
  width?: number;
  label?: string;
}

export default function CustomSlider({ 
  value, 
  onValueChange, 
  min = 0, 
  max = 100, 
  step = 1, 
  width = 200,
  label 
}: SliderProps) {
  const [sliderWidth] = useState(width);
  const thumbSize = 20; // Thumb diameter
  const trackWidth = sliderWidth - thumbSize;
  
  const thumbPosition = useSharedValue((value - min) / (max - min) * trackWidth);

  // Update thumb position when value changes
  useEffect(() => {
    thumbPosition.value = withSpring((value - min) / (max - min) * trackWidth);
  }, [value, min, max, trackWidth]);

  const panResponder = PanResponder.create({
    onStartShouldSetPanResponder: () => true,
    onMoveShouldSetPanResponder: () => true,
    onPanResponderGrant: () => {
      // Reset spring when user starts dragging
    },
    onPanResponderMove: (event, gestureState) => {
      // Calculate position relative to the slider track
      const newX = Math.max(0, Math.min(trackWidth, gestureState.moveX - thumbSize/2));
      thumbPosition.value = newX;
      
      const newValue = Math.round(((newX / trackWidth) * (max - min) + min) / step) * step;
      onValueChange(Math.max(min, Math.min(max, newValue)));
    },
    onPanResponderRelease: () => {
      // Optional: Add spring animation on release
      thumbPosition.value = withSpring(thumbPosition.value);
    },
  });

  const animatedStyle = useAnimatedStyle(() => {
    return {
      transform: [{ translateX: thumbPosition.value }],
    };
  });

  const progressStyle = useAnimatedStyle(() => {
    return {
      width: thumbPosition.value + thumbSize/2,
    };
  });

  return (
    <View className='flex-1'>
      {label && <Text className='text-white text-base mb-2'>{label}</Text>}
      <View className='flex flex-row items-center gap-2'>
        <View 
          className='relative bg-gray-700 rounded-full'
          style={{ width: sliderWidth, height: 4 }}
        >
          {/* Progress fill */}
          <Animated.View 
            className='absolute top-0 left-0 bg-red-500 rounded-full'
            style={[{ height: 4 }, progressStyle]}
          />
          
          {/* Slider thumb */}
          <Animated.View
            className='absolute top-0 w-5 h-5 bg-red-500 rounded-full border-2 border-white'
            style={[
              { 
                marginTop: -8,
                marginLeft: 0, // Half of thumb width to center it
                shadowColor: '#000',
                shadowOffset: { width: 0, height: 2 },
                shadowOpacity: 0.25,
                shadowRadius: 3.84,
                elevation: 5,
              },
              animatedStyle
            ]}
            {...panResponder.panHandlers}
          />
        </View>
        <Text className='text-white text-sm min-w-[40px]'>{value}%</Text>
      </View>
    </View>
  );
}