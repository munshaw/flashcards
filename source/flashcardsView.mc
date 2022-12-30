import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application.Properties;
import Toybox.Math;

class flashcardsView extends WatchUi.View {
    private var _textArea;
    private var _textAreaIndex;

    private var _cardFront;
    private var _cardBack;
    private var _cardIndex;

    private var _hasNoData;

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
        _hasNoData = deck.size() == 0;
        _textAreaIndex = 0;
        if (!_hasNoData) {
            _cardIndex = Math.rand() % deck.size();
            _cardFront = deck[_cardIndex]["front"];
            _cardBack = deck[_cardIndex]["back"];
        }
    }

    function setDisplayText() as Void {
        var textToDisplay;
        if (_hasNoData) {
            textToDisplay = Rez.Strings.NoData;
        }
        else {
            textToDisplay = _cardFront;
        }

        if (_textAreaIndex == 0) {
            _textArea.setText("\n" + textToDisplay);
        }
        else {
            var ss = textToDisplay.substring(_textAreaIndex, null);
            _textArea.setText(ss);
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
