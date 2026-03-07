// Rapidly expand
image_xscale += 0.2;
image_yscale += 0.2;

// Fade out
image_alpha -= 0.1;

// Destroy when invisible
if (image_alpha <= 0)
{
    instance_destroy();
}