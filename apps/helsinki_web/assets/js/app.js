// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
let Hooks = {};
Hooks.scroll_x = {
    mounted() {        
        var max = document.getElementById("scrolleable").offsetWidth
        var left = max - screen.width;
        setTimeout(() => {
            window.scrollTo(left + 100, 0)
        }, 100);
    }
};
Hooks.format_number = {
    mounted() {
        setFormat(this.el);
    },
    updated() {
        setFormat(this.el);
    }

};
Hooks.scroll_y = {
    mounted(){
        setTimeout(() => {
            var myDiv = document.getElementById('scrollableDiv');
            myDiv.scrollTo({
                'behavior': 'smooth',
                'left': 0,
                'top': document.getElementById('scrollableDiv').scrollHeight
            });               
        }, 100);
    },
    updated(){
        setTimeout(() => {            
            var myDiv = document.getElementById('scrollableDiv');
            myDiv.scrollTo({
                'behavior': 'smooth',
                'left': 0,
                'top': document.getElementById('scrollableDiv').scrollHeight
            });            
        }, 100);
    }
};
function setFormat(el){
    el.innerHTML = formatNumber(parseFloat(el.textContent).toFixed(2));
}
function formatNumber(num) {
    return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
}
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})
liveSocket.connect()

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
