import TextConversion from './text_conversion';
import autosize from 'autosize';
import CodeMirror from 'codemirror';
import ChannelsList from './channelsList';
import 'codemirror-mode-elixir';
import 'codemirror/keymap/vim';
import 'codemirror/mode/gfm/gfm';
import 'codemirror/mode/ruby/ruby';
import 'codemirror/mode/javascript/javascript';
import 'codemirror/mode/go/go';
import 'codemirror/mode/elm/elm';
import 'codemirror/mode/erlang/erlang';
import 'codemirror/mode/css/css';
import 'codemirror/mode/sass/sass';

export default class PostForm {
  constructor(properties) {
    this.$postBodyInput = properties.postBodyInput;
    this.$postBodyPreview = properties.postBodyPreview;
    this.$wordCountContainer = properties.wordCountContainer;
    this.$bodyWordLimitContainer = properties.bodyWordLimitContainer;
    this.bodyWordLimit = properties.bodyWordLimit;
    this.$titleInput = properties.titleInput;
    this.$titleCharacterLimitContainer =
      properties.titleCharacterLimitContainer;
    this.$addChannelButton = properties.addChannelButton;
    this.$newChannelNameInput = properties.newChannelNameInput;
    this.$newChannelHashtagInput = properties.newChannelHashTagInput;
    this.$channelSelect = properties.channelSelect;
    this.titleCharacterLimit = properties.titleCharacterLimit;
    this.$previewTitleContainer = properties.previewTitleContainer;
    this.handlePostBodyPreview = this.handlePostBodyPreview.bind(this);
    this.handleAddChannel = this.handleAddChannel.bind(this);
    this.textConversion = this.textConversion();
    this.channelsList = this.channelsList();
  }

  init() {
    if (!this.$postBodyInput.length) {
      return;
    }

    this.textConversion.init();
    this.channelsList.init();

    this.setInitialPreview();
    this.observePostBodyInputChange();
    this.observeTitleInputChange();
    autosize(this.$postBodyInput);

    if (/Code Editor|Vim/.test(TIL.editor)) {
      const defaultOptions = {
        lineNumbers: true,
        theme: 'dracula',
        tabSize: 2,
        mode: 'gfm',
        insertSoftTab: true,
        smartIndent: false,
        lineWrapping: true
      };

      const options =
        TIL.editor === 'Vim'
          ? Object.assign({}, defaultOptions, { keyMap: 'vim' })
          : defaultOptions;

      const textarea = this.$postBodyInput.get(0);
      const editor = CodeMirror.fromTextArea(textarea, options);

      const that = this;
      editor.on('changes', instance => {
        const value = instance.getValue();
        that.$postBodyInput.val(value).trigger('change');
      });
    }

    this.$addChannelButton.on('click', this.handleAddChannel);
  }

  setInitialPreview() {
    this.textConversion.convert(this.$postBodyInput.text(), 'markdown');
    this.updateWordCount();
    this.updateWordLimit();
    this.updateTitleLimit();
    this.updatePreviewTitle();
  }

  wordCount() {
    return this.$postBodyInput
      .val()
      .split(/\s+|\n/)
      .filter(Boolean).length;
  }

  updateWordCount() {
    this.$wordCountContainer.html(this.wordCount());
  }

  updateWordLimit() {
    this.renderCountMessage(
      this.$bodyWordLimitContainer,
      this.bodyWordLimit - this.wordCount(),
      'word'
    );
  }

  updateTitleLimit() {
    this.renderCountMessage(
      this.$titleCharacterLimitContainer,
      this.titleCharacterLimit - this.$titleInput.val().length,
      'character'
    );
  }

  updatePreviewTitle() {
    this.$previewTitleContainer.html(this.$titleInput.val());
  }

  renderCountMessage($el, amount, noun) {
    var plural = amount === 1 ? '' : 's';
    $el
      .toggleClass('negative', amount < 0)
      .text(amount + ' ' + noun + plural + ' available');
  }

  handlePostBodyPreview(html) {
    Prism.highlightAll(this.$postBodyPreview.html(html));
  }

  handleAddChannel() {
    if (!this.$newChannelNameInput.val() || !this.$newChannelHashtagInput.val())
      return;

    this.channelsList.addChannel({
      name: this.$newChannelNameInput.val(),
      twitter_hashtag: this.$newChannelHashtagInput.val()
    });
  }

  handleChannelListUpdate(channels) {
    if (!channels.length) return;

    var html = channels.map(function(channel) {
      return $('<option>')
        .val(channel.id)
        .text(channel.name);
    });

    this.$channelSelect.html(html);
  }

  observePostBodyInputChange() {
    this.$postBodyInput.on('keyup', e => {
      this.updateWordCount();
      this.updateWordLimit();
      this.textConversion.convert(e.target.value, 'markdown');
    });

    this.$postBodyInput.on('change', e => {
      this.updateWordCount();
      this.updateWordLimit();
      this.textConversion.convert(e.target.value, 'markdown');
    });
  }

  observeTitleInputChange() {
    this.$titleInput.on('input', e => {
      this.updateTitleLimit();
      this.updatePreviewTitle();
    });
  }

  textConversion() {
    return new TextConversion({
      convertedTextCallback: this.handlePostBodyPreview
    });
  }

  channelsList() {
    return new ChannelsList({
      channelsListChangeCallback: this.handleChannelListUpdate.bind(this)
    });
  }
}
