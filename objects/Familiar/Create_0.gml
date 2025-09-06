
drawOnSurface = false;
scale = 1;

anglex = 0;
angley = 0;

playerOffset = vec2();
alarm[0] = 1;

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_normal();
vertex_format_add_texcoord();
vformat = vertex_format_end();

vbuffer = vertex_create_buffer();

textureSprite = TextureMap_Skull;
filename = "actualskull.obj"

vb_minion = import_obj(filename, vformat);
