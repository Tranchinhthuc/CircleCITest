function close_popup(id)
{
    for(var iii = 0; iii < popups.length; iii++)
    {
        if(id == popups[iii])
        {
            Array.remove(popups, iii);

            document.getElementById(id).style.display = "none";

            calculate_popups();

            return;
        }
    }
}

function load_messages(id, name){
    var url = "/chat_rooms/" + id
    $.get(url, function(data) {
      console.log(data[0]);
      // var districts = data;

      // var districts_string = "";

      // for (var i = districts.length - 1; i >= 0; i--) {
      //   var checked = (district_ids.indexOf(districts[i].id) != -1);
      //   var checked_string = checked ? 'checked="checked"' : '';

      //   districts_string += `
      //       <label for="district-${districts[i].id}">${districts[i].name}
      //         <input type="checkbox" name="district_ids[]" id="district-${districts[i].id}" value="${districts[i].id}" class="checkbox-jquery-ui" ${checked_string}>
      //       </label>
      //     `;
      // }

      // $("#districts").html(districts_string);

      // $( "input.checkbox-jquery-ui" ).checkboxradio({
      //   icon: true
      // });
        var element = `
            <div class="popup-box chat-popup" id="${id}">
                <div class="popup-head">
                    <div class="popup-head-left">
                        ${name}
                    </div>
                    <div style="clear: both">
                    </div>
                </div>
                <div class="popup-messages">
                    <ul>
                        <li>adaskldasjdk</li>
                        <li>adaskldasjdk</li>
                        <li>adaskldasjdk</li>
                        <li>adaskldasjdk</li>
                        <li>adaskldasjdk</li>
                    </ul>
                </div>
                <input type="text" name="fname" placeholder="Message here...">
            </div>
        `

        $("#messages-area").html(element);
    });
}
