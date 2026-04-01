{% macro institutions_key() %}
    {{ dbt_utils.generate_surrogate_key(['survey_year', 'institution_id']) }}
{% endmacro %}