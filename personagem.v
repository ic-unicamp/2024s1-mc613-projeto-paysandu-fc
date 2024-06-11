module personagem(
    input CLOCK50, reset,
    input KEY3, KEY2, KEY1, KEY0,
    output wire [9:0] topLimit_out, bottomLimit_out, 
    output wire [9:0] rightLimit, leftLimit

);
    reg keyLeft_done = 0, keyRight_done = 0;
    reg keyUp_done = 0, keyDown_done = 0; 
    reg keyRestart_done = 0;

    reg signed [9:0] topLimit, bottomLimit, leftLimit, rightLimit;
    topLimit = 328;
    bottomLimit =312;
    leftLimit = 232;
    rightLimit = 248;

    always @(posedge CLOCK50)begin
        if(!reset)begin
            //inicializa personagem
            topLimit = 328;
            bottomLimit =312;
            leftLimit = 232;
            rightLimit = 248;

        end else begin
            if((keyUp_done | keyDown_done)==0)begin
                if(!KEY3)begin
                    //movimenta para cima
                    keyUp_done <= 1;
                    if(topLimit+16 < 640)begin
                        topLimit = topLimit + 16;
                        bottomLimit = bottomLimit + 16;
                    end
                end
                if(!KEY2)begin
                    //movimenta para baixo
                    keyDown_done <= 1;
                    if(bottomLimit-16>0)begin
                        topLimit = topLimit - 16;
                        bottomLimit = bottomLimit - 16;
                    end
                end
            end
            if((keyLeft_done | keyRight_done)==0)begin
                if(!KEY1)begin
                    //movimenta para esquerda
                    keyLeft_done <= 1;
                    if(leftLimit-16>0)begin
                        leftLimit = leftLimit - 16;
                        rightLimit = rightLimit - 16;
                    end
                end
                if(!KEY0)begin
                    //movimenta para direita
                    keyRight_done <= 1;
                    if(rightLimit+16<480)begin
                        leftLimit = leftLimit + 16;
                        rightLimit = rightLimit + 16;
                    end
                end
            end
        end
    end

    assign topLimit_out = topLimit;
    assign bottomLimit_out = bottomLimit;
    assign leftLimit_out = leftLimit;
    assign rightLimit_out = rightLimit;
    

endmodule