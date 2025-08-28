function vertex_add_point(vbuffer, x, y, z, nx, ny, nz, u, v, color=c_white, alpha=1){

	vertex_position_3d(vbuffer, x, y, z); 
	vertex_normal(vbuffer, nx, ny, nz);
	vertex_texcoord(vbuffer, u, v);
	vertex_color(vbuffer, color, alpha);

}