import { NativeModules } from 'react-native';

const { NativeSyncScrollViews = {} } = NativeModules;

interface NativeSyncScrollViewsInterface {
	syncScrollEvent(primaryNodeID: number, secondaryNodeID: number): void;
}

export const { syncScrollEvent } = NativeSyncScrollViews;

export default NativeSyncScrollViews as NativeSyncScrollViewsInterface;
