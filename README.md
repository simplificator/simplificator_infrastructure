# SimplificatorInfrastructure

This project rocks and uses MIT-LICENSE.


SimplificatorInfrastructure provides re-usable code for Rails Webapps.


## Installation

```ruby
gem 'simplificator_infrastructure'
```

## Locale Detection

In your ApplicationController (or something that responds to _request_ and _params_) add

```ruby
include SimplificatorInfrastructure::LocaleDetection
```

You can then use the various methods provided by this module:

* detect_locale (tries to find the locale from params, then header then default)
* locale_from_params
* locale_from_header
* locale_default

Extraction is DOS safe in that it only creates symbols for known locales (for pre 2.2 Rubies).

Note:
Make sure I18n.available_locales and I18n.default_locale are properly set.



## Error Pages

Shows neat error pages when exceptions are raised.
It is implemented as exception app which is a special rack app which gets called when an error occurs inside the rack middleware chain.

You can see a demo if you start the rails server for the included dummy app:

```
cd test/dummy
rails server
```

and then navigate to http://localhost:3000

### Usage
In order to activate the error pages you need to register your application.
It's recommended that you add this in an initializer or after_initalize block.
The error pages hide useful information for developers. Therefore you best scope it to production environment.

```ruby
if Rails.env.production?
 SimplificatorInfrastructure::ErrorPageHandler.register
end
```

### Caveats

If you have better_errors (or something else that hooks into error handling) configured then error pages might not work as expected.

### Customize

#### Logo

You can provide a customer logo. If none is provided the default one (Simplificator) will be used.
Save the logo as __app/assets/images/simplificator_infrastructure/errors/logo.png__ and it will be used instead of the default.

#### Pages

You can add an error page per HTTP status code. I.e. a custom 500, 404, ... error page. The gem comes with

* 404 (is shown when a routing error occurs)
* generic (is shown in all other cases)

If a specific page is present then it is rendered, else the generic one is shown.

To add or customize an error page you can add a view at

__app/views/errors/xxx.html.something__

where XXX is the status code

Or add

__app/views/errors/generic_error.html.something__ to replace the generic error view.

### Translations

Translations are provided for

* de
* en
* fr

If you want to add more translations just add the keys to your locale files.

Please make sure that I18n has

* available_locales
* default_locale

properly set.
