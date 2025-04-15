defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Live.FormComponent do
  use <%= inspect context.web_module %>, :live_component

  alias <%= inspect context.module %>

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.h3>{@title}</.h3>

      <.form
        for={@form}
        id="<%= schema.singular %>-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
<%= Mix.Tasks.Phx.Gen.Html.indent_inputs(inputs, 8) %>
        <.button type="submit" label="Save" phx-disable-with="Saving..." />
      </.form>
    </div>
    """
  end

  @impl true
  def update(%{<%= schema.singular %>: <%= schema.singular %>} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(<%= inspect context.alias %>.change_<%= schema.singular %>(<%= schema.singular %>))
     end)}
  end

  @impl true
  def handle_event("validate", %{"<%= schema.singular %>" => <%= schema.singular %>_params}, socket) do
    changeset = <%= inspect context.alias %>.change_<%= schema.singular %>(socket.assigns.<%= schema.singular %>, <%= schema.singular %>_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"<%= schema.singular %>" => <%= schema.singular %>_params}, socket) do
    save_<%= schema.singular %>(socket, socket.assigns.action, <%= schema.singular %>_params)
  end

  defp save_<%= schema.singular %>(socket, :edit, <%= schema.singular %>_params) do
    case <%= inspect context.alias %>.update_<%= schema.singular %>(socket.assigns.<%= schema.singular %>, <%= schema.singular %>_params) do
      {:ok, <%= schema.singular %>} ->
        notify_parent({:saved, <%= schema.singular %>})

        socket
        |> put_flash(:info, "<%= schema.human_singular %> updated successfully")
        |> push_navigate(to: socket.assigns.return_to)
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_<%= schema.singular %>(socket, :new, <%= schema.singular %>_params) do
    case <%= inspect context.alias %>.create_<%= schema.singular %>(<%= schema.singular %>_params) do
      {:ok, <%= schema.singular %>} ->
        notify_parent({:saved, <%= schema.singular %>})

        socket
        |> put_flash(:info, "<%= schema.human_singular %> created successfully")
        |> push_navigate(to: socket.assigns.return_to)
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
