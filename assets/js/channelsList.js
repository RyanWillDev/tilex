import { Socket } from 'phoenix';

export default class ChannelsList {
  constructor(properties) {
    this.channelsListChangeCallback = properties.channelsListChangeCallback;
    this.socket = new Socket('/socket');
    this.channel = this.socket.channel('channels_list', {});
  }

  init() {
    this.socket.connect();
    this.channel.join();
    this.observeChannelResponse();
  }

  addChannel(channelData) {
    this.channel.push('add', channelData);
  }

  observeChannelResponse() {
    this.channel.on('updated', payload => {
      this.channelsListChangeCallback(payload.channels);
    });
  }
}
