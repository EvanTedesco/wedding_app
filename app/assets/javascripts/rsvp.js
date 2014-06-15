window.RSVPManager = {

  initialize: function () {
    if ($('#rsvp-container').length > 0) {
      var $accept = $('#rsvp_attending_true'),
      $decline = $('#rsvp_attending_false');

      $('#rsvp_number_of_guests').change( function () {
        var inputNumber = $(this).val();
        $(".guest-options").children().slice(0,inputNumber).show();
        $(".guest-options").children().slice(inputNumber).hide();

        console.log(inputNumber);
      });

      var acceptButtonWasClicked = function (event) {
        if ($(event.target).is(":checked")) {
          $('.accept-options').show({
            duration: 400,
            easing: 'linear'
          });
        }
      };

      var declineButtonWasClicked = function (event) {
        if ($(event.target).is(":checked")) {
          $('.accept-options').hide({
            duration: 400,
            easing: 'linear'
          });
        }
      };


      $accept.click(acceptButtonWasClicked);
      $decline.click(declineButtonWasClicked);
      if (!$accept.is(':checked')) {
        $('.accept-options').hide();
        $('.guest').hide();
      }
    }
  }

};

$(document).ready(RSVPManager.initialize);
$(document).on("page:load", RSVPManager.initialize);