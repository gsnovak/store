#from wantable-2
module ApplicationHelper

  def wrapped_angular_select_month(scoped_name, input_options={}, options={}, override_name=nil)
    options[:use_month_numbers] ||= true
    wrapped_year_or_month("select_month", options, scoped_name, input_options, override_name)
  end

  def wrapped_year_or_month(tag_type, options, scoped_name, input_options, override_name=nil)
    model_name, name = split_some_scopes(scoped_name)
    date = Date.today
    options[:discard_type] = true if options[:discard_type].nil?
    html_options = { 'ng-model' => scoped_name, 'ng-init'=> "", class: "form-control", name: name, id: name }.merge(input_options)
    if tag_type == "select_month"
      select_month(date, options, html_options)
    else
      select_year(date, options, html_options)
    end
  end

  def wrapped_angular_select_year(scoped_name, input_options={}, options={}, override_name=nil)
    options[:start_year] ||= Date.today.year
    options[:end_year]   ||= (Date.today.year + 10)
    wrapped_year_or_month("select_year", options, scoped_name, input_options, override_name)
  end

  def wrapped_angular_select(scoped_name, select_options, input_options={}, override_name=nil)
    # https://github.com/angular/angular.js/issues/1019 ng-init adds ng-selected option on select input
    model_name, name = split_some_scopes(scoped_name)
    select_tag(name, options_for_select(select_options), { 'ng-model' => scoped_name, 'ng-init'=> "", class: "form-control" }.merge(input_options))
  end

  def split_some_scopes(scoped_name)
    splitted = scoped_name.split(".")
    model_name = splitted.first
    name = splitted[1..-1].join(".")
    [model_name, name]
  end

  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end
end