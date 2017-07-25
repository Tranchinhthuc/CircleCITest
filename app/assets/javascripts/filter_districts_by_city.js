function filter_districts_by_city(city_id, district_ids) {
  var url = "/get_districts_by_city/" + city_id
  $.get(url, function(data) {
    var districts = data;

    var districts_string = "";

    for (var i = districts.length - 1; i >= 0; i--) {
      var checked = (district_ids.indexOf(districts[i].id) != -1);
      var checked_string = checked ? 'checked="checked"' : '';

      districts_string += `
          <label for="district-${districts[i].id}">${districts[i].name}
            <input type="checkbox" name="district_ids[]" id="district-${districts[i].id}" value="${districts[i].id}" class="checkbox-jquery-ui" ${checked_string}>
          </label>
        `;
    }

    $("#districts").html(districts_string);

    $( "input.checkbox-jquery-ui" ).checkboxradio({
      icon: true
    });
  });
}
