defmodule ZeldacatTest do
  use ExUnit.Case

  test "something with a health component can die" do
    {:ok, entity} = Entity.init
    Entity.add_component(entity, HealthComponent, 100)
    assert 100 == HealthComponent.get_hp(entity)
    assert true == HealthComponent.alive?(entity)
    Entity.notify(entity, {:hit, 50})
    assert 50 == HealthComponent.get_hp(entity)
    Entity.notify(entity, {:heal, 25})
    assert 75 == HealthComponent.get_hp(entity)
    Entity.notify(entity, {:hit, 75})
    assert 0 == HealthComponent.get_hp(entity)
    assert false == HealthComponent.alive?(entity)
  end

  test "Something with an XYComponent can move around" do
    {:ok, entity} = Entity.init
    Entity.add_component(entity, XYComponent, {50, 50})
    Entity.notify(entity, {:move, {:y, 35}})
    assert XYComponent.get_position(entity) == {50, 35}
  end

  test "Something with a WeaponComponent can manage a list of weapons" do
    {:ok, entity} = Entity.init
    Entity.add_component(entity, WeaponComponent, [])
    Entity.notify(entity, {:add_weapon, "bat"})
    assert WeaponComponent.list_weapons(entity) == ["bat"]
    Entity.notify(entity, {:add_weapon, "gun"})
    assert WeaponComponent.list_weapons(entity) == ["bat", "gun"]
  end
end
