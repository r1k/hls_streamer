const VjsButton = videojs.getComponent('Button');

class StopButton extends VjsButton {
    constructor(player, options) {
        super(player, options);
    }

    createEl() {
        let el = super.createEl('button', {}, {});
        el.innerHTML = 'STOP'
        return el;
    }
}

document.addEventListener("DOMContentLoaded", function(event) {
    
    VjsButton.registerComponent('StopButton', StopButton);

    var player = videojs('my-player', {} );

    player.on('ready', () => {
        player.src({type: 'application/x-mpegURL', 
                    src : "/data/playlist.m3u8"
                });
    });

    var button = new StopButton(player, {clickHandler : () => { 
        player.reset();
    }});
    button.createEl();

    player.controlBar.addChild(button, {});
});