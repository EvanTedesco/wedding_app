var hideGuestsAndSetupEvents = function hideGuestsAndSetupEvents() {
    if ($('#rsvp-container').length > 0) {
        var numberOfGuests = $('.number-of-guests'),
            userMeal = $('.user-meal-choice'),
            accept = $('#rsvp_attending_true'),
            decline = $('#rsvp_attending_false');

        numberOfGuests.hide()
        userMeal.hide()
        accept.change(function () {
            numberOfGuests.show({
                duration: 400,
                easing: 'linear'
            }),
                userMeal.show({
                    duration: 400,
                    easing: 'linear'
                })
        });

        decline.change(function () {
            numberOfGuests.hide({
                duration: 400,
                easing: 'linear'
            }),
                userMeal.hide({
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