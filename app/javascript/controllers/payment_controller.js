import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment"
export default class extends Controller {
  static targets = [ "selection", "additionalFields" ]

  initialize() {
    this.showAdditionalFields()
  }

  showAdditionalFields() {
    let selection = this.selectionTarget.value

    for (let fields of this.additionalFieldsTargets) {
      fields.disabled = fields.hidden = (fields.dataset.type !== selection)
    }
  }
}

/*
Сначала объявляем список целей.
Цели определяют элементы HTML, с которыми будет взаимодействовать наш контроллер.
Нашими целями являются элемент выбора и дополнительные поля.
Мы просто перечисляем наши цели, не указывая, сколько каждого из них мы ожидаем.
 */

/*
Далее определяем логику инициализации, которую можно было бы реализовать как цикл по целям, скрывая каждую, но оказывается, что мы можем воспользоваться кодом, который показывает дополнительные поля.
Это дает дополнительное преимущество, позволяя изящно справиться со случаем, когда браузер восстанавливает значение некоторых полей формы, когда пользователь вручную обновляет окно браузера.
 */

/*
Наконец, пределим код, который показывает дополнительные поля.
Начинаем с получения значения выбора. Затем мы выполняем итерации по дополнительным полям.
Внутри итерации мы либо отключаем и скрываем, либо включаем и показываем каждый набор полей в зависимости от того, соответствует ли тип этих полей выбранному.
 */