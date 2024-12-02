defmodule SlopWeb.ReportController do
  use SlopWeb, :controller

  alias Slop.Reports

  def show(conn, %{"year" => year, "month" => month}) do
    {year, _} = Integer.parse(year)
    {month, _} = Integer.parse(month)
    report = Reports.generate_monthly_report(year, month)
    render(conn, :show, report: report)
  end
end
