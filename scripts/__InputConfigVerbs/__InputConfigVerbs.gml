function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
          UP,
        DOWN,
        LEFT,
        RIGHT,
		OK,
		AIM_UP,
        AIM_DOWN,
        AIM_LEFT,
        AIM_RIGHT,
        TURRETFIRE,
        BOOST,
        PAUSE,
		PUPUP,
		PUPDOWN,
		PUPFIRE,
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    if (not INPUT_ON_SWITCH)
    {
        InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh]);
		InputDefineVerb(INPUT_VERB.AIM_UP,      "aimup",         [vk_up,    "W"],    [-gp_axisrv]);
        InputDefineVerb(INPUT_VERB.AIM_DOWN,    "aimdown",       [vk_down,  "S"],    [ gp_axisrv]);
        InputDefineVerb(INPUT_VERB.AIM_LEFT,    "aimleft",       [vk_left,  "A"],    [-gp_axisrh]);
        InputDefineVerb(INPUT_VERB.AIM_RIGHT,   "aimright",      [vk_right, "D"],    [ gp_axisrh]);
        InputDefineVerb(INPUT_VERB.PUPDOWN,   "pupdown",       vk_escape,           gp_shoulderlb);
		InputDefineVerb(INPUT_VERB.PUPUP,   "pupup",       vk_escape,           gp_shoulderrb);
		InputDefineVerb(INPUT_VERB.PUPFIRE,   "pupfire",       vk_escape,           gp_shoulderr);
		InputDefineVerb(INPUT_VERB.BOOST,   "boost",       vk_escape,           gp_shoulderl);
		InputDefineVerb(INPUT_VERB.PAUSE,   "pause",       vk_escape,           gp_start);
		InputDefineVerb(INPUT_VERB.OK,   "ok",       vk_escape,           gp_face1);
    }
    else //Flip A/B over on Switch
    {
        InputDefineVerb(INPUT_VERB.UP,      "up",      undefined, [-gp_axislv]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",    undefined, [ gp_axislv]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",    undefined, [-gp_axislh]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",   undefined, [ gp_axislh]);
		InputDefineVerb(INPUT_VERB.AIM_UP,      "aimup",         [vk_up,    "W"],    [-gp_axisrv]);
        InputDefineVerb(INPUT_VERB.AIM_DOWN,    "aimdown",       [vk_down,  "S"],    [ gp_axisrv]);
        InputDefineVerb(INPUT_VERB.AIM_LEFT,    "aimleft",       [vk_left,  "A"],    [-gp_axisrh]);
        InputDefineVerb(INPUT_VERB.AIM_RIGHT,   "aimright",      [vk_right, "D"],    [ gp_axisrh]);
        InputDefineVerb(INPUT_VERB.PUPDOWN,   "pupdown",   undefined,			gp_shoulderlb);
		InputDefineVerb(INPUT_VERB.PUPUP,   "pupup",   undefined,			gp_shoulderrb);
		InputDefineVerb(INPUT_VERB.PUPFIRE,   "pupfire",   undefined,					gp_shoulderr);
		InputDefineVerb(INPUT_VERB.BOOST,   "boost",       undefined,				gp_shoulderl);
		InputDefineVerb(INPUT_VERB.PAUSE,   "pause",       vk_escape,				gp_start);
		InputDefineVerb(INPUT_VERB.OK,   "ok",       vk_escape,           gp_face1);
    }
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
