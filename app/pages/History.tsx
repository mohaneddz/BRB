import { View, Text } from '@/components/Styled';
import { useState } from 'react';
import Modal from '@/components/ui/Modal';
import { Pressable } from 'react-native';

export default function History() {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const openModal = () => setIsModalOpen(true);
  const closeModal = () => setIsModalOpen(false);

  return (
    <View className='bg-bg-dark h-full w-full flex-1 items-center justify-center'>
        <Text className='text-red-700 text-4xl text-center'>History</Text>


      <Pressable
        className='bg-primary px-6 py-3 rounded-lg mt-8'
        onPress={openModal}
      >
        <Text className='text-white text-lg font-semibold'>View Details</Text>
      </Pressable>

      <Modal isOpen={isModalOpen} onClose={closeModal}>
        <Text className='text-white text-xl font-bold mb-4'>History Details</Text>
        <View className='flex-col gap-3'>
          <Text className='text-white text-base'>• Last activity: 2 hours ago</Text>
          <Text className='text-white text-base'>• Total sessions: 15</Text>
          <Text className='text-white text-base'>• Average duration: 45 min</Text>
          <Text className='text-white text-base'>• Best streak: 7 days</Text>
        </View>

        <Pressable
          className='bg-primary px-4 py-2 rounded mt-4 self-center mx-auto'
          onPress={closeModal}
        >
          <Text className='text-white'>Done</Text>
        </Pressable>
      </Modal>

      <Text className='text-red-700 text-xl mt-8'>Background Content</Text>
    </View>
  );
}