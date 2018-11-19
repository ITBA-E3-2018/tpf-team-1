module VGA_controller (clk, seconds, minutes, hours, R, G, B, h_sync, v_sync);

    input clk;
    input [3:0] seconds;
    input [3:0] minutes;
    input [3:0] hours;
    output reg R, G, B, h_sync='b0, v_sync='b0;
    reg [9:0] count1=0; //contador vertical
    reg [9:0] count2=0; //contador horizontal
    
    always @(posedge clk) begin
        if (count1 < 480) begin //parte vertical del display
            if (count2 < 640) begin //parte horizontal del display
                if (count1 > 280 && count1 < 360 && count2 > 48 && count2 < 432) begin //zona de escritura del numero
                    R='b1;
                    G='b1;
                    B='b1;
                    $write ("%b",R);
                end
                else begin
                    R='b0;
                    G='b0;
                    B='b0;
                    //$write ("%b",R);
                end
                count2 = count2 + 1;
            end
            //blank space horizontal
            else if (count2 < 656) begin 
                R='b0;
                G='b0;
                B='b0;
                count2 = count2 + 1;
            end

            else if (count2 < 752) begin
                h_sync = 1;
                count2 = count2 + 1;
            end
            else if (count2 < 800) begin
                h_sync = 0;
                count2 = count2 + 1;
            end
            else begin
                count1 = count1 + 1;
                count2 = 0;
                $write ("\n");
                //termino la parte horizontal de la fila count1
            end
        end
        else if (count1 < 525) begin
            //
            //v sync cuando llego al blank space vertical
            //
            if (count1 < 490) begin
                R='b0;
                G='b0;
                B='b0;
            end
            else if (count1 < 492) begin
                v_sync = 1;
            end
            else if (count1 < 525)begin
                v_sync = 0;
            end
            //
            //h_sync mientras esta en el blank space vertical
            //
            if (count2 < 640) begin
                R='b0;
                G='b0;
                B='b0;
                count2 = count2 + 1;
            end
            else if (count2 < 656)
                count2 = count2 + 1;

            else if (count2 < 752) begin
                h_sync = 1;
                count2 = count2 + 1;
            end
            else if (count2 < 800) begin
                h_sync = 0;
                count2 = count2 + 1;
            end
            else begin
                count1 = count1 + 1;
                count2 = 0;
            end
        end
        //cuando termina el blank space vertical
        else begin
            count1 = 0;
            count2 = 0;
        end
    end


endmodule