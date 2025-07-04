import { View as RNView, Text as RNText, ViewProps, TextProps } from 'react-native';
import React from 'react';

interface StyledViewProps extends ViewProps {
  className?: string;
  children?: React.ReactNode;
}

interface StyledTextProps extends TextProps {
  className?: string;
  children?: React.ReactNode;
}

// export modified View and Text components
export const View = React.forwardRef<RNView, StyledViewProps>(({ children, className = '', ...props }, ref) => {
  return (
    <RNView className={`flex-1 ${className}`} {...props} ref={ref}>
      {children}
    </RNView>
  );
});

export const Text = React.forwardRef<RNText, StyledTextProps>(({ children, className = '', ...props }, ref) => {
  return (
    <RNText className={`text-text-enabled font-sans ${className}`} {...props} ref={ref}>
      {children}
    </RNText>
  );
});

View.displayName = 'StyledView';
Text.displayName = 'StyledText';