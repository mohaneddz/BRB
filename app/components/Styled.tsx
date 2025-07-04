import React from 'react';
import {
  View as RNView,
  Text as RNText,
  ViewProps,
  TextProps,
  Pressable,
  GestureResponderEvent,
  ActivityIndicator,
} from 'react-native';
import Icon from '@/components/ui/Icon';

interface StyledViewProps extends ViewProps {
  className?: string;
  children?: React.ReactNode;
}

interface StyledTextProps extends TextProps {
  className?: string;
  children?: React.ReactNode;
}

interface ButtonProps {
  onPress?: (event: GestureResponderEvent) => void;
  title?: string;
  iconLeft?: string; // icon name (e.g., "Check", "ArrowRight")
  iconRight?: string;
  icon?: string; // middle icon (when no title or replaces title)
  loading?: boolean;
  disabled?: boolean;
  className?: string;
  textClassName?: string;
  iconColor?: string;
  iconSize?: number;
}

// Styled View
export const View = React.forwardRef<RNView, StyledViewProps>(
  ({ children, className = '', ...props }, ref) => {
    return (
      <RNView className={className} {...props} ref={ref}>
        {children}
      </RNView>
    );
  }
);

// Styled Text
export const Text = React.forwardRef<RNText, StyledTextProps>(
  ({ children, className = '', ...props }, ref) => {
    return (
      <RNText
        className={`text-text-enabled font-sans ${className}`}
        {...props}
        ref={ref}
      >
        {children}
      </RNText>
    );
  }
);

// Styled Button
export const Button: React.FC<ButtonProps> = ({
  onPress,
  title,
  iconLeft,
  iconRight,
  icon,
  loading = false,
  disabled = false,
  className = '',
  textClassName = '',
  iconColor = 'white',
  iconSize = 20,
}) => {
  const buttonClasses = `
    flex-row items-center justify-center rounded-xl px-4 py-3 bg-primary
    ${disabled ? 'opacity-50' : ''} 
    ${loading ? 'opacity-70' : ''} 
    ${className}
  `;

  const textClasses = `
    text-white font-semibold text-base 
    ${textClassName}
  `;

  return (
    <Pressable onPress={onPress} disabled={disabled || loading} className={buttonClasses}>
      {loading ? (
        <ActivityIndicator color="white" className="mr-2" />
      ) : (
        iconLeft && (
          <Icon
            name={iconLeft}
            size={iconSize}
            color={iconColor}
            style={{ marginRight: 8 }}
          />
        )
      )}

      {icon && !loading ? (
        <Icon
          name={icon}
          size={iconSize}
          color={iconColor}
        />
      ) : (
        title && <RNText className={textClasses}>{title}</RNText>
      )}

      {iconRight && !loading && (
        <Icon
          name={iconRight}
          size={iconSize}
          color={iconColor}
          style={{ marginLeft: 8 }}
        />
      )}
    </Pressable>
  );
};
View.displayName = 'StyledView';
Text.displayName = 'StyledText';

export default {
  View,
  Text,
  Button
}