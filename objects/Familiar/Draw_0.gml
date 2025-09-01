
var pxdir = Player.hsp;
anglex = lerp(anglex, 50 * pxdir, 0.01);

var mx = matrix_build(x, y, 0, 180, anglex, 0, scale, scale, scale);
matrix_set(matrix_world, mx);

if (drawOnSurface) surface_set_target(SurfaceHandler.surface);

vertex_submit(vb_minion, pr_trianglelist, sprite_get_texture(textureSprite, 0));

if (drawOnSurface) surface_reset_target();

matrix_set(matrix_world, matrix_build_identity());


gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);