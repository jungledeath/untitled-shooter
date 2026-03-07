// Rapidly shrink and fade out
image_xscale -= 0.15;
image_yscale -= 0.15;
image_alpha -= 0.15;

// Destroy itself when invisible
if (image_alpha <= 0) 
{
    instance_destroy();
}