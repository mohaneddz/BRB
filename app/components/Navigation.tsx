import { Tabs } from 'expo-router';
import Icon from '@/components/Icon';

export default function Navigation() {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: '#F8231C',
        tabBarStyle: {
          backgroundColor: 'rgb(10, 10, 9)',
          borderTopWidth: 0,
          elevation: 0,
          shadowOpacity: 0,
        },
      }}
    >
      <Tabs.Screen
        name="Home"
        options={{
          title: 'Home',
          tabBarIcon: ({ color }) => <Icon name="Home" color={color} />,
        }}
      />
      <Tabs.Screen
        name="Presets"
        options={{
          title: 'Presets',
          tabBarIcon: ({ color }) => <Icon name="Sliders" color={color} />,
        }}
      />
      <Tabs.Screen
        name="History"
        options={{
          title: 'History',
          tabBarIcon: ({ color }) => <Icon name="Clock" color={color} />,
        }}
      />
      <Tabs.Screen
        name="Settings"
        options={{
          title: 'Settings',
          tabBarIcon: ({ color }) => <Icon name="Settings" color={color} />,
        }}
      />
    </Tabs>
  );
}
