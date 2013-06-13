# Venn

Build venn diagrams to find matches

## Usage

````
diagram = Venn::Diagram.new

diagram.a_is ['blue', 'green']
diagram.b_is ['purple', 'blue']

diagram.a_only  # ['green']
diagram.b_only  # ['purple']
diagram.a_and_b # ['blue']
````

or

````
diagram = Venn::Diagram.new

diagram.fizz_items_are [3,  6,  9, 12, 15, 18, 21]
diagram.buzz_items_are [5, 10, 15, 20, 25, 30, 35]

diagram.fizz_items_only [3, 6, 9, 12, 18, 21]
diagram.buzz_items_only [5, 10, 20, 25, 30, 35]
diagram.fizz_items_and_buzz_items [15]
````
