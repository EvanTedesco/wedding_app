var hideGuestsAndSetupEvents = function hideGuestsAndSetupEvents() {
    if ($('#rsvp-container').length > 0) {
        var numberOfGuests = $('.number-of-guests'),
            accept = $('#rsvp_attending_true'),
            decline = $('#rsvp_attending_false');

        numberOfGuests.hide()
        accept.change(function () {
            numberOfGuests.show({
                duration: 400,
                easing: 'linear'
            })
        });

        decline.change(function () {
            numberOfGuests.hide({
                duration: 400,
                easing: 'linear'
            })
        });


        numberOfGuests.find('input').on('keyup mouseup', function () {
            var inputNumber = $(this).val();
            console.log(inputNumber);
        })
    }

};

$(document).ready(hideGuestsAndSetupEvents);
$(document).on("page:load", hideGuestsAndSetupEvents);