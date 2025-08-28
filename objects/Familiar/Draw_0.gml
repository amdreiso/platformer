
angle_x += 1;
angle_y += 2;

var mx = matrix_build(x, y, 0, -90, 0, 0, scale * 2, scale, scale);
matrix_set(matrix_world, mx);

if (drawOnSurface) surface_set_target(SurfaceHandler.surface);

vertex_submit(vb_minion, pr_trianglelist, sprite_get_texture(sSword_TM, 0));

if (drawOnSurface) surface_reset_target();

matrix_set(matrix_world, matrix_build_identity());

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);