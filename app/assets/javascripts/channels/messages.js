App.messages = App.cable.subscriptions.create('MessagesChannel', {

  received: function(data) {

    // $(`#messages-${data.chat_room_id}`).removeClass('hidden');
    $(`#messages-${data.chat_room_id}`).append(this.renderMessage(data));
    return $('.messages-box').scrollTop($('.messages-box')[0].scrollHeight);
  },

  renderMessage: function(data) {
    $("#message-input").val("");

    console.log($.cookie("current_user") == data.user.id );

    var base_type_message = ($.cookie("current_user") == data.user.id) ? "base_sent" : "base_receive"
    var type_message = ($.cookie("current_user") == data.user.id) ? "msg_receive" : "msg_sent"
    var alignClass = (type_message == 'msg_receive') ? 'pull-right' : ''
    var avatar = '';

    if(type_message == "msg_sent"){
      avatar = `<img src="${data.avatar}" alt="Comment avatar default avatar" class="circle-img">`
    }

    var messageBox = `
        <div class="row msg_container ${base_type_message}">
            <div class="col-md-10 col-xs-10">
                <div class="messages ${type_message}">
                    <p class="paragraph-${type_message} ${alignClass}">
                      ${avatar}
                      <span>${data.message}</span>
                    </p>
                </div>
            </div>
        </div>
      `
    return messageBox
  }
});
// return `<p><img src="${data.avatar}" alt="Comment avatar default avatar"> <b> ${data.user.name}: </b> ${data.message}</p>`;
