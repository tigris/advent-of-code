SELECT org_unit_members . employee_id, org_unit_members . org_unit_id, org_unit_members . created_at, org_unit_members . deleted_at
FROM org_unit_members
INNER JOIN org_units ON ( org_units . aggregate_id = org_unit_members . org_unit_id )
WHERE ( ( org_unit_members . deleted_at IS null )
  AND ( org_unit_members . org_unit_id IN (

'e47cb497-c6cb-40e7-bc90-fa9586bb60b5',
'001dc2c2-9655-48da-bab2-5139cfbbb27e',
'7bdec048-90b5-4cdb-ac81-15841b556351',
'ddce8830-ccc0-4f8b-be91-afc0af3c7798'

)))
ORDER BY org_unit_members . employee_id, org_unit_members . org_unit_id
