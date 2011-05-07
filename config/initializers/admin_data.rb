AdminData::Config.set = {
  :ignore_column_limit => true
}

AdminData::Config.set = {
 :find_conditions =>  {'Station' => lambda {|params| {:conditions =>   ["permalink = ?", params[:id] ] } },
                       'City' => lambda {|params| {:conditions =>   ["permalink = ?", params[:id] ] } }
                      }  
}
