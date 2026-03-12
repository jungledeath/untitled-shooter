// --- THE FADE-OUT LOGIC ---
my_alpha -= fade_speed;

// If the text is invisible, destroy the object to save performance.
if (my_alpha <= 0) 
{
    instance_destroy();
}