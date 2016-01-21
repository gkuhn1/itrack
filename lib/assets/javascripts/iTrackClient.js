window.iTrackClient = {};

//
// Available configurations
window.iTrackClient.configs = {
  publisher: undefined,
  page: undefined,
  endpoint: "http://localhost:3001/tracks/",
  page_title: undefined,
  contact_form: undefined
}

//* update options with user custom options *//
window.iTrackClient.configure = function(opts) {
  window.iTrackClient.configs = $.extend({}, window.iTrackClient.configs, opts);
}

window.iTrackClient.guid = function() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
    s4() + '-' + s4() + s4() + s4();
}

window.iTrackClient.Client = function() {
  var pub = {};
  var priv = {};

  priv.visitor_uid_key = "__itrack_visitor_uid";

  priv.publ_success = function(response) {
  }

  priv.get_page = function() {
    return (window.iTrackClient.configs.page || window.location.href);
  }

  priv.get_page_title = function() {
    return (window.iTrackClient.configs.page_title || document.title);
  }

  priv.postJSON = function(url, data, callback){
    return $.ajax({url:url, data:JSON.stringify(data), type:'POST', success: callback, contentType:'application/json'});
  }

  pub.get_visitor_uid = function() {
    var uid = localStorage.getItem(priv.visitor_uid_key);
    if (uid === undefined) {
      uid = window.iTrackClient.guid();
      localStorage.setItem(priv.visitor_uid_key, uid);
    }
    return uid;
  }

  pub.init = function() {
    var data = {
      publisher: window.iTrackClient.configs.publisher,
      visitor_uid: pub.get_visitor_uid(),
      page: priv.get_page(),
      page_title: priv.get_page_title()
    }
    priv.postJSON(window.iTrackClient.configs.endpoint, {track: data}, priv.publ_success);
  }

  return pub;
}()

$(document).ready(function(){
  window.iTrackClient.Client.init();

  if (window.iTrackClient.configs.contact_form !== undefined) {
    $("input[name='message[visitor_uid]']", "#"+window.iTrackClient.configs.contact_form).val(window.iTrackClient.Client.get_visitor_uid())
  }
})