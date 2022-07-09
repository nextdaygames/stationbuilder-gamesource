return {
    varname = "makeAnItem",
    name = "Make an Item",
    description = "Navigate the item creation pipeline from image to an object in your hand.",
    stages = {
        CreatedImage = {
            order = 1, 
            description = "Create an image with the Image Creator",
            isReached = false,
        },
        ViewedImageGallery = { 
            order = 2, 
            description = "View images in the Image Gallery",
            isReached = false,
        },
        CreatedItem = { 
            order = 3, 
            description = "Create an item with the Item Creator",
            isReached = false,
        },
        SpawnedItemFromGallery = { 
            order = 4, 
            description = "Spawn an item by clicking one in the Item Gallery",
            isReached = false,
        },
    }
}