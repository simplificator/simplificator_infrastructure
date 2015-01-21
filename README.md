# SimplificatorInfrastructure

This project rocks and uses MIT-LICENSE.


SimplificatorInfrastructure provides re-usable code for Rails Webapps.

## Error Pages

Shows neat error pages when exceptions are raised.
It is implemented as exception app which is a special rack app which gets called when an error occurs inside the rack middleware chain.


### Installation

```ruby
gem 'simplificator_infrastructure'
```


### Usage

In order to enable the error page handling you need to register:

```ruby
SimplificatorInfrastructure::ErrorPageHandler.register
```

It's recommended that you add this in an initializer or after_initalize block.
The error pages hide useful information for developers. Therefore you best scope it to production environment.


```ruby
if Rails.env.production?
 SimplificatorInfrastructure::ErrorPageHandler.register
end
```


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

If you want to add more translations just add the keys to your locale files.

Please make sure that I18n has

* available_locales
* default_locale

properly set.
