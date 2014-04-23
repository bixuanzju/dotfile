// This is my configuration for Phoenix <https://github.com/sdegutis/Phoenix>, an awesome
// and super-lightweight OS X window manager that can be configured and scripted through
// the insanity that is Javascript. Heavily recommended. :)
//
// With my admittedly limited Javascript skills, I'm extending the built-in Phoenix classes
// a little to allow for slightly more expressive window configuration (most importantly,
// by being able to pass screen ratios instead of pixel rects, and controlling specific
// apps just a little bit easier.)
//
// Feedback/forks/improvements highly appreciated!
//
// -- hendrik@mans.de
//    twitter.com/hmans
//

var mash = ["cmd", "shift", "ctrl"];
var mashAlt = ['alt', 'shift', 'ctrl'];
var padding = 2;

api.bind('j', mashAlt, leftOneMonitor);
api.bind('l', mashAlt, rightOneMonitor);

api.bind('i', mash, function() {
    Window.focusedWindow().toFullScreen();
});

api.bind('up', mash, function() {
    Window.focusedWindow().toTopHalf();
});

api.bind('down', mash, function() {
    Window.focusedWindow().toBottomHalf();
});

api.bind('j', mash, function() {
    Window.focusedWindow().toLeftHalf();
});

api.bind('l', mash, function() {
    Window.focusedWindow().toRightHalf();
});

api.bind('o', mash, function() {
    api.alert("Layout 1", 0.5);
    forApp("Safari", function(win) {
        win.toLeftHalf();
    });

    forApp("iTerm", function(win) {
        win.toLeftHalf();
    });

    forApp("Emacs", function(win) {
        win.toGrid(0.4, 0, 0.6, 1);
    });

    forApp("Finder", function(win) {
        win.toGrid(0, 0, 0.5, 0.5);
    });
});

// api.bind('2', mash, function() {
//   api.alert("Layout 2", 0.5);

//   forApp("Terminal", function(win) {
//     win.toRightHalf();
//   });

//   forApp("Sublime Text", function(win) {
//     win.toLeftHalf();
//   });

//   forApp("Atom", function(win) {
//     win.toLeftHalf();
//   });
// });


// Let's extend the Phoenix classes a little.
//

var lastFrames = {};

Window.prototype.calculateGrid = function(x, y, width, height) {
    var screen = this.screen().frameWithoutDockOrMenu();

    return {
        x:      Math.round(x * screen.width)       + padding    + screen.x,
        y:      Math.round(y * screen.height)      + padding    + screen.y,
        width:  Math.round(width * screen.width)   - 2*padding,
        height: Math.round(height * screen.height) - 2*padding
    };
};

Window.prototype.toGrid = function(x, y, width, height) {
    var rect = this.calculateGrid(x, y, width, height);
    this.setFrame(rect);
    return this;
};

Window.prototype.toFullScreen = function() {
    var fullFrame = this.calculateGrid(0, 0, 1, 1);

    if (!_.isEqual(this.frame(), fullFrame)) {
        this.rememberFrame();
        return this.toGrid(0, 0, 1, 1);
    } else if (lastFrames[this]) {
        this.setFrame(lastFrames[this]);
        this.forgetFrame();
    }
    return this;
};

Window.prototype.toTopHalf = function() {
    return this.toGrid(0, 0, 1, 0.5);
};

Window.prototype.toBottomHalf = function() {
    return this.toGrid(0, 0.5, 1, 0.5);
};

Window.prototype.toLeftHalf = function() {
    return this.toGrid(0, 0, 0.5, 1);
};

Window.prototype.toRightHalf = function() {
    return this.toGrid(0.5, 0, 0.5, 1);
};

Window.prototype.rememberFrame = function() {
    lastFrames[this] = this.frame();
};

Window.prototype.forgetFrame = function() {
    delete lastFrames[this];
};

App.byTitle = function(title) {
    var apps = this.runningApps();

    for (i = 0; i < apps.length; i++) {
        var app = apps[i];
        if (app.title() == title) {
            app.show();
            return app;
        }
    }
    return this;
};

App.prototype.firstWindow = function() {
    return this.visibleWindows()[0];
};

function forApp(name, f) {
    var app = App.byTitle(name);

    if (app) {
        _.each(app.visibleWindows(), f);
    }
};

// Move windows between monitors

function moveToScreen(win, screen) {
    if (!screen) {
        return;
    }

    var frame = win.frame();
    var oldScreenRect = win.screen().frameWithoutDockOrMenu();
    var newScreenRect = screen.frameWithoutDockOrMenu();

    var xRatio = newScreenRect.width / oldScreenRect.width;
    var yRatio = newScreenRect.height / oldScreenRect.height;

    win.setFrame({
        x: (Math.round(frame.x - oldScreenRect.x) * xRatio) + newScreenRect.x,
        y: (Math.round(frame.y - oldScreenRect.y) * yRatio) + newScreenRect.y,
        width: Math.round(frame.width * xRatio),
        height: Math.round(frame.height * yRatio)
    });
}

function circularLookup(array, index) {
    if (index < 0)
        return array[array.length + (index % array.length)];
    return array[index % array.length];
}

function rotateMonitors(offset) {
    var win = Window.focusedWindow();
    var currentScreen = win.screen();
    var screens = [currentScreen];
    for (var x = currentScreen.previousScreen(); x != win.screen(); x = x.previousScreen()) {
        screens.push(x);
    }

    screens = _(screens).sortBy(function(s) { return s.frameWithoutDockOrMenu().x; });
    var currentIndex = _(screens).indexOf(currentScreen);
    moveToScreen(win, circularLookup(screens, currentIndex + offset));
}

function leftOneMonitor() {
    rotateMonitors(-1);
}

function rightOneMonitor() {
    rotateMonitors(1);
}
