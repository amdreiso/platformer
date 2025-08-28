
drawOnSurface = false;
scale = 2;

angle_x = 0;
angle_y = 0;

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_normal();
vertex_format_add_texcoord();
vformat = vertex_format_end();

vbuffer = vertex_create_buffer();


vb_minion = import_obj("sword.obj", vformat);
