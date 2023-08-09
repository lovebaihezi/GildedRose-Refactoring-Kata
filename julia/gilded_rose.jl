import Base

mutable struct Item{T<:Integer}
    name::String
    sellin::T
    quality::T
end

Base.show(io::IO, x::Item) = print(io, "$(x.name), $(x.sellin), $(x.quality)")

struct GildedRose
    items
end

function handle_sulfuras!(item::Item)
    @assert item.name == "Sulfuras, Hand of Ragnaros"
    item.sellin = 0
    item.quality = 80
    return nothing
end

function handle_aged_brie!(item::Item)
    @assert item.name == "Aged Brie"
    item.sellin -= 1
    item.quality += 1
    if item.sellin < 0
        item.quality += 1
    end
    return nothing
end

function handle_backstage_passes!(item::Item)
    @assert item.name == "Backstage passes to a TAFKAL80ETC concert"
     item.sellin -= 1
     if item.sellin < 0
         item.quality = 0
     elseif item.sellin < 5
         item.quality += 3
     elseif item.sellin < 10
         item.quality += 2
     else
         item.quality += 1
     end
    return nothing
end

function handle_conjured!(item::Item)
    @assert item.name == "Conjured Mana Cake"
    item.sellin -= 1
    item.quality -= 2
    if item.sellin < 0
        item.quality -= 2
    end
    return nothing
end

function handle_others!(item::Item)
    @assert item.name != "Sulfuras, Hand of Ragnaros" && item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" && item.name != "Conjured Mana Cake"
    item.sellin -= 1
    item.quality -= 1
    if item.sellin < 0
        item.quality -= 1
    end
    return nothing
end

function update_item!(item::Item)
    if item.name == "Sulfuras, Hand of Ragnaros"
        return handle_sulfuras!(item)
    end
    item.sellin -= 1
    if item.name == "Aged Brie"
        handle_aged_brie!(item)
    elseif item.name == "Backstage passes to a TAFKAL80ETC concert"
        handle_backstage_passes!(item)
    elseif item.name == "Conjured Mana Cake"
        handle_conjured!(item)
    else
        handle_others!(item)
    end
    item.quality = min(item.quality, 50)
    item.quality = max(item.quality, 0)
    item.sellin = max(item.sellin, 0)
    return nothing
end

function update_quality!(gr::GildedRose)
    for item in gr.items
        update_item!(item)
    end
    return nothing
end

# Technically, julia espouses a REPL-driven workflow, so the preferred way to run this
# would be from the REPL. However, if you'd like to run this function from the
# commandline, run `$ julia -e 'include("gilded_rose.jl"); main(;days=3)'` or whatever
# number you want for `days`.
function main(; days::Int64=2)
    println("OMGHAI!")
    items = [
        Item("+5 Dexterity Vest", 10, 20),
        Item("Aged Brie", 2, 0),
        Item("Elixir of the Mongoose", 5, 7),
        Item("Sulfuras, Hand of Ragnaros", 0, 80),
        Item("Sulfuras, Hand of Ragnaros", -1, 80),
        Item("Backstage passes to a TAFKAL80ETC concert", 15, 20),
        Item("Backstage passes to a TAFKAL80ETC concert", 10, 49),
        Item("Backstage passes to a TAFKAL80ETC concert", 5, 49),
        Item("Conjured Mana Cake", 3, 6),
    ]
    for day in 0:days
        println("-------- day $day --------")
        println("name, sellIn, quality")
        for item in items
            println(item)
        end
        println()
        update_quality!(GildedRose(items))
    end
end
