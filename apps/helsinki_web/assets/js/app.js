// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
let Hooks = {};
Hooks.hidden_account = {
    mounted() {
        this.el.addEventListener("blur", e => {
            setTimeout(() => {
                if(document.getElementById("account_list") != null)
                    document.getElementById("account_list").style.display = "none";
            }, 100);
        })
        this.el.addEventListener("focus", e => {
            setTimeout(() => {
                document.getElementById("account_list").style.display = "inline";
            }, 200)
        })
    }
};
Hooks.return_to_account = {
    mounted() {
        this.el.addEventListener("click", e => {
            setTimeout(() => {
                document.getElementById("account_input").select();
                document.getElementById("account_input").focus();
            }, 100);
        })
    }
};

Hooks.go_to_concept = {
    mounted() {
        this.el.addEventListener("blur", e => {
            setTimeout(() => {
                document.getElementById("concept_input").select();
                document.getElementById("concept_input").focus();
            }, 300);
        })
    }
};

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
