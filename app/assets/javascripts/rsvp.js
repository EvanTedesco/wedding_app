window.RSVPManager = {

  initialize: function () {
    if ($('#rsvp-container').length > 0) {
      $("input[id='rsvp_attending_false']").prop('checked', false);
      var $accept = $('#rsvp_attending_true'),
        $decline = $('#rsvp_attending_false'),
        guestNumberInput = $('#rsvp_number_of_guests'),
        guestTransition = {
          duration: 400,
          easing: 'linear'
        };


      $('#new_rsvp').submit(function(){
        $('input:hidden').val('');
      });

      guestNumberInput.change(function () {
        var inputNumber = $(this).val();
        $(".guest-options").children().slice(0, inputNumber).show(guestTransition);
        $(".guest-options").children().slice(inputNumber).hide(guestTransition);
      });

      var acceptButtonWasClicked = function (event) {
        if ($(event.target).is(":checked")) {
          $('.accept-options').show(guestTransition);
        }
      };

      var declineButtonWasClicked = function (event) {
        if ($(event.target).is(":checked")) {
          $('.accept-options').hide(guestTransition);
          $('.guest').hide(guestTransition);
          $(guestNumberInput).val(0);

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