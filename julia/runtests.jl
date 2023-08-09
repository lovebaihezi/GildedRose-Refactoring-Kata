using Test

# To run the tests, include this file into your REPL
# julia> include("runtests.jl")

include("gilded_rose.jl")

@testset "gilded_rose.jl" begin

    # Test foo
    items = [
        Item("foo", 0, 0),
        Item("Backstage passes to a TAFKAL80ETC concert", 15, 20),
        Item("Sulfuras, Hand of Ragnaros", 0, 80),
        Item("Aged Brie", 2, 0),
        Item("Elixir of the Mongoose", 5, 7),
        Item("+5 Dexterity Vest", 10, 20),
        Item("Sulfuras, Hand of Ragnaros", -1, 80),
        Item("Backstage passes to a TAFKAL80ETC concert", 10, 49),
        Item("Sulfuras, Hand of Ragnaros", 0, 60),
    ]
    gildedrose = GildedRose(items)
    update_quality!(gildedrose)
    @test items[1].name == "foo"
    @test items[1].sellin == 0
    @test items[1].quality == 0
    @test items[2].name == "Backstage passes to a TAFKAL80ETC concert"
    @test items[2].sellin == 13
    @test items[2].quality == 21
    @test items[3].name == "Sulfuras, Hand of Ragnaros"
    @test items[3].sellin == 0
    @test items[3].quality == 80
    @test items[4].name == "Aged Brie"
    @test items[4].sellin == 0
    @test items[4].quality == 1
    @test items[5].name == "Elixir of the Mongoose"
    @test items[5].sellin == 3
    @test items[5].quality == 6
    @test items[6].name == "+5 Dexterity Vest"
    @test items[6].sellin == 8
    @test items[6].quality == 19
    @test items[7].name == "Sulfuras, Hand of Ragnaros"
    @test items[7].sellin == 0
    @test items[7].quality == 80
    @test items[8].name == "Backstage passes to a TAFKAL80ETC concert"
    @test items[8].sellin == 8
    @test items[8].quality == 50
    @test items[9].name == "Sulfuras, Hand of Ragnaros"
    @test items[9].sellin == 0
    @test items[9].quality == 80

end
