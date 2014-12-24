// StoreFront customizations

$(document).ready(function() {

    $.ajax({
        url: 'contrib/GetServerData.aspx?serverData=clientIPandServerName',
        success: function(data) {
            var $markup = $('<div id="server-info">' + data + '</div>');
            $markup.insertBefore('#header-userinfo');
        }
    });

});
