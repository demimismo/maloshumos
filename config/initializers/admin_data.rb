AdminData::Config.set = {
}

AdminData::Config.set = {
    :ignore_column_limit => true,
    :find_conditions =>  {'Station' => lambda {|params| {:conditions =>   ["permalink = ?", params[:id] ] } },
                          'City' => lambda {|params| {:conditions =>   ["permalink = ?", params[:id] ] } }
                         },
    :is_allowed_to_view => lambda {|controller| return true if Rails.env.production? },
    :is_allowed_to_update => lambda {|controller| return true if Rails.env.production? },
}
