module SimplificatorInfrastructure
  module ApplicationHelper

    def referrer_or_root(request)
      referrer = request.env["HTTP_REFERER"]
      referrer.presence || '/'
    end
  end
end
