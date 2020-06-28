local OV = angelsmods.functions.OV
local rawmulti = angelsmods.marathon.rawmulti
local special_vanilla = clowns.special_vanilla
local ore_table = clowns.tables.ores
-- lookup table to convert ore name to trigger name
local get_trigger_name = clowns.tables.get_trigger_name
local icon_lookup_table = clowns.tables.icon_lookup_table
local tweaked_icon_lookup = clowns.tables.tweaked_icon_lookup
local CT = clowns.tables
-------------------------------------------------------------------------------
-- FUNCTION AND LOOKUP TABLES SET-UP FOR SORTING ITEMS, ICONS AND CONDITIONS --
-------------------------------------------------------------------------------
--set clownsore triggers
angelsmods.trigger.refinery_products = angelsmods.trigger.refinery_products or {} --set up if it does not already exist
angelsmods.trigger.refinery_products["Adamantite"] = true
angelsmods.trigger.refinery_products["Orichalcite"] = true
angelsmods.trigger.refinery_products["Phosphorite"] = true
angelsmods.trigger.refinery_products["Elionagate"] = true
if not special_vanilla then
  angelsmods.trigger.refinery_products["Antitate"] = true
  angelsmods.trigger.refinery_products["Pro-Galena"] = true
  angelsmods.trigger.refinery_products["Sanguinate"] = true
  angelsmods.trigger.refinery_products["Meta-Garnierite"] = true
  angelsmods.trigger.refinery_products["Nova-Leucoxene"] = true
  angelsmods.trigger.refinery_products["Plumbic"] = true
  angelsmods.trigger.refinery_products["Stannic"] = true
  angelsmods.trigger.refinery_products["Manganic"] = true
  angelsmods.trigger.refinery_products["Titanic"] = true
  angelsmods.trigger.refinery_products["Phosphic"] = true
end
--check if the ore trigger is on
local ore_exists = function(ore_name)
  if angelsmods.trigger.ores[get_trigger_name[ore_name] or ore_name] then
    return true
  end
  if angelsmods.trigger.refinery_products[ore_name] then
    return true
  end
  return false
end
--angelsmods.functions.ore_exists = ore_exists

-- function to merge tables, but not override indexes, but keep (different) contents
local merge_table_of_tables = function(recipes_table)
  local big_table = {}
  for _, recipes in pairs(recipes_table) do
    for _, recipe in pairs(recipes or {}) do
      table.insert(big_table, recipe)
    end
  end
  return big_table
end

-----------------------------------------------------------------
-- CREATE SORTING RECIPES USING THE ABOVE FUNCTIONS AND TABLES --
-----------------------------------------------------------------
local create_basic_recipe = function(refinery_product, recipe_base_name, adv)
  for i,ore in pairs(clowns.tables.ores) do
    data:extend(
    { --crushed
      {
        type = "recipe",
        name = ore.."-crushed-processing",
        localised_name = {"recipe-name.clowns-refining","Crushed",{"entity-name."..ore}},
        category = "ore-sorting",
        subgroup = "clowns-ore-sorting-t1",
        allow_decomposition = false,
        normal =
        {
          enabled = false,
          energy_required = 1,
          ingredients = {{type = "item", name = ore.."-crushed", amount = 4}},
          results = {{type = "item", name = "slag", amount = 1}}
        },
        expensive =
        {
          enabled = false,
          energy_required = 1,
          ingredients ={{type= "item", name = ore.."-crushed", amount = 6 * rawmulti}},
          results = {{type = "item", name = "slag", amount = 1}}
        },
        icons =
        {
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/sorting-icon.png"},
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/"..ore.."/crushed.png", scale = 0.5, shift = {-8, 8},}
        },
        icon_size = 32,
        order = "a["..ore.."]",
      },
      --Chunk
      {
        type = "recipe",
        name = ore.."-chunk-processing",
        localised_name = {"recipe-name.clowns-refining",{"entity-name."..ore},"Chunk"},
        category = "ore-sorting",
        subgroup = "clowns-ore-sorting-t2",
        allow_decomposition = false,
        normal =
        {
          enabled = false,
          energy_required = 1.5,
          ingredients = {{type = "item", name = ore.."-chunk", amount = 5}},
          results= {{type = "item", name = "slag", amount = 1},}
        },
        expensive =
        {
          enabled = false,
          energy_required = 1.5,
          ingredients = {{type = "item", name = ore.."-chunk", amount = 9 * rawmulti}},
          results = {{type = "item", name = "slag", amount = 1},},
        },
        icons =
        {
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/sorting-icon.png"},
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/"..ore.."/chunk.png", scale = 0.5, shift = {-8, 8},}
        },
        icon_size = 32,
        order = "a["..ore.."]",
      },
      --Crystal
      {
        type = "recipe",
        name = ore.."-crystal-processing",
        localised_name = {"recipe-name.clowns-refining",{"entity-name."..ore},"Crystal"},
        category = "ore-sorting",
        subgroup = "clowns-ore-sorting-t3",
        allow_decomposition = false,
        normal =
        {
          enabled = false,
          energy_required = 2,
          ingredients = {{type = "item", name = ore.."-crystal", amount = 8}},
          results = {{type = "item", name = "slag", amount = 1},},
        },
        expensive =
        {
          enabled = false,
          energy_required = 2,
          ingredients = {{type = "item", name = ore.."-crystal", amount = 10 * rawmulti}},
          results =
          {{type="item", name="slag", amount=1},},
        },
        icons =
        {
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/sorting-icon.png"},
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/"..ore.."/crystal.png", scale = 0.5, shift = {-8, 8},}
        },
        icon_size = 32,
        order = "a["..ore.."]",
      },
      --Pure
      {
        type = "recipe",
        name = ore.."-pure-processing",
        localised_name = {"recipe-name.clowns-refining","Purified",{"entity-name."..ore}},
        category = "ore-sorting",
        subgroup = "clowns-ore-sorting-t4",
        allow_decomposition = false,
        normal =
        {
          enabled = false,
          energy_required = 2,
          ingredients = {{type = "item", name = ore.."-pure", amount = 9}},
          results = {{type = "item", name = "angels-void", amount = 1}},
        },
        expensive =
        {
          enabled = false,
          energy_required = 2,
          ingredients = {{type = "item", name = ore.."-pure", amount = 13 * rawmulti}},
          results = {{type = "item", name = "angels-void", amount = 1}},
        },
        icons =
        {
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/sorting-icon.png"},
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/"..ore.."/pure.png", scale = 0.5, shift = {-8, 8},}
        },
        icon_size = 32,
        order = "a["..ore.."]",
      }
    }
  )
  end
end
---------------------------------------------------------------------------
     -- UPDATE SORTING RECIPES USING THE ABOVE FUNCTIONS AND TABLES --
-- This function is a direct rip (with some tweaks) from angels-refining --
---------------------------------------------------------------------------
-- function to create the (regular) sorted results for an ore, disables it if it is unused
local create_sorting_recipes = function(refinery_product, recipe_base_name, sorted_ore_results, advanced_sorting)
  local localisation_base_name = "clowns-ore%s"
  local recipes = {}
  for tier, tier_name in pairs(advanced_sorting and {"crushed", "powder", "dust", "crystal"} or {"crushed", "chunk", "crystal", "pure"}) do
    local recipe_used = false
    local recipe = {name = string.format(recipe_base_name, "-" .. tier_name .. "-processing"), results = {}}
    if angelsmods.trigger.refinery_products[refinery_product] then
      local localised_ores = {
        string.format(localisation_base_name, string.sub(recipe_base_name, -3, -3) .. "-" .. tier_name),
        string.format(localisation_base_name, "-" .. tier_name)
      }
      --log(serpent.block(sorted_ore_results))
      local used_keys={}
      for ore_name, ore_amounts in pairs(sorted_ore_results or {}) do
        local ore_amount = (ore_amounts or {})[tier]
        if ore_name == "!!" then
          if ore_amount then
            table.insert(recipe.results, {"!!"})
          end
        else
          --get trigger name
          local name = get_trigger_name[ore_name]
          if not angelsmods.trigger.ores[name or ore_name] then
            ore_amount = 0
          end
          if ore_amount and ore_amount > 0 then
            table.insert(recipe.results, {type = "item", name = ore_name, amount = ore_amount})
            local string_index = string.find(ore_name, "-ore")
            if not used_keys[name] then
              if string_index then
                table.insert(localised_ores, name or string.sub(ore_name, 1, string_index - 1))
              else
                table.insert(localised_ores, name or ore_name)
              end
              used_keys[name]=true
            end
            recipe_used = true
          end
        end
      end
      if not advanced_sorting then
        -- add localisation
        if tier_name ~= "pure" then
          table.insert(localised_ores, "slag")
        else
          localised_ores[1] = string.format(localisation_base_name, string.sub(recipe_base_name, -3, -3))
          localised_ores[2] = string.format(localisation_base_name, "")
        end
        --trim localised_ores i too long
        angelsmods.functions.add_localization(unpack(localised_ores))
      end
    else
      angelsmods.functions.OV.disable_recipe(string.format(recipe_base_name, "-" .. tier_name))
    end
    if recipe_used then
      table.insert(recipes, recipe)
    else
      angelsmods.functions.OV.disable_recipe(recipe.name)
    end
  end
  if advanced_sorting and not angelsmods.trigger.refinery_products[refinery_product] then
    angelsmods.functions.OV.disable_recipe(string.format(recipe_base_name, "sludge"))
    angelsmods.functions.OV.disable_recipe(string.format(recipe_base_name, "solution"))
    angelsmods.functions.OV.disable_recipe(string.format(recipe_base_name, "anode-sludge-filtering"))
    angelsmods.functions.OV.disable_recipe(string.format(recipe_base_name, "anode-sludge"))
  end
  return recipes
end

-- function to create the mixed sorted results for an ore, disables it if it is unused
local create_sorting_mix_recipe = function(recipe_base_name, ore_result_products, icon_names, ingredients_overrides)
  local recipes = {}
  for recipe_index, ore_result_product in pairs(ore_result_products) do
    local ore_name =
      type(ore_result_product) == "table" and (ore_result_product[1] or ore_result_product.name) or ore_result_product
    local ore_amount = type(ore_result_product) == "table" and (ore_result_product[2] or ore_result_product.amount) or 1
    local recipe = {
      name = string.format(recipe_base_name, recipe_index),
      results = {
        {"!!"},
        {
          type = type(ore_result_product) == "table" and ore_result_product.type or "item",
          name = ore_name,
          amount = ore_amount
        }
      }
    }
    if angelsmods.trigger.ores[get_trigger_name[ore_name] or ore_name] and ore_amount > 0 then
      local icon_name = (icon_names or {})[recipe_index]
      if icon_name then
        if type(icon_name) == "table" then
          recipe.icons = icon_name -- maybe improve this?
        else
          recipe.icon = string.format("__angelsrefining__/graphics/icons/%s", icon_name)
        end
      end
      local ingredients_override = (ingredients_overrides or {})[recipe_index]
      if ingredients_override then
        local ingredients_override_used = false
        local ingredients = {{"!!"}}
        for _, ingredient in pairs(ingredients_override) do
          local ingredient_name = ingredient.name or ingredient[1]
          local ingredient_amount = ingredient.amount or ingredient[2]
          if ingredient_amount > 0 then -- todo: check if ingredient exist in triggers?
            table.insert(
              ingredients,
              {type = ingredient.type or "item", name = ingredient_name, amount = ingredient_amount}
            )
            ingredients_override_used = true
          end
        end
        if ingredients_override_used then
          recipe.ingredients = ingredients
        end
      end
      table.insert(recipes, recipe)
    else
      angelsmods.functions.OV.disable_recipe(recipe.name)
    end
  end
  return recipes
end

-------------------------------------------------------------------------------
-- REGULAR SORTING ------------------------------------------------------------
-------------------------------------------------------------------------------
create_basic_recipe("Adamantite", "clowns-ore1%s")
create_basic_recipe("Orichalcite", "clowns-ore4%s")
create_basic_recipe("Phosphorite", "clowns-ore5%s")
create_basic_recipe("Elionagate", "clowns-ore7%s")
if not special_vanilla then
  create_basic_recipe("Antitate", "clowns-ore2%s")
  create_basic_recipe("Pro-Galena", "clowns-ore3%s")
  create_basic_recipe("Sanguinate", "clowns-ore6%s")
  create_basic_recipe("Meta-Garnierite", "clowns-ore8%s")
  create_basic_recipe("Nova-Leucoxene", "clowns-ore9%s")
end

OV.patch_recipes(
  merge_table_of_tables {
    create_sorting_recipes("Adamantite"     , "clowns-ore1%s", CT.adamantite),
    create_sorting_recipes("Antitate"       , "clowns-ore2%s", CT.antitate),
    create_sorting_recipes("Pro-Galena"     , "clowns-ore3%s", CT.progalena),
    create_sorting_recipes("Orichalcite"    , "clowns-ore4%s", CT.orichalcite),
    create_sorting_recipes("Phosphorite"    , "clowns-ore5%s", CT.phosphorite),
    create_sorting_recipes("Sanguinate"     , "clowns-ore6%s", CT.sanguinate),
    create_sorting_recipes("Elionagate"     , "clowns-ore7%s", CT.elionagate),
    create_sorting_recipes("Meta-Garnierite", "clowns-ore8%s", CT.metagarnierite),
    create_sorting_recipes("Nova-Leucoxene" , "clowns-ore9%s", CT.novaleucoxene),
    ore_exists("Stannic")  and create_sorting_recipes("Stannic", "clownsore11%s", CT.stannic,  true) or nil,
    ore_exists("Plumbic")  and create_sorting_recipes("Plumbic", "clownsore12%s", CT.plumbic,  true) or nil,
    ore_exists("Manganic") and create_sorting_recipes("Manganic","clownsore13%s", CT.manganic, true) or nil,
    ore_exists("Titanic")  and create_sorting_recipes("Titanic", "clownsore14%s", CT.titanic,  true) or nil,
    ore_exists("Phosphic") and create_sorting_recipes("Phosphic","clownsore15%s", CT.phosphic, true) or nil
  }
)

-------------------------------------------------------------------------------
-- MIXED SORTING --------------------------------------------------------------
-------------------------------------------------------------------------------
OV.patch_recipes(--add a sort for special vanilla items to start with??
  merge_table_of_tables {
    -- CRUSHED
    create_sorting_mix_recipe( 
      "clowns-crushed-mix%i-processing",
      {
        special_vanilla and {type = "item", name = "phosphorus-ore", amount = 4} or {type = "item", name = "iron-ore", amount = 9},
        (not special_vanilla) and {type = "item", name = "copper-ore", amount = 9},
        (not special_vanilla) and {type = "item", name = "tin-ore", amount = 9},
        (not special_vanilla) and {type = "item", name = "lead-ore", amount = 9},
        (not special_vanilla) and {type = "item", name = "manganese-ore", amount = 9},
        (not special_vanilla) and {type = "item", name = "phosphorus-ore", amount = 9},
      },
      {
        --[[1]] special_vanilla and {
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("phosphorus-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        } or {
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("iron-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[2]] {
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("copper-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[3]] {
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("tin-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[4]] {
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("lead-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[5]] {
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("manganese-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[6]] {
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("phosphorus-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
      },
      {
      --[[1]] special_vanilla and {{type = "item", name = "clowns-ore7-crushed", amount = 2},{type = "item", name = "clowns-ore5-crushed", amount = 2}} or nil,
      --[[2]] nil,
      --[[3]] nil,
      --[[4]] nil,
      --[[5]] nil,
      --[[6]] nil
      }
    ),
    -- CHUNK
    create_sorting_mix_recipe(
      "clowns-chunk-mix%i-processing",
      {
        special_vanilla and {type = "item", name = "fluorite-ore", amount = 3} or {type = "item", name = "fluorite-ore", amount = 8},
        (not special_vanilla) and {type = "item", name = "quartz", amount = 8},
        (not special_vanilla) and {type = "item", name = "nickel-ore", amount = 8},
        (not special_vanilla) and {type = "item", name = "zinc-ore", amount = 8},
        (not special_vanilla) and {type = "item", name = "bauxite-ore", amount = 8},
        (not special_vanilla) and {type = "item", name = "cobalt-ore", amount = 8},
      },
      {
        --[[1]]{ 
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("fluorite-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[2]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("silica-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[3]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("nickel-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[4]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("zinc-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[5]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("bauxite-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[6]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("cobalt-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
      },
      { 
        --[[1]] special_vanilla and {{type = "item", name = "clowns-ore1-chunk", amount = 2},{type = "item", name = "clowns-ore5-chunk", amount = 2}} or nil,
        --[[2]] nil,
        --[[3]] nil,
        --[[4]] nil,
        --[[5]] nil,
        --[[6]] nil
      }
    ),
    -- CRYSTAL
    create_sorting_mix_recipe(
      "clowns-crystal-mix%i-processing",
      {
        (not special_vanilla) and {type = "item", name = "silver-ore", amount = 7},
        (not special_vanilla) and {type = "item", name = "gold-ore", amount = 7},
        (not special_vanilla) and {type = "item", name = "rutile-ore", amount = 7},
        (not special_vanilla) and {type = "item", name = "uranium-ore", amount = 7},
        special_vanilla and {type = "item", name = "magnesium-ore", amount = 4} or {type = "item", name = "magnesium-ore", amount = 7}
      },
      {
        --[[1]]{ 
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("silver-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[2]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("gold-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[3]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("rutile-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[4]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("uranium-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[5]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("magnesium-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        }
      },
      {
        nil,
        nil,
        nil,
        nil,
        special_vanilla and {{type = "item", name = "clowns-ore4-crystal", amount = 2},{type = "item", name = "clowns-ore7-crystal", amount = 2}} or nil,
      }
    ),
    -- PURIFIED
    create_sorting_mix_recipe(
      "clowns-pure-mix%i-processing",
      {
        (not special_vanilla) and {type = "item", name = "tungsten-ore", amount = 5},
        (not special_vanilla) and {type = "item", name = "thorium-ore", amount = 5},
        (not special_vanilla) and {type = "item", name = "chrome-ore", amount = 5},
        (not special_vanilla) and {type = "item", name = "platinum-ore", amount = 5},
        special_vanilla and {type = "item", name = "osmium-ore", amount = 6} or {type = "item", name = "osmium-ore", amount = 5}
      },
      {
        --[[1]]{ 
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("tungsten-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[2]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("thorium-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[3]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("chrome-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[4]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("platinum-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        },
        --[[5]]{
          {icon = "__angelsrefining__/graphics/icons/sort-icon.png"},
          tweaked_icon_lookup("osmium-ore", 0.5, {10, 10}),
          {icon = "__Clowns-Extended-Minerals__/graphics/icons/advsorting-overlay.png"}
        }
      },
      {
        nil,
        nil,
        nil,
        nil,
        special_vanilla and {{type = "item", name = "clowns-ore1-pure", amount = 2},{type = "item", name = "clowns-resource2", amount = 2},{type = "item", name = "clowns-ore7-pure", amount = 2}} or nil,
      }
    )
  }
)