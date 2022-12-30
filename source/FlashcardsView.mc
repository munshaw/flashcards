import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application.Properties;
import Toybox.Math;

class FlashcardsView extends WatchUi.View {
    private const _TEXT_AREA_INCREMENT = 5;

    enum {
        NoDataState,
        FrontState,
        BackState,
    }

    private var _textArea;
    private var _textAreaText;
    private var _textAreaIndex;

    private var _cardFront;
    private var _cardBack;
    private var _cardIndex;

    private var _state;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();

        _textArea = new WatchUi.TextArea({
            :color=>Graphics.COLOR_WHITE,
            :font=>[Graphics.FONT_MEDIUM, Graphics.FONT_SMALL, Graphics.FONT_XTINY],
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :width=>width,
            :height=>height
        });
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        loadRandomCard();
    }

    function loadRandomCard() as Void {
        var deck = Properties.getValue("deck") as Array<Dictionary<String, String>>;

        _textAreaIndex = 0;
        _state = FrontState;

        if (deck.size() == 0) {
            _state = NoDataState;
        }
        else {
            _state = FrontState;
            _cardIndex = Math.rand() % deck.size();
            _cardFront = deck[_cardIndex]["front"];
            _cardBack = deck[_cardIndex]["back"];
            _textAreaText = _cardFront;
        }
    }

    function nextState() as Boolean {
        if (_state == FrontState) {
            _state = BackState;
            _textAreaText = _cardBack;
            _textAreaIndex = 0;
            return true;
        }
        return false;
    }

    function previousState() as Boolean {
        if (_state == BackState) {
            _state = FrontState;
            _textAreaText = _cardFront;
            _textAreaIndex = 0;
            return true;
        }
        return false;
    }

    function setDisplayText() as Void {
        var textToDisplay;
        if (_state == NoDataState) {
            textToDisplay = Rez.Strings.NoData;
        }
        else {
            textToDisplay = _textAreaText;
        }

        if (_textAreaIndex == 0) {
            _textArea.setText("\n" + textToDisplay);
        }
        else {
            _textArea.setText(textToDisplay.substring(_textAreaIndex, null));
        }
    }

    function scrollDown() as Void {
        var newIndex = _textAreaIndex + _TEXT_AREA_INCREMENT;
        if (newIndex < _textAreaText.length()) {
            _textAreaIndex = newIndex;
        }
    }

    function scrollUp() as Void {
        var newIndex = _textAreaIndex - _TEXT_AREA_INCREMENT;
        if (newIndex >= 0) {
            _textAreaIndex = newIndex;
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        setDisplayText();
        _textArea.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
