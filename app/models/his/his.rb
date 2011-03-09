module His
end

# Search here
lib = File.expand_path(File.dirname(__FILE__))
$:.unshift lib unless $:.include?(lib)

# Main table of values
require 'data_value'

# Meta-data
require 'category'
require 'derived_from'
require 'group_descriptions'
require 'groups'
require 'iso_metadata'
require 'lab_methods'
require 'field_methods'
require 'offset_types'
require 'qualifiers'
require 'quality_control_levels'
require 'samples'
require 'series_catalog'
require 'site'
require 'sources'
require 'spatial_reference'
require 'unit'
require 'variable'

# System information
require 'odm_version'
require 'sys_diagram'

# Controlled Vocabulary
require 'censor_code_cv'
require 'data_type_cv'
require 'general_category_cv'
require 'sample_medium_cv'
require 'sample_type_cv'
require 'speciation_cv'
require 'topic_category_cv'
require 'value_type_cv'
require 'variable_name_cv'
require 'vertical_datum_cv'
