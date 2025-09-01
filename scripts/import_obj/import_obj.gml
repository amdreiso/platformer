
// DragoniteSpam's code

function import_obj(filename, vertex_format) {
    var buffer = buffer_load(filename);
    var content_string = buffer_read(buffer, buffer_text);
    buffer_delete(buffer);
    
    var t_start = get_timer();
    
    var lines = string_split(content_string, "\n");
    
    var vb = vertex_create_buffer();
    vertex_begin(vb, vertex_format);
    
    var positions = [];
    var texcoords = [];
    var normals = [];
    
    for (var i = 0; i < array_length(lines); i++) {
        var this_line = lines[i];
        if (this_line == "") continue;
        
        var tokens = string_split(this_line, " ");
        
        switch (tokens[0]) {
            case "v":
                var vx = real(tokens[1]);
                var vy = real(tokens[2]);
                var vz = real(tokens[3]);
                array_push(positions, {
                    x: vx, y: vz, z: vy
                });
                break;
            case "vt":
                var tx = real(tokens[1]);
                var ty = real(tokens[2]);
                array_push(texcoords, {
                    x: tx, y: 1 - ty
                });
                break;
            case "vn":
                var nx = real(tokens[1]);
                var ny = real(tokens[2]);
                var nz = real(tokens[3]);
                array_push(normals, {
                    x: nx, y: nz, z: ny
                });
                break;
            case "f":
					    for (var j = 3; j < array_length(tokens); j++) {
					        // Triangulate: (1, j-1, j)
					        var verts = [tokens[1], tokens[j - 1], tokens[j]];
        
					        for (var k = 0; k < 3; k++) {
					            var idx_tokens = string_split(verts[k], "/");
            
					            var pos = {x:0,y:0,z:0};
					            var tex = {x:0,y:0};
					            var nor = {x:0,y:0,z:0};
            
					            // position (first number, always exists)
					            if (array_length(idx_tokens) > 0 && idx_tokens[0] != "") {
					                pos = positions[real(idx_tokens[0]) - 1];
					            }
            
					            // texcoord (second number, optional)
					            if (array_length(idx_tokens) > 1 && idx_tokens[1] != "") {
					                tex = texcoords[real(idx_tokens[1]) - 1];
					            }
            
					            // normal (third number, optional)
					            if (array_length(idx_tokens) > 2 && idx_tokens[2] != "") {
					                nor = normals[real(idx_tokens[2]) - 1];
					            }
            
					            // push vertex to buffer
					            vertex_position_3d(vb, pos.x, pos.y, pos.z);
					            vertex_normal(vb, nor.x, nor.y, nor.z);
					            vertex_texcoord(vb, tex.x, tex.y);
					            vertex_colour(vb, c_white, 1);
					        }
					    }
					    break;
        }
    }
    
    var t_end = get_timer();
    show_debug_message($"Parsing the obj file took {(t_end - t_start) / 1000} milliseconds");
    
    vertex_end(vb);
    vertex_freeze(vb);
    
    return vb;
}