import { View, Text } from '@/components/Styled';
import { Pressable } from 'react-native';
import { useState } from 'react';

import Icon from '@/components/ui/Icon';

interface Props {
    title: string;
    onDelete: () => void;
    onEdit: () => void;
}

export default function PresetCard(props: Props) {
    const [deletePressed, setDeletePressed] = useState(false);
    const [editPressed, setEditPressed] = useState(false);

    const handleDelete = () => {
        try {
            console.log('Delete Preset');
            setDeletePressed(false);
        } catch (error) {
            console.error('Delete error:', error);
        }
    };

    const handleEdit = () => {
        try {
            console.log('Edit Preset');
            setEditPressed(false);
        } catch (error) {
            console.error('Edit error:', error);
        }
    };

    return (
        <View className='border-2 border-primary bg-fg-muted h-20 rounded-md flex px-2 justify-center'>
            <Text className='text-xl text-white ml-4'>{props.title}</Text>

            <View className='flex flex-row gap-2 absolute right-2'>
                <Pressable
                    className='p-2 border rounded-md border-red-400'
                    onPressIn={() => setDeletePressed(true)}
                    onPressOut={() => setDeletePressed(false)}
                    onPress={props.onDelete || handleDelete}
                    style={{
                        backgroundColor: deletePressed
                            ? 'rgba(239, 68, 68, 0.4)' // bg-red-500/40
                            : 'rgba(239, 68, 68, 0.2)', // bg-red-500/20
                        transform: deletePressed ? [{ scale: 0.95 }] : [],
                        shadowColor: '#30302e',
                        shadowOffset: { width: 0, height: 2 },
                        shadowOpacity: 0.3,
                        shadowRadius: 4,
                        elevation: 4,
                    }}
                >
                    <Icon
                        name='Trash'
                        color={deletePressed ? '#ff6b6b' : '#ef4444'}
                        size={16}
                    />
                </Pressable>

                <Pressable
                    className='p-2 border rounded-md border-red-400'
                    onPressIn={() => setEditPressed(true)}
                    onPressOut={() => setEditPressed(false)}
                    onPress={props.onEdit || handleEdit}
                    style={{
                        backgroundColor: editPressed
                            ? 'rgba(239, 68, 68, 0.4)'
                            : 'rgba(239, 68, 68, 0.2)',
                        transform: editPressed ? [{ scale: 0.95 }] : [],
                        shadowColor: '#30302e',
                        shadowOffset: { width: 0, height: 2 },
                        shadowOpacity: 0.3,
                        shadowRadius: 4,
                        elevation: 4,
                    }}
                >
                    <Icon
                        name='Pencil'
                        color={editPressed ? '#ff6b6b' : '#ef4444'}
                        size={16}
                    />
                </Pressable>
            </View>
        </View>
    );
}
