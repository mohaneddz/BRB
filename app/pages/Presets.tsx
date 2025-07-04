import { View, Text } from '@/components/Styled';
import PresetCard from '@/components/presets/PresetCard';
import Modal from '@/components/ui/Modal';
import Slider from '@/components/ui/Slider';
import Checkbox from '@/components/ui/Checkbox';
import { useState } from 'react';
import { Pressable, TextInput } from 'react-native';
import Icon from '@/components/ui/Icon';

interface PresetCard {
  id: number;
  title: string;
  distance: number;
  delay: number;
  vibration: boolean;
  lock: boolean;
  volume: number;
  sound: number;
}

export default function Presets() {
  const [cards, setCards] = useState<PresetCard[]>([
    { id: 1, title: 'GYM', distance: 50, delay: 10, vibration: true, lock: true, volume: 80, sound: 60 },
    { id: 2, title: 'HOME', distance: 30, delay: 5, vibration: false, lock: false, volume: 50, sound: 40 },
    { id: 3, title: 'OFFICE', distance: 20, delay: 15, vibration: true, lock: true, volume: 30, sound: 20 },
  ]);

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingCard, setEditingCard] = useState<PresetCard | null>(null);

  const handleEdit = (card: PresetCard) => {
    setEditingCard(card);
    setIsModalOpen(true);
  };

  const handleSave = () => {
    if (editingCard) {
      setCards(cards.map(card =>
        card.id === editingCard.id ? editingCard : card
      ));
    }
    setIsModalOpen(false);
    setEditingCard(null);
  };

  const handleClose = () => {
    setIsModalOpen(false);
    setEditingCard(null);
  };

  const handleAddPreset = () => {
    const newCard: PresetCard = {
      id: Date.now(),
      title: 'New Preset',
      distance: 0,
      delay: 0,
      vibration: false,
      lock: false,
      volume: 50,
      sound: 50,
    };
    setCards([...cards, newCard]);
    setEditingCard(newCard);
    setIsModalOpen(true);
  };

  return (
    <View className='bg-bg-dark h-full w-full flex-1'>
      <View className='p-8 pt-16'>
        <Text className='text-red-700 text-4xl text-center'>Presets</Text>

        <View className='flex flex-col gap-4 mt-12'>
          {
            cards.map((card) => (
              <PresetCard
                key={card.id}
                title={card.title}
                onDelete={() => {
                  setCards(cards.filter((c) => c.id !== card.id));
                }}
                onEdit={() => {
                  handleEdit(card);
                }}
              />
            ))
          }
        </View>
      </View>

      {/* button to add new Preset */}
      <Pressable
        className='absolute rounded-full bg-primary p-4 mr-4 mb-4 bottom-0 right-0'
        style={{
          boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)'
        }}
        onPress={handleAddPreset}
      >
        <Icon name='Plus' color='#fff' size={28} style={{ transform: [{ translateY: -1 }] }} />
      </Pressable>


      <Modal isOpen={isModalOpen} onClose={handleClose} closeButton={true}>
        <View className='w-80 mx-auto'>
          <Text className='text-white text-xl font-bold mb-6 text-center'>
            Edit {editingCard?.title} Settings
          </Text>

          <View className='flex flex-col gap-6'>

            {/* Distance & Delay - Row 1 */}
            <View className='flex flex-row gap-4'>
              <View className='flex-1'>
                <Text className='text-white text-base mb-2'>Distance</Text>
                <TextInput
                  className='bg-bg-dark text-white p-3 rounded border border-gray-600 text-center'
                  style={{
                    fontSize: 16,
                    fontWeight: '600',
                    outlineStyle: 'none'
                  }}
                  value={editingCard?.distance?.toString()}
                  onChangeText={(text) =>
                    setEditingCard(prev => prev ? { ...prev, distance: parseInt(text) || 0 } : null)
                  }
                  keyboardType="numeric"
                  placeholder="0"
                  placeholderTextColor="#666"
                />
              </View>
              <View className='flex-1'>
                <Text className='text-white text-base mb-2'>Delay</Text>
                <TextInput
                  className='bg-bg-dark text-white p-3 rounded border border-gray-600 text-center'
                  style={{
                    fontSize: 16,
                    fontWeight: '600',
                    outlineStyle: 'none'
                  }}
                  value={editingCard?.delay?.toString()}
                  onChangeText={(text) =>
                    setEditingCard(prev => prev ? { ...prev, delay: parseInt(text) || 0 } : null)
                  }
                  keyboardType="numeric"
                  placeholder="0"
                  placeholderTextColor="#666"
                />
              </View>
            </View>


            {/* Vibration & Lock - Row 2 */}
            <View className='flex flex-row gap-4'>
              <View className='flex-1'>
                <Checkbox
                  checked={editingCard?.vibration || false}
                  onToggle={() => setEditingCard(prev => prev ? { ...prev, vibration: !prev.vibration } : null)}
                  label="Vibration"
                />
              </View>
              <View className='flex-1'>
                <Checkbox
                  checked={editingCard?.lock || false}
                  onToggle={() => setEditingCard(prev => prev ? { ...prev, lock: !prev.lock } : null)}
                  label="Lock"
                />
              </View>
            </View>

            {/* Volume & Sound - Row 3 */}
            <View className='flex flex-row gap-4'>
              <View className='flex-1'>
                <Slider
                  value={editingCard?.volume || 0}
                  onValueChange={(value) => setEditingCard(prev => prev ? { ...prev, volume: value } : null)}
                  min={0}
                  max={100}
                  step={1}
                  width={80}
                  label="Volume"
                />
              </View>
              <View className='flex-1'>
                <Slider
                  value={editingCard?.sound || 0}
                  onValueChange={(value) => setEditingCard(prev => prev ? { ...prev, sound: value } : null)}
                  min={0}
                  max={100}
                  step={1}
                  width={80}
                  label="Sound"
                />
              </View>
            </View>

            <View className='flex flex-row gap-3 mt-6'>
              <Pressable
                className='bg-primary px-6 py-3 rounded flex-1'
                onPress={handleSave}
              >
                <Text className='text-white text-center font-semibold'>Save</Text>
              </Pressable>

              <Pressable
                className='bg-red-500 px-6 py-3 rounded flex-1'
                onPress={handleClose}
              >
                <Text className='text-white text-center font-semibold'>Cancel</Text>
              </Pressable>
            </View>
          </View>
        </View>
      </Modal>

    </View>
  );
}