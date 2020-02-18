defmodule AccountingSystem.ProvidersTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.ProviderHandler

  describe "providers" do
    alias AccountingSystem.ProviderSchema

    @valid_attrs %{provider_name: "some provider_name", rfc_provider: "some rfc_provider"}
    @update_attrs %{provider_name: "some updated provider_name", rfc_provider: "some updated rfc_provider"}
    @invalid_attrs %{provider_name: nil, rfc_provider: nil}

    def provider_fixture(attrs \\ %{}) do
      {:ok, provider} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProviderHandler.create_provider()

      provider
    end

    test "list_providers/0 returns all providers" do
      provider = provider_fixture()
      assert ProviderHandler.list_providers() == [provider]
    end

    test "get_provider!/1 returns the provider with given id" do
      provider = provider_fixture()
      assert ProviderHandler.get_provider!(provider.id) == provider
    end

    test "create_provider/1 with valid data creates a provider" do
      assert {:ok, %ProviderSchema{} = provider} = ProviderHandler.create_provider(@valid_attrs)
      assert provider.provider_name == "some provider_name"
      assert provider.rfc_provider == "some rfc_provider"
    end

    test "create_provider/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProviderHandler.create_provider(@invalid_attrs)
    end

    test "update_provider/2 with valid data updates the provider" do
      provider = provider_fixture()
      assert {:ok, %ProviderSchema{} = provider} = ProviderHandler.update_provider(provider, @update_attrs)
      assert provider.provider_name == "some updated provider_name"
      assert provider.rfc_provider == "some updated rfc_provider"
    end

    test "update_provider/2 with invalid data returns error changeset" do
      provider = provider_fixture()
      assert {:error, %Ecto.Changeset{}} = ProviderHandler.update_provider(provider, @invalid_attrs)
      assert provider == ProviderHandler.get_provider!(provider.id)
    end

    test "delete_provider/1 deletes the provider" do
      provider = provider_fixture()
      assert {:ok, %ProviderSchema{}} = ProviderHandler.delete_provider(provider)
      assert_raise Ecto.NoResultsError, fn -> ProviderHandler.get_provider!(provider.id) end
    end

    test "change_provider/1 returns a provider changeset" do
      provider = provider_fixture()
      assert %Ecto.Changeset{} = ProviderHandler.change_provider(provider)
    end
  end
end
