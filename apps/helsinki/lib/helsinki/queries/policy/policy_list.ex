
defmodule AccountingSystem.PolicyListQuery do
  @moduledoc """
  Módulo que contiene el query para obtener una lista de pólizas especificando su tipo
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    PolicySchema,
    PolicyTypeSchema,
    PrefixFormatter
  }

  def new() do
    from p in "policies",
    join: t in PolicyTypeSchema,
    prefix: "public",
    on: p.policy_type == t.id,
    select: %{
      id: p.id,
      policy_number: p.policy_number,
      policy_type: p.policy_type,
      period: p.period,
      fiscal_exercise: p.fiscal_exercise,
      policy_date: p.policy_date,
      concept: p.concept,
      has_documents: p.has_documents,
      serial: p.serial,
      type_description: t.name,
      status: p.status,
      requires_xml: false,
      pending_xml: false
    },
    order_by: [desc: p.inserted_at]
  end

  def requires_xml() do
    from p in "policies",
    join: a in "auxiliaries",
    on: p.id == a.policy_id,
    join: t in PolicyTypeSchema,
    prefix: "public",
    on: p.policy_type == t.id,
    join: ac in "accounts",
    prefix: "public",
    on: ac.id == a.id_account,
    where: ac.requires_xml,
    group_by: [p.id, p.policy_number, p.policy_type,
    p.period, p.fiscal_exercise, p.policy_date, p.concept,
    p.has_documents, p.serial, t.name, p.status, ac.requires_xml, p.inserted_at],
    select:
      p.id,
    order_by: [desc: p.inserted_at]
  end

  def pending_xml() do
    from p in "policies",
    join: a in "auxiliaries",
    on: p.id == a.policy_id,
    join: t in PolicyTypeSchema,
    prefix: "public",
    on: p.policy_type == t.id,
    join: ac in "accounts",
    prefix: "public",
    on: ac.id == a.id_account,
    where: ac.requires_xml and is_nil(a.xml_name),
    group_by: [p.id, p.policy_number, p.policy_type,
    p.period, p.fiscal_exercise, p.policy_date, p.concept,
    p.has_documents, p.serial, t.name, p.status, p.inserted_at],
    select:
      p.id,
    order_by: [desc: p.inserted_at]
  end
end
