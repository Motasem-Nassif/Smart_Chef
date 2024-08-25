from experta import KnowledgeEngine, Fact, Field, Rule, P, NOT
import pandas as pd
from collections.abc import Mapping
# Facts


class Recipe(Fact):
    name = Field(str)
    calories = Field(float, default=0.0)
    carbohydrates = Field(float, default=0.0)
    fat = Field(float, default=0.0)
    saturated_fat = Field(float, default=0.0)
    sodium = Field(float, default=0.0)
    fiber = Field(float, default=0.0)
    sugar = Field(float, default=0.0)

# Rule-Based System

class ObesityDietEngine(KnowledgeEngine):
    def __init__(self):
        super().__init__()
        self.result = {'Suitable for Obesity': True, 'Reasons': []}

    # calories > 2000
    @Rule(Recipe(calories=P(lambda x: x > 2000)))
    def high_calories(self):
        self.declare(Fact(suitable=False))
        self._add_reason('High in Calories')

    # carbohydrates > 30
    @Rule(Recipe(carbohydrates=P(lambda x: x > 30)))
    def high_carbs(self):
        self.declare(Fact(suitable=False))
        self._add_reason('High in Carbohydrates')

    # fat > 70
    @Rule(Recipe(fat=P(lambda x: x > 70)))
    def high_fat(self):
        self.declare(Fact(suitable=False))
        self._add_reason('High in Fat')

    # saturated_fat > 20
    @Rule(Recipe(saturated_fat=P(lambda x: x > 20)))
    def high_saturated_fat(self):
        self.declare(Fact(suitable=False))
        self._add_reason('High in Saturated Fat')

    # sodium > 2300
    @Rule(Recipe(sodium=P(lambda x: x > 2300)))
    def high_sodium(self):
        self.declare(Fact(suitable=False))
        self._add_reason('High in Sodium')

    # sugar > 50
    @Rule(Recipe(sugar=P(lambda x: x > 50)))
    def high_sugar(self):
        self.declare(Fact(suitable=False))
        self._add_reason('High in Sugar')

    @Rule(NOT(Fact(suitable=False)))
    def suitable(self):
        self.result['Suitable for Obesity'] = True

    def _add_reason(self, reason):
        if reason not in self.result['Reasons']:
            self.result['Reasons'].append(reason)

    @Rule(Fact(suitable=False))
    def unsuitable_recipe(self):
        self.result['Suitable for Obesity'] = False

def assess_recipes(filtered_df):
    results = []
    engine = ObesityDietEngine()

    for _, row in filtered_df.iterrows():
        engine.reset()
        engine.result = {'Suitable for Obesity': True,
                         'Reasons': []}
        engine.declare(Recipe(
            name=row['name'],
            calories=float(row.get('calories', 0)),
            carbohydrates=float(row.get('carbohydrates', 0)),
            fat=float(row.get('fat', 0)),
            saturated_fat=float(row.get('saturated_fat', 0)),
            sodium=float(row.get('sodium', 0)),
            fiber=float(row.get('fiber', 0)),
            sugar=float(row.get('sugar', 0))
        ))

        engine.run()
        if engine.result['Suitable for Obesity']:
            results.append({
                'name': row['name'],
                'category': row['category'],
                'cuisine': row['cuisine'],
                'servings': row['servings'],
                'meal time': row['meal time']
            })

        results_df = pd.DataFrame(results)
        return results_df.to_dict(orient='records')
