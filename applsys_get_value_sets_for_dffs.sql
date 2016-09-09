SELECT fcu.*,
  fcv.*,
  ffvs.*
FROM applsys.fnd_descr_flex_contexts fcv
JOIN applsys.fnd_application_tl A
ON fcv.application_id = A.application_id
AND A.language        = 'US'
JOIN applsys.fnd_descr_flex_column_usages fcu
ON fcv.application_id                 = fcu.application_id
AND fcv.descriptive_flexfield_name    = fcu.descriptive_flexfield_name
AND fcv.descriptive_flex_context_code = fcu.descriptive_flex_context_code
JOIN applsys.fnd_descr_flex_col_usage_tl fcut
ON fcu.application_id                 = fcut.application_id
AND fcu.descriptive_flexfield_name    = fcut.descriptive_flexfield_name
AND fcu.descriptive_flex_context_code = fcut.descriptive_flex_context_code
AND fcu.application_column_name       = fcut.application_column_name
AND fcut.language                     = 'US'
LEFT OUTER JOIN applsys.fnd_flex_value_sets ffvs
ON ffvs.flex_value_set_id = fcu.flex_value_set_id
WHERE A.application_name LIKE :application_name
  ||'%'
AND fcu.descriptive_flexfield_name LIKE '%'
  || :dff_name_eg_OE_LINE_ATTRIBUTES
  || '%'
AND fcut.form_left_prompt LIKE '%'
  || :dff_form_left_prompt
  ||'%'
ORDER BY fcut.descriptive_flexfield_name,
  fcut.application_column_name
