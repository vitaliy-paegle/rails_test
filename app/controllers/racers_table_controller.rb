class RacersTableController < ApplicationController 
    
    layout "racers_table_layout"
    
    def index

        @racerslist = racerslist_modify
        @raceslist = raceslist_modify
        @error_message = []
        @error_message_race = []      


        # if params[:error] != nil          
        #     if eval(params[:error])[:name] != nil
        #        @error.push("Ошибка в поле 'Имя'")
        #     elsif  eval(params[:error])[:number] != []
        #        @error.push("Ошибка в поле 'Номер'")
        #     end
        # end   

     end
    
    def create
        
        @new_racer = Racer.create(name: params[:new_racer][:name], number: params[:new_racer][:number])

        # puts "-----------------------"
        # puts @new_racer.inspect
        # puts "-----------------------"

        if @new_racer.created_at == nil
            
            # puts "-----------------------"
            # puts @new_racer.errors.details
            # puts "-----------------------"
            @error = @new_racer.errors.details  
            @error_message = []          
            if @error[:name] != []                                         
                @error_message.push("Ошибка в поле 'Имя'")
            elsif  @error[:number] != []
                @error_message.push("Ошибка в поле 'Номер'")
            end
            @racerslist = racerslist_modify
            @raceslist = raceslist_modify
            @error_message_race = []
            render action: "index"  
            # redirect_to action: "index", error: @error.to_s
            # redirect_to racers_table_path(@error)            
            
        else                
            redirect_to racers_table_path
        end
    end

    def edit
        @racers_list_modify =  racerslist_modify
        @racers_list_modify.map do |elem|
            if elem["id"].to_s == params[:info]
                elem["edit"] = true                 
            end
        end
        @raceslist = raceslist_modify
        @error_message = []
        @error_message_race = []
        render action: "index"        
    end

    def update
       puts params["racer_update"]["id"]
       @racer = Racer.find_by(id: params["racer_update"]["id"])
       puts @racer.inspect
       @result = @racer.update(name: params["racer_update"]["name"], number: params["racer_update"]["number"])
       if @result
          redirect_to action: "index"
       end
    end
    
    def delete   
        @result = Racer.destroy_by(id: params[:info])        
        if @result.inspect != []
            redirect_to action: "index" 
        end                   
    end

    def create_race
        @new_race = Race.create(name: params["new_race"]["name"], member_one: params["new_race"]["member_one"], member_two: params["new_race"]["member_two"])
        @error_message_race = [] 
        if @new_race.errors.details == {}
            redirect_to action: "index"
        else
            @new_race.errors.details[:name].each do |e|            
                if e[:error] == :blank               
                    @error_message_race.push "Поле 'Название гонки' - не заполненно" 
                    break               
                elsif e[:error] == :too_short               
                    @error_message_race.push "'Название гонки' - слишком короткое"           
                end
            end       
            @racerslist = racerslist_modify
            @raceslist = raceslist_modify
            @error_message = []            
            render action: "index"
        end 
    end

    def delete_race
        @result = Race.destroy_by(id: params[:info])        
        if @result.inspect != []
            redirect_to action: "index" 
        end 
    end


    private

    def new_racer_valid_params
        params.require(:new_racer).permit(:name, :number)
    end

    def racerslist_modify
        @racerslist = []         
        Racer.all.each do |elem|
            elem = elem.as_json
            elem["edit"] = false 
            @racerslist.push(elem)      
        end
        return @racerslist           
    end

    def raceslist_modify
            @raceslist = Race.all  
            @raceslist.map do |r|
            member_one = Racer.find_by(id: r.member_one)
            member_two = Racer.find_by(id: r.member_two)

            if member_one == nil
                r.member_one = "Удален"
                if member_two == nil
                    r.member_two = "Удален"
                else
                    r.member_two = member_two.name
                end
            elsif member_two == nil
                r.member_two = "Удален"
                r.member_one = member_one.name
            elsif member_two == nil && member_one == nil
                r.member_two = "Удален"
                r.member_one = "Удален"
            else
                r.member_one = member_one.name
                r.member_two = member_two.name
            end
        end
        return @raceslist
    end

end
