/*!
 * LABELAUTY jQuery Plugin
 *
 * @file: jquery-labelauty.js
 * @author: Francisco Neves (@fntneves)
 * @site: www.francisconeves.com
 * @license: MIT License
 */

(function( $ ){

  $.fn.labelauty = function( options )
  {
    /*
     * Our default settings
     * Hope you don't need to change anything, with these settings
     */
    var settings = $.extend(
    {
      // Development Mode
      // This will activate console debug messages
      development: false,

      // Trigger Class
      // This class will be used to apply styles
      class: "labelauty",

      // Use text label ?
      // If false, then only an icon represents the input
      label: true,

      // Separator between labels' messages
      // If you use this separator for anything, choose a new one
      separator: "|",

      // Default Checked Message
      // This message will be visible when input is checked
      checked_label: "Checked",

      // Default UnChecked Message
      // This message will be visible when input is unchecked
      unchecked_label: "Unchecked",

      // Default Checked Icon
      // This will be the icon when input is checked
      checked_icon: "labelauty-checked-image",

      // Default UnChecked Icon
      // This will be the icon with input is unchecked
      unchecked_icon: "labelauty-unchecked-image",

      // Force random ID's
      // Replace original ID's with random ID's,
      force_random_id: false,

      // Minimum Label Width
      // This value will be used to apply a minimum width to the text labels
      minimum_width: false,

      // Padding Left Label
      // This value will be used to pad the left side of the label to allow for better placement
      padding_left: false,

      // Use the greatest width between two text labels ?
      // If this has a true value, then label width will be the greatest between labels
      same_width: true
    }, options);

    /*
     * Let's create the core function
     * It will try to cover all settings and mistakes of using
     */
    return this.each(function()
    {
      var $object = $( this );
      var use_labels = true;
      var labels;
      var labels_object;
      var input_id;

      // Test if object is a check input
      // Don't mess me up, come on
      if( $object.is( ":checkbox" ) === false && $object.is( ":radio" ) === false )
        return this;

      // Add "labelauty" class to all checkboxes
      // So you can apply some custom styles
      $object.addClass( settings.class );

      // Get the value of "data-labelauty" attribute
      // Then, we have the labels for each case (or not, as we will see)
      labels = $object.attr( "data-labelauty" );

      use_labels = settings.label;

      // It's time to check if it's going to the right way
      // Null values, more labels than expected or no labels will be handled here
      if( use_labels === true )
      {
        if( labels == null || labels.length === 0 )
        {
          // If attribute has no label and we want to use, then use the default labels
          labels_object = new Array();
          labels_object[0] = settings.unchecked_label;
          labels_object[1] = settings.checked_label;
        }
        else
        {
          // Ok, ok, it's time to split Checked and Unchecked labels
          // We split, by the "settings.separator" option
          labels_object = labels.split( settings.separator );

          // Now, let's check if exist _only_ two labels
          // If there's more than two, then we do not use labels :(
          // Else, do some additional tests
          if( labels_object.length > 2 )
          {
            use_labels = false;
            debug( settings.development, "There's more than two labels. LABELAUTY will not use labels." );
          }
          else
          {
            // If there's just one label (no split by "settings.separator"), it will be used for both cases
            // Here, we have the possibility of use the same label for both cases
            if( labels_object.length === 1 )
              debug( settings.development, "There's just one label. LABELAUTY will use this one for both cases." );
          }
        }
      }

      // Get the value of "icon-labelauty" attribute
      // Then, we have the glyphicons for each case (or not, as we will see)
      icons = $object.attr( "icon-labelauty" );

      // It's time to check if it's going the right way
      // Null values, more icons than expected or no icons will be handled here
      if( icons == null || icons.length === 0 )
      {
        // If attribute has no icon, set the icons_object to null
        // We'll set it to the default icons later
        icons_object = null;
      }
      else if( icons.toLowerCase() == 'none')
      {
        icons_object = ['none']
      }
      else
      {
        // Ok, ok, it's time to split Checked and Unchecked icons
        // We split, by the "settings.seperator" option
        icons_object = icons.split( settings.separator );

        // Now, let's check if exist _only_ two icons
        // If there's more than two, then fall back to default images
        // Using no image might make it more obvious to the developer that
        // something is wrong, but for now we'll go with this
        // Else, do some additional tests
        if( icons_object.length > 2 )
        {
          // Set the icons_object to null for now
          // It will get set to the default icons later
          icons_object = null;
          debug ( settings.development, "There's more than two icons. LABELAUTY will use the default images." );
        }
        else
        {
          // If there's just one icon (no split by "settings.separator"), it will
          // be used for both cases
          if( icons_object.length === 1 )
            debug( settings.development, "There's just one icon. LABELAUTY will use this one for both cases." );
        }
      }

      /*
       * Let's begin the beauty
       */

      // Start hiding ugly checkboxes
      // Obviously, we don't need native checkboxes :O
      $object.css({ display : "none" });

      // We don't need more data-labelauty attributes!
      // Ok, ok, it's just for beauty improvement
      $object.removeAttr( "data-labelauty" );

      // We can also get rid of the icon-labelauty attribute I guess...
      $object.removeAttr( "icon-labelauty" );

      // Now, grab checkbox ID Attribute for "label" tag use
      // If there's no ID Attribute, then generate a new one
      input_id = $object.attr( "id" );

      if( settings.force_random_id || input_id == null || input_id.trim() === "")
      {
        var input_id_number = 1 + Math.floor( Math.random() * 1024000 );
        input_id = "labelauty-" + input_id_number;

        // Is there any element with this random ID ?
        // If exists, then increment until get an unused ID
        while( $( input_id ).length !== 0 )
        {
          input_id_number++;
          input_id = "labelauty-" + input_id_number;
          debug( settings.development, "Holy crap, between 1024 thousand numbers, one raised a conflict. Trying again." );
        }

        $object.attr( "id", input_id );
      }

      // Now, add necessary tags to make this work
      // Here, we're going to test some control variables and act properly
      $object.after( create( input_id, labels_object, use_labels, icons_object ) );

      // Now, add "min-width" to label
      // Let's say the truth, a fixed width is more beautiful than a variable width
      if( settings.minimum_width !== false )
        $object.next( "label[for=" + input_id + "]" ).css({ "min-width": settings.minimum_width });

      // If necessary, add a "padding-left" to label
      if( settings.padding_left !== false )
        $object.next( "label[for=" + input_id + "]" ).css({ "padding-left": settings.padding_left });

      // Now, add "min-width" to label
      // Let's say the truth, a fixed width is more beautiful than a variable width
      if( settings.same_width != false && settings.label == true )
      {
        var label_object = $object.next( "label[for=" + input_id + "]" );
        var unchecked_width = getRealWidth(label_object.find( "span.labelauty-unchecked" ));
        var checked_width = getRealWidth(label_object.find( "span.labelauty-checked" ));

        if( unchecked_width > checked_width )
          label_object.find( "span.labelauty-checked" ).width( unchecked_width );
        else
          label_object.find( "span.labelauty-unchecked" ).width( checked_width );
      }
    });
  };

  /*
   * Tricky code to work with hidden elements, like tabs.
   * Note: This code is based on jquery.actual plugin.
   * https://github.com/dreamerslab/jquery.actual
   */
  function getRealWidth( element )
  {
    var width = 0;
    var $target = element;
    var style = 'position: absolute !important; top: -1000 !important; ';

    $target = $target.clone().attr('style', style).appendTo('body');
    width = $target.width(true);
    $target.remove();

    return width;
  }

  function debug( debug, message )
  {
    if( debug && window.console && window.console.log )
      window.console.log( "jQuery-LABELAUTY: " + message );
  };

  function create( input_id, messages_object, label, icons_object )
  {
    var block;
    var unchecked_message;
    var checked_message;
    var unchecked_icon;
    var checked_icon;

    if( messages_object == null )
      unchecked_message = checked_message = "";
    else
    {
      unchecked_message = messages_object[0];

      // If checked message is null, then put the same text of unchecked message
      if( messages_object[1] == null )
        checked_message = unchecked_message;
      else
        checked_message = messages_object[1];
    }

    if( icons_object == null )
    {
      unchecked_icon = "labelauty-unchecked-image";
      checked_icon = "labelauty-checked-image";
    }
    else if( icons_object[0] == 'none')
    {
      unchecked_icon = "";
      checked_icon = "";
    }
    else
    {
      unchecked_icon = "unchecked glyphicon glyphicon-" + icons_object[0];

      // If checked icon is null, hten put the same unchecked icon
      if( icons_object[1] == null )
        checked_icon = "checked glyphicon glyphicon-" + icons_object[0];
      else
        checked_icon = "checked glyphicon glyphicon-" + icons_object[1];
    }

    if( label == true )
    {
      block = '<label for="' + input_id + '">' +
            '<span class="' + unchecked_icon + '"></span>' +
            '<span class="labelauty-unchecked">' + unchecked_message + '</span>' +
            '<span class="' + checked_icon + '"></span>' +
            '<span class="labelauty-checked">' + checked_message + '</span>' +
          '</label>';
      // block = '<label for="' + input_id + '">' +
      //       '<span class="labelauty-unchecked-image"></span>' +
      //       '<span class="labelauty-unchecked">' + unchecked_message + '</span>' +
      //       '<span class="labelauty-checked-image"></span>' +
      //       '<span class="labelauty-checked">' + checked_message + '</span>' +
      //     '</label>';
    }
    else
    {
      block = '<label for="' + input_id + '">' +
            '<span class="' + unchecked_icon + '"></span>' +
            '<span class="' + checked_icon + '"></span>' +
          '</label>';
      // block = '<label for="' + input_id + '">' +
      //       '<span class="labelauty-unchecked-image"></span>' +
      //       '<span class="labelauty-checked-image"></span>' +
      //     '</label>';
    }

    return block;
  };

}( jQuery ));
