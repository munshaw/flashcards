using Toybox.WatchUi;

class FlashcardsDelegate extends WatchUi.BehaviorDelegate {
    private var _view;

    function initialize(view) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    function onNextPage() {
        _view.scrollDown();
        WatchUi.requestUpdate();
        return true;
    }

    function onPreviousPage() {
        _view.scrollUp();
        WatchUi.requestUpdate();
        return true;
    }

    function onSelect() {
        _view.nextState();
        WatchUi.requestUpdate();
        return true;
    }

    function onBack() {
        if (_view.previousState()) {
            WatchUi.requestUpdate();
            return true;
        }
        return false;
    }

}