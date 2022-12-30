import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application.Properties;
import Toybox.Math;

class flashcardsView extends WatchUi.View {

    private var _textArea;
    private var _width;
    private var _height;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        _width = dc.getWidth();
        _height = dc.getHeight();

        _textArea = new WatchUi.TextArea({
            :color=>Graphics.COLOR_WHITE,
            :font=>[Graphics.FONT_MEDIUM, Graphics.FONT_SMALL, Graphics.FONT_XTINY],
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :width=>_width,
            :height=>_height
        });
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var deck = Properties.getValue("deck") as Array<Dictionary<String, String>>;
        if (deck.size() == 0) {
            _textArea.setText(Rez.Strings.NoData);
        }
        else {
            var randomIndex = Math.rand() % deck.size();
            var cardFront = deck[randomIndex]["front"];
            var cardBack = deck[randomIndex]["back"];
            _textArea.setText(cardFront);
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        _textArea.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
