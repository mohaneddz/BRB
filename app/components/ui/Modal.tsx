import { View, Text } from '@/components/Styled';
import Icon from '@/components/ui/Icon';
import { Pressable } from 'react-native';

interface Props {
    children?: React.ReactNode;
    onClose?: () => void;
    isOpen?: boolean;
    className?: string;
    style?: React.CSSProperties;
    closeButton?: boolean;
}

export default function Modal(props: Props) {
    if (!props.isOpen) return null;

    const handleBackdropPress = () => {
        if (props.onClose) {
            props.onClose();
        }
    };

    const handleContentPress = (e: any) => {
        e.stopPropagation();
    };

    return (
        <Pressable
            className='absolute top-0 left-0 w-full h-full items-center justify-center px-20'
            style={{ zIndex: 30, backgroundColor: 'rgba(0, 0, 0, 0.8)' }}
            onPress={handleBackdropPress}
        >
                <Pressable
                    className='bg-fg-muted border-2 border-primary rounded-md'
                    style={{ opacity: 1, position: 'relative', padding: 20 }}
                    onPress={handleContentPress}
                >
                    {
                        props.closeButton ? (
                            <>
                                {/* X button */}
                                <Pressable
                                    className='absolute top-2 right-2 w-8 h-8 bg-red-500 rounded-full items-center justify-center'
                                    style={{ zIndex: 31 }}
                                    onPress={props.onClose}
                                >
                                    <Icon name="X" size={20} color="white" />
                                </Pressable>
                            </>
                        ) : (
                            <>
                            </>
                        )
                    }
                    {props.children ? props.children : 'Modal Content'}
                </Pressable>
        </Pressable>
    );
}