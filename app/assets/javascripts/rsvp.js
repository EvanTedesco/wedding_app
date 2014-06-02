var hideGuestsAndSetupEvents = function hideGuestsAndSetupEvents() {
    if ($('#rsvp-container').length > 0) {
        var numberOfGuests = $('.number-of-guests'),
            userMeal = $('.user-meal-choice'),
            accept = $('#rsvp_attending_true'),
            decline = $('#rsvp_attending_false');

        numberOfGuests.hide();
        userMeal.hide();

        accept.click(function () {
            if (accept.is(":checked")) {
            console.log("decline was changed");
            }
            ;
            numberOfGuests.show({
                duration: 400,
                easing: 'linear'
            }),
                userMeal.show({
                    duration: 400,
                    easing: 'linear'
                })
        });

//        if(accept.is(":checked")) {
//            showGuestOptions();
//        }

        decline.click(function () {
            if (decline.is(":checked")) {
                console.log("decline was checked");
            }
            ;
            numberOfGuests.hide({
                duration: 400,
                easing: 'linear'
            }),
                userMeal.hide({
                    duration: 400,
                    easing: 'linear'
                })
        });

        // extract showDeclineOptions, then call showDeclineOptions()

        numberOfGuests.find('input').on('keyup mouseup', function () {
            var inputNumber = $(this).val();
            console.log(inputNumber);
        })
    }

};

$(document).ready(hideGuestsAndSetupEvents);
$(document).on("page:load", hideGuestsAndSetupEvents);