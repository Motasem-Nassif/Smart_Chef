import random
from functools import partial
from deap import base, creator, tools, algorithms

recipes = [
    ("Hummus", {"Chickpeas": 3, "Tahini": 1, "Olive Oil": 1, "Garlic": 1, "Lemon": 1},
     (30, 10, 20, 30), ["Chickpeas", "Tahini", "Olive Oil"],
     "1. Blend chickpeas with tahini, olive oil, garlic, and lemon.\n2. Serve with a drizzle of olive oil on top.",
     "Appetizer", 15, "Lebanese"),

    ("Tabbouleh", {"Parsley": 3, "Tomato": 2, "Cucumber": 1, "Mint": 1, "Lemon": 1, "Olive Oil": 1, "Bulgur": 2},
     (40, 8, 15, 45), ["Parsley", "Tomato", "Bulgur"],
     "1. Soak the bulgur in water until soft.\n2. Finely chop the parsley, tomatoes, cucumber, and mint.\n3. Mix all ingredients with lemon juice and olive oil.",
     "Appetizer", 20, "Lebanese"),

    ("Baba Ghanoush", {"Eggplant": 2, "Tahini": 1, "Olive Oil": 1, "Garlic": 1, "Lemon": 1},
     (15, 5, 18, 20), ["Eggplant", "Tahini", "Olive Oil"],
     "1. Roast the eggplant until the skin is charred and the flesh is soft.\n2. Peel the eggplant and blend it with tahini, olive oil, garlic, and lemon juice.\n3. Serve with a drizzle of olive oil and garnished with parsley.",
     "Appetizer", 30, "Syrian"),

    ("Kibbeh", {"Lamb": 2, "Bulgur": 2, "Onion": 1, "Cinnamon": 1},
     (25, 20, 15, 60), ["Lamb", "Bulgur", "Onion"],
     "1. Soak the bulgur in water until soft.\n2. Mix the lamb, bulgur, finely chopped onion, and cinnamon into a dough-like consistency.\n3. Form into balls and fill with minced lamb and onion mixture.\n4. Fry or bake until golden brown.",
     "Dinner", 90, "Lebanese"),

    ("Shish Tawook", {"Chicken": 2, "Yogurt": 1, "Garlic": 1, "Lemon": 1, "Olive Oil": 1},
     (5, 30, 10, 15), ["Chicken", "Yogurt", "Garlic"],
     "1. Marinate the chicken pieces in a mixture of yogurt, garlic, lemon juice, and olive oil for a few hours.\n2. Skewer the chicken and grill until cooked through.",
     "Dinner", 45, "Lebanese"),

    ("Falafel", {"Chickpeas": 3, "Garlic": 1, "Parsley": 1, "Cumin": 1, "Onion": 1},
     (35, 10, 15, 50), ["Chickpeas", "Parsley", "Cumin"],
     "1. Soak the chickpeas overnight, then drain.\n2. Blend chickpeas with garlic, parsley, onion, and spices until smooth.\n3. Shape into balls and fry until golden brown.",
     "Lunch", 45, "Egyptian"),

    ("Fatayer", {"Spinach": 3, "Onion": 1, "Flour": 2, "Olive Oil": 1},
     (40, 8, 12, 60), ["Spinach", "Flour", "Olive Oil"],
     "1. Prepare the dough by mixing flour, water, and yeast.\n2. Sauté spinach and onions with olive oil until softened.\n3. Roll out the dough, fill with the spinach mixture, and shape into triangles.\n4. Bake in the oven until golden brown.",
     "Lunch", 60, "Lebanese"),

    ("Manakish Zaatar", {"Flour": 3, "Olive Oil": 1, "Zaatar": 1},
     (45, 8, 20, 65), ["Flour", "Zaatar", "Olive Oil"],
     "1. Prepare the dough by mixing flour, water, and yeast.\n2. Spread the dough with a mixture of zaatar and olive oil.\n3. Bake in the oven until the dough is cooked and the zaatar is fragrant.",
     "Breakfast", 30, "Lebanese"),

    ("Fattoush", {"Tomato": 2, "Cucumber": 1, "Onion": 1, "Pita Bread": 1, "Sumac": 1, "Olive Oil": 1},
     (30, 6, 18, 55), ["Tomato", "Cucumber", "Pita Bread"],
     "1. Toast the pita bread until crispy and break it into pieces.\n2. Chop the tomatoes, cucumber, and onion.\n3. Toss the vegetables with sumac, olive oil, and the toasted pita bread.",
     "Lunch", 20, "Lebanese"),

    ("Mujadara", {"Lentils": 3, "Rice": 2, "Onion": 1, "Olive Oil": 1},
     (50, 12, 15, 75), ["Lentils", "Rice", "Onion"],
     "1. Cook the lentils until tender.\n2. Cook the rice separately.\n3. Fry the onions in olive oil until crispy.\n4. Mix the lentils, rice, and onions together and serve.",
     "Dinner", 45, "Lebanese"),

    ("Labneh", {"Yogurt": 2, "Olive Oil": 1, "Garlic": 1, "Mint": 1},
     (5, 8, 12, 10), ["Yogurt", "Olive Oil", "Garlic"],
     "1. Strain the yogurt overnight to make labneh.\n2. Mix the labneh with garlic and mint.\n3. Serve with a drizzle of olive oil.",
     "Breakfast", 10, "Lebanese"),

    ("Stuffed Grape Leaves", {"Grape Leaves": 20, "Rice": 2, "Onion": 1, "Pine Nuts": 1, "Olive Oil": 1},
     (55, 8, 15, 70), ["Grape Leaves", "Rice", "Pine Nuts"],
     "1. Blanch the grape leaves in boiling water.\n2. Mix the rice, onion, pine nuts, and spices.\n3. Stuff the grape leaves with the rice mixture and roll them tightly.\n4. Cook the stuffed grape leaves in a pot with olive oil and lemon juice.",
     "Dinner", 120, "Greek"),

    ("Shakshuka", {"Eggs": 3, "Tomato": 2, "Onion": 1, "Bell Pepper": 1, "Olive Oil": 1},
     (20, 20, 18, 45), ["Eggs", "Tomato", "Bell Pepper"],
     "1. Sauté the onions and bell peppers in olive oil until soft.\n2. Add the tomatoes and cook until the sauce thickens.\n3. Make small wells in the sauce and crack the eggs into them.\n4. Cover the pan and cook until the eggs are set.",
     "Breakfast", 30, "Israeli"),

    ("Lamb Kofta", {"Lamb": 2, "Onion": 1, "Garlic": 1, "Cumin": 1, "Cinnamon": 1},
     (10, 25, 20, 50), ["Lamb", "Onion", "Cumin"],
     "1. Mix the ground lamb with finely chopped onion, garlic, cumin, cinnamon, and other spices.\n2. Shape the mixture into small patties or onto skewers.\n3. Grill or fry until cooked through.",
     "Dinner", 60, "Turkish"),

    ("Baklava", {"Almonds": 2, "Walnuts": 2, "Sugar": 3, "Butter": 2, "Flour": 2, "Rose Water": 1, "Honey": 1},
     (70, 10, 25, 85), ["Almonds", "Walnuts", "Sugar"],
     "1. Layer phyllo dough in a baking dish, brushing each layer with butter.\n2. Mix the chopped almonds and walnuts with sugar and rose water.\n3. Spread the nut mixture over the dough layers and cover with more layers of phyllo dough.\n4. Bake until golden and crispy, then drizzle with honey.",
     "Dessert", 120, "Turkish"),

    ("Kibbeh Nayeh", {"Lamb": 3, "Bulgur": 2, "Onion": 1, "Olive Oil": 1},
     (35, 25, 20, 65), ["Lamb", "Bulgur", "Onion"],
     "1. Soak the bulgur in water until soft.\n2. Mix the raw ground lamb with bulgur, finely chopped onion, and spices.\n3. Serve raw with a drizzle of olive oil.",
     "Lunch", 20, "Lebanese"),

    ("Warak Enab", {"Grape Leaves": 20, "Rice": 2, "Lamb": 2, "Olive Oil": 1},
     (50, 15, 20, 75), ["Grape Leaves", "Rice", "Lamb"],
     "1. Blanch the grape leaves in boiling water.\n2. Mix the rice, minced lamb, and spices.\n3. Stuff the grape leaves with the rice and lamb mixture, then roll tightly.\n4. Cook the stuffed grape leaves in a pot with olive oil and lemon juice.",
     "Dinner", 150, "Lebanese"),

    ("Moussaka", {"Eggplant": 2, "Tomato": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (30, 6, 15, 45), ["Eggplant", "Tomato", "Onion"],
     "1. Slice and fry the eggplant until golden.\n2. Sauté the onions and garlic in olive oil.\n3. Layer the fried eggplant with the sautéed onions, garlic, and tomatoes in a baking dish.\n4. Bake until the sauce is thickened and the top is golden.",
     "Dinner", 90, "Greek"),

    ("Kousa Mahshi", {"Zucchini": 3, "Rice": 2, "Lamb": 2, "Tomato": 2, "Garlic": 1, "Olive Oil": 1},
     (50, 15, 18, 65), ["Zucchini", "Rice", "Lamb"],
     "1. Hollow out the zucchinis and set aside.\n2. Mix the rice, minced lamb, tomatoes, and garlic.\n3. Stuff the zucchinis with the rice mixture.\n4. Cook the stuffed zucchinis in a pot with tomato sauce until tender.",
     "Dinner", 120, "Lebanese"),

    ("Muhammara", {"Bell Pepper": 3, "Walnuts": 2, "Olive Oil": 1, "Garlic": 1},
     (25, 8, 20, 30), ["Bell Pepper", "Walnuts", "Olive Oil"],
     "1. Roast the bell peppers until charred, then peel and deseed.\n2. Blend the roasted peppers with walnuts, garlic, olive oil, and spices.\n3. Serve as a dip with bread.",
     "Appetizer", 30, "Syrian"),

    ("Kaak", {"Flour": 3, "Sugar": 2, "Yeast": 1, "Olive Oil": 1, "Sesame Seeds": 1},
     (60, 8, 15, 75), ["Flour", "Sugar", "Sesame Seeds"],
     "1. Mix the flour, sugar, yeast, and olive oil to form a dough.\n2. Shape the dough into rings and coat with sesame seeds.\n3. Bake until golden brown.",
     "Snack", 60, "Lebanese"),

    ("Kanafeh", {"Semolina": 2, "Sugar": 3, "Butter": 2, "Rose Water": 1, "Cheese": 2},
     (70, 10, 25, 80), ["Semolina", "Sugar", "Cheese"],
     "1. Mix the semolina with melted butter and spread it in a baking dish.\n2. Layer with cheese and cover with more semolina mixture.\n3. Bake until golden, then drizzle with rose water syrup.",
     "Dessert", 90, "Lebanese"),
    ("Laban Emmo", {"Yogurt": 3, "Lamb": 2, "Rice": 2, "Garlic": 1},
     (40, 18, 15, 65), ["Yogurt", "Lamb", "Rice"],
        "1. Cook the lamb in water until tender.\n2. Mix the yogurt with garlic and heat gently.\n3. Add the lamb and cook for a few more minutes.\n4. Serve over cooked rice.",
     "Dinner", 120, "Syrian"),

    ("Kibbeh Bil Sanieh", {"Lamb": 2, "Bulgur": 2, "Onion": 1, "Olive Oil": 1, "Pine Nuts": 1},
     (40, 20, 18, 60), ["Lamb", "Bulgur", "Onion"],
     "1. Mix the ground lamb with soaked bulgur, finely chopped onion, and spices.\n2. Spread half the mixture in a baking dish, top with pine nuts, and cover with the remaining lamb mixture.\n3. Bake until golden brown.",
     "Dinner", 90, "Lebanese"),

    ("Batata Harra", {"Potato": 3, "Garlic": 1, "Coriander": 1, "Olive Oil": 1, "Chili": 1},
     (40, 5, 20, 65), ["Potato", "Garlic", "Coriander"],
     "1. Dice the potatoes and fry until golden.\n2. Sauté garlic, coriander, and chili in olive oil.\n3. Toss the fried potatoes in the garlic mixture.",
     "Side Dish", 30, "Lebanese"),

    ("Arayes", {"Pita Bread": 2, "Lamb": 2, "Tomato": 1, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (50, 15, 20, 70), ["Pita Bread", "Lamb", "Tomato"],
     "1. Mix the ground lamb with finely chopped tomato, onion, and garlic.\n2. Stuff the pita bread with the lamb mixture and brush with olive oil.\n3. Grill until the bread is crispy and the filling is cooked.",
     "Lunch", 20, "Lebanese"),

    ("Sfouf", {"Semolina": 3, "Sugar": 3, "Turmeric": 1, "Olive Oil": 1, "Almonds": 1},
     (65, 8, 15, 75), ["Semolina", "Sugar", "Turmeric"],
     "1. Mix the semolina with sugar, turmeric, and olive oil to form a batter.\n2. Pour the batter into a baking dish and top with almonds.\n3. Bake until golden brown.",
     "Dessert", 60, "Lebanese"),

    ("Riz Bi Halib", {"Rice": 2, "Milk": 2, "Sugar": 3, "Rose Water": 1},
     (70, 8, 12, 75), ["Rice", "Milk", "Sugar"],
     "1. Cook the rice in milk with sugar until thickened.\n2. Add rose water and continue to cook until the mixture is creamy.\n3. Serve chilled, garnished with nuts if desired.",
     "Dessert", 60, "Lebanese"),

    ("Zaatar Salad", {"Zaatar": 1, "Tomato": 2, "Cucumber": 1, "Olive Oil": 1, "Lemon": 1},
     (25, 5, 15, 30), ["Zaatar", "Tomato", "Cucumber"],
     "1. Chop the tomatoes and cucumber.\n2. Toss with zaatar, lemon juice, and olive oil.\n3. Serve immediately.",
     "Appetizer", 15, "Lebanese"),

    ("Molokhia", {"Molokhia": 3, "Chicken": 2, "Garlic": 1, "Olive Oil": 1},
     (20, 20, 10, 25), ["Molokhia", "Chicken", "Garlic"],
     "1. Cook the chicken until tender, then shred.\n2. Sauté garlic in olive oil until golden.\n3. Add molokhia and chicken to the garlic and cook until the molokhia is wilted.\n4. Serve with rice or bread.",
     "Dinner", 60, "Egyptian"),

    ("Harak Osba'o", {"Lentils": 3, "Pasta": 2, "Onion": 1, "Garlic": 1, "Coriander": 1, "Olive Oil": 1},
     (55, 12, 18, 75), ["Lentils", "Pasta", "Onion"],
     "1. Cook the lentils until tender.\n2. Cook the pasta separately until al dente.\n3. Fry the onions in olive oil until crispy.\n4. Mix the lentils, pasta, and fried onions together, garnishing with coriander.",
     "Lunch", 45, "Syrian"),

    ("Shawarma", {"Lamb": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1, "Spices": 1},
     (30, 20, 18, 60), ["Lamb", "Onion", "Garlic"],
     "1. Marinate the lamb with spices, garlic, and onion.\n2. Skewer the lamb and grill until cooked through.\n3. Slice thinly and serve in pita bread with vegetables and sauces.",
     "Dinner", 90, "Lebanese"),

    ("Fatet Hummus", {"Chickpeas": 3, "Pita Bread": 2, "Yogurt": 2, "Olive Oil": 1, "Garlic": 1},
     (45, 10, 20, 65), ["Chickpeas", "Pita Bread", "Yogurt"],
     "1. Toast the pita bread and break into pieces.\n2. Layer the pita bread with cooked chickpeas, yogurt, and garlic.\n3. Drizzle with olive oil and serve.",
     "Breakfast", 30, "Lebanese"),

    ("Sfeeha", {"Flour": 2, "Lamb": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (50, 15, 18, 70), ["Flour", "Lamb", "Onion"],
     "1. Prepare a dough using flour, water, and yeast.\n2. Mix the ground lamb with finely chopped onion, garlic, and spices.\n3. Roll out the dough, top with the lamb mixture, and bake until golden brown.",
     "Lunch", 60, "Syrian"),

    ("Maghmour", {"Eggplant": 2, "Chickpeas": 2, "Tomato": 2, "Onion": 1, "Olive Oil": 1},
     (40, 10, 15, 65), ["Eggplant", "Chickpeas", "Tomato"],
     "1. Fry the eggplant slices until golden brown.\n2. Sauté onions and garlic in olive oil, then add tomatoes and cook until soft.\n3. Add chickpeas and fried eggplant to the tomato mixture.\n4. Simmer until the flavors meld together.",
     "Dinner", 90, "Lebanese"),

    ("Lahm Bi Ajin", {"Flour": 3, "Lamb": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (55, 15, 18, 75), ["Flour", "Lamb", "Onion"],
     "1. Prepare the dough using flour, water, and yeast.\n2. Mix the ground lamb with finely chopped onion, garlic, and spices.\n3. Roll out the dough, top with the lamb mixture, and bake until golden brown.",
     "Lunch", 60, "Syrian"),

    ("Shanklish", {"Shanklish": 2, "Tomato": 2, "Onion": 1, "Olive Oil": 1},
     (20, 10, 15, 25), ["Shanklish", "Tomato", "Onion"],
     "1. Crumble the shanklish cheese.\n2. Mix with chopped tomatoes and onions.\n3. Drizzle with olive oil and serve as a salad.",
     "Appetizer", 10, "Lebanese"),

    ("Foul Moudammas", {"Fava Beans": 3, "Garlic": 1, "Olive Oil": 1, "Lemon": 1},
     (40, 15, 20, 45), ["Fava Beans", "Garlic", "Lemon"],
     "1. Cook the fava beans until tender.\n2. Sauté garlic in olive oil and add to the beans.\n3. Mash the beans slightly, then stir in lemon juice.\n4. Serve with a drizzle of olive oil.",
     "Breakfast", 20, "Egyptian"),

    ("Sayadieh", {"Rice": 3, "Fish": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (55, 20, 15, 75), ["Rice", "Fish", "Onion"],
     "1. Cook the fish with spices and set aside.\n2. Fry onions in olive oil until golden.\n3. Cook the rice in fish broth and mix with the fried onions.\n4. Serve the fish on top of the rice.",
     "Dinner", 60, "Lebanese"),

    ("Kebbeh Labanieh", {"Lamb": 2, "Bulgur": 2, "Yogurt": 2, "Garlic": 1, "Olive Oil": 1},
     (40, 18, 15, 65), ["Lamb", "Bulgur", "Yogurt"],
     "1. Prepare the kebbeh by mixing lamb, bulgur, and spices.\n2. Shape into balls and cook in a yogurt sauce.\n3. Serve hot.",
     "Dinner", 120, "Lebanese"),

    ("Maamoul", {"Flour": 3, "Semolina": 2, "Butter": 2, "Sugar": 3, "Rose Water": 1, "Dates": 2},
     (70, 8, 20, 75), ["Flour", "Semolina", "Dates"],
     "1. Prepare a dough with flour, semolina, butter, and rose water.\n2. Fill with date paste and shape into small balls.\n3. Press into a maamoul mold and bake until golden.",
     "Dessert", 90, "Lebanese"),

    ("Atayef", {"Flour": 2, "Sugar": 3, "Cheese": 2, "Rose Water": 1, "Honey": 1},
     (70, 10, 20, 80), ["Flour", "Sugar", "Cheese"],
     "1. Prepare small pancakes with the flour mixture.\n2. Fill with cheese and fold in half.\n3. Fry until golden, then drizzle with rose water syrup and honey.",
     "Dessert", 60, "Lebanese"),

    ("Halawet El Jibn", {"Semolina": 2, "Cheese": 2, "Sugar": 3, "Rose Water": 1},
     (65, 10, 18, 75), ["Semolina", "Cheese", "Sugar"],
     "1. Prepare a dough with semolina and cheese.\n2. Fill with cream and shape into rolls.\n3. Soak in rose water syrup and serve chilled.",
     "Dessert", 60, "Syrian"),

    ("Ashta", {"Milk": 2, "Sugar": 3, "Cornstarch": 1, "Rose Water": 1},
     (55, 8, 12, 65), ["Milk", "Sugar", "Cornstarch"],
     "1. Cook the milk with sugar and cornstarch until thickened.\n2. Add rose water and continue to cook until the mixture is creamy.\n3. Serve chilled as a dessert topping.",
     "Dessert", 30, "Lebanese"),

    ("Basbousa", {"Semolina": 3, "Sugar": 3, "Butter": 2, "Rose Water": 1},
     (70, 8, 20, 75), ["Semolina", "Sugar", "Butter"],
     "1. Mix the semolina with sugar and butter to form a batter.\n2. Pour the batter into a baking dish and bake until golden.\n3. Soak in rose water syrup and serve.",
     "Dessert", 60, "Egyptian"),

    ("Kunafa", {"Semolina": 3, "Cheese": 2, "Sugar": 3, "Butter": 2, "Rose Water": 1},
     (75, 10, 25, 80), ["Semolina", "Cheese", "Sugar"],
     "1. Layer semolina dough with cheese and bake until golden.\n2. Soak in rose water syrup and serve hot.",
     "Dessert", 90, "Palestinian"),

    ("Lamb Tagine", {"Lamb": 3, "Onion": 1, "Garlic": 1, "Cinnamon": 1, "Dried Apricots": 2},
     (35, 20, 18, 60), ["Lamb", "Onion", "Dried Apricots"],
     "1. Cook the lamb with onions and garlic until browned.\n2. Add cinnamon and dried apricots, and simmer until tender.\n3. Serve with couscous.",
     "Dinner", 120, "Moroccan"),

    ("Chicken Shawarma", {"Chicken": 3, "Yogurt": 1, "Garlic": 1, "Lemon": 1, "Cumin": 1},
     (10, 25, 10, 45), ["Chicken", "Yogurt", "Garlic"],
     "1. Marinate the chicken in yogurt, garlic, lemon, and spices.\n2. Skewer and grill until cooked through.\n3. Slice thinly and serve in pita bread with vegetables and sauces.",
     "Lunch", 60, "Lebanese"),

    ("Bulgur Pilaf", {"Bulgur": 3, "Tomato": 2, "Onion": 1, "Olive Oil": 1, "Spices": 1},
     (50, 8, 15, 60), ["Bulgur", "Tomato", "Onion"],
     "1. Sauté onions in olive oil until soft.\n2. Add tomatoes and cook until the sauce thickens.\n3. Stir in the bulgur and cook until tender.",
     "Lunch", 30, "Turkish"),

    ("Fish Tagine", {"Fish": 3, "Tomato": 2, "Bell Pepper": 1, "Garlic": 1, "Olive Oil": 1},
     (40, 15, 18, 50), ["Fish", "Tomato", "Bell Pepper"],
     "1. Sauté the onions and garlic in olive oil.\n2. Add tomatoes and bell peppers, and cook until softened.\n3. Place the fish on top and cook in the sauce until the fish is tender.",
     "Dinner", 90, "Moroccan"),

    ("Eggplant Moussaka", {"Eggplant": 3, "Tomato": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (30, 6, 15, 45), ["Eggplant", "Tomato", "Onion"],
     "1. Slice and fry the eggplant until golden.\n2. Sauté the onions and garlic in olive oil.\n3. Layer the fried eggplant with the sautéed onions, garlic, and tomatoes in a baking dish.\n4. Bake until the sauce is thickened and the top is golden.",
     "Dinner", 90, "Greek"),

    ("Chickpea Stew", {"Chickpeas": 3, "Tomato": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (40, 10, 15, 50), ["Chickpeas", "Tomato", "Onion"],
     "1. Sauté the onions and garlic in olive oil until soft.\n2. Add the tomatoes and cook until the sauce thickens.\n3. Stir in the chickpeas and simmer until tender.",
     "Dinner", 60, "Lebanese"),

    ("Spinach Pie", {"Spinach": 3, "Onion": 1, "Feta Cheese": 2, "Flour": 2, "Olive Oil": 1},
     (45, 10, 20, 60), ["Spinach", "Feta Cheese", "Flour"],
     "1. Prepare a dough using flour, water, and yeast.\n2. Sauté the spinach and onions in olive oil until soft.\n3. Mix with crumbled feta cheese and fill the dough with the mixture.\n4. Shape into pies and bake until golden.",
     "Lunch", 60, "Greek"),

    ("Freekeh Soup", {"Freekeh": 3, "Chicken": 2, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (35, 20, 15, 55), ["Freekeh", "Chicken", "Onion"],
     "1. Sauté the onions and garlic in olive oil.\n2. Add the freekeh and cook until slightly toasted.\n3. Add the chicken and water, and simmer until the freekeh and chicken are tender.",
     "Dinner", 45, "Syrian"),

    ("Lamb Couscous", {"Lamb": 3, "Couscous": 3, "Onion": 1, "Garlic": 1, "Olive Oil": 1},
     (60, 20, 18, 70), ["Lamb", "Couscous", "Onion"],
     "1. Cook the lamb with onions and garlic until browned.\n2. Serve over cooked couscous and garnish with herbs.",
     "Dinner", 90, "Moroccan"),

    ("Fattah", {"Pita Bread": 2, "Yogurt": 2, "Chickpeas": 2, "Olive Oil": 1, "Garlic": 1},
     (50, 10, 20, 65), ["Pita Bread", "Yogurt", "Chickpeas"],
     "1. Toast the pita bread until crispy and break into pieces.\n2. Layer with cooked chickpeas, yogurt, and garlic.\n3. Drizzle with olive oil and serve.",
     "Breakfast", 30, "Syrian"),

    ("Kebab", {"Lamb": 2, "Onion": 1, "Garlic": 1, "Cumin": 1, "Cinnamon": 1},
     (30, 25, 20, 55), ["Lamb", "Onion", "Cumin"],
     "1. Mix the ground lamb with finely chopped onion, garlic, cumin, cinnamon, and other spices.\n2. Shape the mixture into small patties or onto skewers.\n3. Grill or fry until cooked through.",
     "Dinner", 60, "Turkish"),

    ("Vegetable Couscous", {"Couscous": 3, "Zucchini": 2, "Carrot": 1, "Onion": 1, "Olive Oil": 1},
     (50, 8, 15, 60), ["Couscous", "Zucchini", "Carrot"],
     "1. Sauté the onions, carrots, and zucchini in olive oil until soft.\n2. Cook the couscous according to package instructions.\n3. Mix the couscous with the sautéed vegetables and serve.",
     "Lunch", 45, "Moroccan"),

    ("Chicken Tagine", {"Chicken": 3, "Onion": 1, "Garlic": 1, "Lemon": 1, "Olive Oil": 1},
     (25, 25, 18, 50), ["Chicken", "Onion", "Lemon"],
     "1. Sauté the onions and garlic in olive oil until soft.\n2. Add the chicken, lemon slices, and spices.\n3. Cook until the chicken is tender and the sauce has thickened.",
     "Dinner", 90, "Moroccan"),

    ("Fried Calamari", {"Calamari": 3, "Flour": 2, "Olive Oil": 1, "Garlic": 1, "Lemon": 1},
     (35, 15, 20, 55), ["Calamari", "Flour", "Olive Oil"],
     "1. Clean and slice the calamari into rings.\n2. Coat the rings in flour and fry in hot olive oil until golden.\n3. Serve with lemon wedges.",
     "Appetizer", 20, "Greek"),

    ("Zucchini Fritters", {"Zucchini": 3, "Flour": 2, "Eggs": 2, "Garlic": 1, "Olive Oil": 1},
     (40, 10, 15, 60), ["Zucchini", "Flour", "Eggs"],
     "1. Grate the zucchini and squeeze out excess moisture.\n2. Mix with flour, eggs, and garlic.\n3. Fry spoonfuls of the mixture in olive oil until golden.",
     "Appetizer", 30, "Greek"),

    ("Stuffed Bell Peppers", {"Bell Pepper": 4, "Rice": 2, "Lamb": 2, "Tomato": 2, "Onion": 1},
     (50, 15, 18, 65), ["Bell Pepper", "Rice", "Lamb"],
     "1. Hollow out the bell peppers and set aside.\n2. Mix the rice, minced lamb, tomatoes, and onions.\n3. Stuff the bell peppers with the rice mixture.\n4. Bake until the peppers are tender.",
     "Dinner", 90, "Greek"),

    ("Spinach and Cheese Borek", {"Spinach": 3, "Feta Cheese": 2, "Flour": 2, "Olive Oil": 1},
     (45, 10, 20, 60), ["Spinach", "Feta Cheese", "Flour"],
     "1. Prepare a dough using flour, water, and yeast.\n2. Sauté the spinach and onions in olive oil until soft.\n3. Mix with crumbled feta cheese and fill the dough with the mixture.\n4. Shape into pies and bake until golden.",
     "Lunch", 60, "Turkish"),

    ("Seafood Paella", {"Rice": 3, "Fish": 2, "Shrimp": 2, "Onion": 1, "Garlic": 1},
     (55, 20, 18, 70), ["Rice", "Fish", "Shrimp"],
     "1. Sauté the onions and garlic in olive oil until soft.\n2. Add the rice and cook for a few minutes.\n3. Add the fish, shrimp, and broth, and cook until the rice is tender and the seafood is cooked through.",
     "Dinner", 60, "Spanish"),

    ("Lamb Shank", {"Lamb": 3, "Onion": 1, "Garlic": 1, "Cinnamon": 1, "Tomato": 2},
     (40, 25, 18, 60), ["Lamb", "Onion", "Tomato"],
     "1. Sauté the onions and garlic in olive oil until soft.\n2. Add the lamb shanks and brown on all sides.\n3. Add the tomatoes, cinnamon, and broth, and simmer until the lamb is tender.",
     "Dinner", 150, "Moroccan"),

    ("Baklava Ice Cream", {"Milk": 3, "Sugar": 3, "Pistachios": 2, "Honey": 1, "Cinnamon": 1},
     (60, 8, 20, 70), ["Milk", "Sugar", "Pistachios"],
     "1. Prepare the ice cream base with milk, sugar, and cinnamon.\n2. Churn in an ice cream maker until soft.\n3. Fold in crushed pistachios and freeze until firm.\n4. Serve with a drizzle of honey.",
     "Dessert", 180, "Turkish"),

    ("Tzatziki", {"Yogurt": 2, "Cucumber": 2, "Garlic": 1, "Lemon": 1, "Olive Oil": 1},
     (15, 6, 12, 25), ["Yogurt", "Cucumber", "Garlic"],
     "1. Grate the cucumber and squeeze out excess moisture.\n2. Mix with yogurt, minced garlic, lemon juice, and olive oil.\n3. Serve chilled as a dip.",
     "Appetizer", 15, "Greek"),

    ("Chicken Souvlaki", {"Chicken": 3, "Garlic": 1, "Lemon": 1, "Olive Oil": 1, "Oregano": 1},
     (10, 25, 10, 45), ["Chicken", "Garlic", "Lemon"],
     "1. Marinate the chicken pieces in garlic, lemon juice, olive oil, and oregano for a few hours.\n2. Skewer the chicken and grill until cooked through.",
     "Lunch", 45, "Greek"),

    ("Spanakopita", {"Spinach": 3, "Feta Cheese": 2, "Flour": 2, "Olive Oil": 1},
     (45, 10, 20, 60), ["Spinach", "Feta Cheese", "Flour"],
     "1. Prepare a dough using flour, water, and yeast.\n2. Sauté the spinach and onions in olive oil until soft.\n3. Mix with crumbled feta cheese and fill the dough with the mixture.\n4. Shape into pies and bake until golden.",
     "Lunch", 60, "Greek"),

    ("Moussaka", {"Eggplant": 3, "Lamb": 2, "Tomato": 2, "Onion": 1, "Garlic": 1},
     (40, 15, 20, 60), ["Eggplant", "Lamb", "Tomato"],
     "1. Slice and fry the eggplant until golden.\n2. Sauté the onions and garlic in olive oil.\n3. Layer the fried eggplant with the sautéed onions, garlic, and lamb in a baking dish.\n4. Bake until the sauce is thickened and the top is golden.",
     "Dinner", 120, "Greek"),

    ("Feta and Olive Salad", {"Feta Cheese": 2, "Olives": 2, "Tomato": 2, "Cucumber": 1, "Olive Oil": 1},
     (15, 8, 15, 30), ["Feta Cheese", "Olives", "Tomato"],
     "1. Chop the tomatoes and cucumber.\n2. Toss with feta cheese and olives.\n3. Drizzle with olive oil and serve.",
     "Appetizer", 10, "Greek"),

    ("Baklava", {"Phyllo Dough": 3, "Walnuts": 2, "Butter": 2, "Sugar": 3, "Honey": 1},
     (70, 8, 20, 75), ["Phyllo Dough", "Walnuts", "Sugar"],
     "1. Layer phyllo dough in a baking dish, brushing each layer with butter.\n2. Mix the chopped walnuts with sugar.\n3. Spread the nut mixture over the dough layers and cover with more layers of phyllo dough.\n4. Bake until golden and crispy, then drizzle with honey.",
     "Dessert", 120, "Turkish"),

    ("Saganaki", {"Cheese": 2, "Flour": 2, "Olive Oil": 1, "Lemon": 1},
     (20, 10, 15, 30), ["Cheese", "Flour", "Lemon"],
     "1. Coat the cheese slices in flour.\n2. Fry in hot olive oil until golden and crispy.\n3. Serve with a squeeze of lemon.",
     "Appetizer", 10, "Greek"),

    ("Dolma", {"Grape Leaves": 20, "Rice": 2, "Lamb": 2, "Onion": 1, "Olive Oil": 1},
     (50, 15, 20, 65), ["Grape Leaves", "Rice", "Lamb"],
     "1. Blanch the grape leaves in boiling water.\n2. Mix the rice, minced lamb, and spices.\n3. Stuff the grape leaves with the rice and lamb mixture, then roll tightly.\n4. Cook the stuffed grape leaves in a pot with olive oil and lemon juice.",
     "Dinner", 150, "Turkish"),

    ("Fried Halloumi", {"Halloumi": 2, "Olive Oil": 1, "Lemon": 1, "Mint": 1},
     (10, 15, 20, 25), ["Halloumi", "Olive Oil", "Lemon"],
     "1. Slice the halloumi cheese into thick slices.\n2. Fry in hot olive oil until golden and crispy.\n3. Serve with a squeeze of lemon and garnish with mint.",
     "Appetizer", 10, "Cypriot"),
]


def convert_recipe_to_dict(recipe):
    name, ingredients, nutrition_info, main_ingredients, instructions, category, meal_time, cuisine = recipe

    return {
        "name": name,
        "ingredients": ingredients,
        "nutrition_info": {
            "calories": nutrition_info[0],
            "fat_g": nutrition_info[1],
            "carbohydrates_g": nutrition_info[2],
            "protein_g": nutrition_info[3]
        },
        "main_ingredients": main_ingredients,
        "instructions": instructions,
        "category": category,
        "meal_time": meal_time,
        "cuisine": cuisine
    }


if len(recipes) == 0:
    raise ValueError(
        "The recipes list is empty. Please provide valid recipes before running the genetic algorithm.")
creator.create("FitnessMin", base.Fitness, weights=(-1.0,))
creator.create("Individual", list, fitness=creator.FitnessMin)

toolbox = base.Toolbox()
toolbox.register("attr_recipe", random.randint, 0, len(recipes) - 1)
toolbox.register("individual", tools.initRepeat,
                 creator.Individual, toolbox.attr_recipe, n=5)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)


def evalRecipes(individual, inventory):
    remaining_inventory = inventory.copy()
    total_carbs = 0
    total_proteins = 0
    total_fats = 0
    total_gi = 0
    waste = 0
    preference_score = 0
    invalid_recipe_penalty = 1000

    for recipe_index in individual:
        recipe_name, required_items, nutrition_info, main_ingredients, _, _, _, _ = recipes[
            recipe_index]
        carbs, proteins, fats, gi = nutrition_info
        valid_recipe = True

        for item, required_qty in required_items.items():
            if remaining_inventory.get(item, 0) >= required_qty:
                remaining_inventory[item] -= required_qty
            else:
                valid_recipe = False

        if not valid_recipe:
            waste += invalid_recipe_penalty
        else:
            total_carbs += carbs
            total_proteins += proteins
            total_fats += fats
            total_gi += gi
            preference_score += user_preferences.get(recipe_name, 0)

    carb_threshold = 150
    gi_threshold = 60
    if total_carbs > carb_threshold:
        waste += (total_carbs - carb_threshold) * 5

    if total_gi / len(individual) > gi_threshold:
        waste += (total_gi / len(individual) - gi_threshold) * 2
    if total_proteins < total_carbs * 0.2:
        waste += (total_carbs - total_proteins * 0.2) * 5
    waste -= preference_score

    waste += sum(remaining_inventory.values())

    return waste,


toolbox.register("evaluate", evalRecipes)
toolbox.register("mate", tools.cxTwoPoint)
toolbox.register("mutate", tools.mutFlipBit, indpb=0.05)
toolbox.register("select", tools.selTournament, tournsize=3)


def get_main_ingredients(individual):
    main_ingredients_needed = set()
    for recipe_index in individual:
        _, _, _, main_ingredients, _, _, _, _ = recipes[recipe_index]
        main_ingredients_needed.update(main_ingredients)
    return main_ingredients_needed


def run_genetic_algorithm(inventory):
    random.seed(42)
    toolbox.register("evaluate", partial(evalRecipes, inventory=inventory))
    population = toolbox.population(n=100)

    stats = tools.Statistics(lambda ind: ind.fitness.values)
    stats.register("avg", lambda x: sum(val[0] for val in x) / len(x))
    stats.register("min", lambda x: min(val[0] for val in x))
    stats.register("max", lambda x: max(val[0] for val in x))

    population, logbook = algorithms.eaSimple(population, toolbox, cxpb=0.7, mutpb=0.8, ngen=50,
                                              stats=stats, verbose=True)

    best_ind = tools.selBest(population, 1)[0]
    print("Best individual is: %s, with waste: %s" %
          (best_ind, evalRecipes(best_ind, inventory)[0]))

    main_ingredients_needed = get_main_ingredients(best_ind)
    print("Main ingredients needed for the selected recipes:")
    print(main_ingredients_needed)

    selected_recipes_details = [convert_recipe_to_dict(
        recipes[recipe_index]) for recipe_index in best_ind]

    print("Recipes to prepare:")
    for recipe_details in selected_recipes_details:
        print(recipe_details)

    return selected_recipes_details
