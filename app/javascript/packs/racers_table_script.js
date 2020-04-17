document.addEventListener("DOMContentLoaded", inputNumberValidate)
document.addEventListener("DOMContentLoaded", selectRaceMember)

// Валидация для input class="type-number" (допускается ввод только цифр)
function inputNumberValidate() {
    const inputList = document.querySelectorAll(".type-number");
    inputList.forEach((elem)=>{
        elem.addEventListener("input",(event)=>{
            const validSign = [0,1,2,3,4,5,6,7,8,9];        
            const newValue = event.target.value.split("").map((elem) => {
                if (validSign.indexOf(Number(elem)) === -1) {
                    return elem = ""
                }
                else {
                    return elem
                }
            })
            event.target.value = newValue.join("");           
        })
    })
}

// Функция блокирует выбор одинаковых гонщиков для "Участник №1" и "Участник №2"
function selectRaceMember() {
    const selectList = document.querySelectorAll(".form-select-field-type-one");
    selectList.forEach((elem,index)=>{
        elem.addEventListener("change",(event)=>{
            changeListOption(event.target.name, event.target.value)            
        })
        elem.options[index].selected = true
        changeListOption(elem.name, elem.value)      
    })
    function changeListOption(nameSelect, value) {
        selectList.forEach((elem)=>{
            if (elem.name !== nameSelect) {               
                for (let i = 0; i < elem.options.length; i++) {                   
                    if (elem.options[i].hidden === true) {
                        elem.options[i].hidden = false                      
                    }
                    if (elem.options[i].value === value) {
                        elem.options[i].hidden = true
                    }
                }
            }        
        })
    }
}



