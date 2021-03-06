// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
var fileData;
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

Hooks.download_template = {
    mounted() {
        this.el.addEventListener("click", e => {
            setTimeout(() => {
                console.log(window.location.pathname)
                var iframe = document.getElementById('invisible');
                iframe.src = "download_template";
            }, 500);
        })
    }
};

Hooks.get_path = {
    mounted() {
        var aux = this;
        this.el.addEventListener("change", evt => {  
            var files = evt.target.files[0];
            fileData = new Blob([files]);
            console.log("Filedata: ", files)
            var promise = new Promise(getBuffer);
            promise.then(function(data) {
                aux.pushEventTo("#list_comp", "load_aux", {"value": data, "name": files.name})
            }).catch(function(err) {
                console.log('Error: ',err);
            });
        })
    }
}

function getBuffer(resolve) {
    var reader = new FileReader();
    reader.readAsArrayBuffer(fileData);
    reader.onload = function() {
      var arrayBuffer = reader.result
      var bytes = new Uint8Array(arrayBuffer);
      var array = Array.from(bytes)
      resolve(array);
    }
  }

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
Hooks.evidence_upload = {
    mounted() {
        this.el.addEventListener("change", e => {
            
            toBase64(this.el.files[0]).then(base64 => {
                var hidden = document.getElementById("evidence_upload_base64") // change this to the ID of your hidden input
                hidden.value = base64;
                console.log(base64);
                hidden.focus() // this is needed to register the new value with live view
                console.log(this.el.files[0].name)
                var nombre = document.getElementById("nombre_archivo")
                nombre.value =  this.el.files[0].name
            });        
        })
    }
};

Hooks.alexandria_upload = {
    mounted(){
        this.el.addEventListener("input", e =>{
            var reader = new FileReader();
            reader.onload = function() {
                var arrayBuffer = this.result,
                array = new Uint8Array(arrayBuffer),
                binaryString = String.fromCharCode.apply(null, array);
                var hidden = document.getElementById("file_upload_content")
                hidden.value = binaryString;
                console.log(array);
                console.log(binaryString);                
            }            
            reader.readAsArrayBuffer(e.srcElement.files[0]);
        })
    }
};

Hooks.load_file_xml_js = {
    mounted() {
        var toEvent = this
        this.el.addEventListener("input", e => {
            get_xml_data(toEvent, e);
        })       
    }
};

// let liveSocket = new LiveSocket("/live", Socket, { hooks: hooks })
let liveSocket = new LiveSocket("/live", Socket, 
{params: {_csrf_token: csrfToken}, 
hooks: Hooks, 
metadata: {
    click: (e, el) => {
      return {
        altKey: e.altKey,
        shiftKey: e.shiftKey,
        ctrlKey: e.ctrlKey,
        metaKey: e.metaKey,
        x: e.x || e.clientX,
        y: e.y || e.clientY,
        pageX: e.pageX,
        pageY: e.pageY,
        screenX: e.screenX,
        screenY: e.screenY,
        offsetX: e.offsetX,
        offsetY: e.offsetY,
        detail: e.detail || 1,
      }
    },
    keydown: (e, el) => {
        return {
          altGraphKey: e.altGraphKey,
          altKey: e.altKey,
          code: e.code,
          ctrlKey: e.ctrlKey,
          key: e.key,
          keyIdentifier: e.keyIdentifier,
          keyLocation: e.keyLocation,
          location: e.location,
          metaKey: e.metaKey,
          repeat: e.repeat,
          shiftKey: e.shiftKey
        }
      }
  }
})
liveSocket.connect()

const toBase64 = file => new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = error => reject(error);
});

function get_xml_data(toEvent, e) {
    var element_file = e.srcElement.files[0]
    setTimeout(function() {
        var reader = new FileReader();
        reader.onload = function () {
            var arrayBuffer = this.result, array = new Uint8Array(arrayBuffer), binaryString = String.fromCharCode.apply(null, array);
            toEvent.pushEvent("send_to_view", { name: element_file.name, xml_b64: binaryString });
        };
        reader.readAsArrayBuffer(element_file);
    }, 100)
}

function setFormat(el){
    el.innerHTML = formatNumber(parseFloat(el.textContent).toFixed(2));
}
function formatNumber(num) {
    console.info(num)
    if (num != "NaN"){
        return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
    }
    return "-"
}
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

// let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})
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
