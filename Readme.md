# FakeNFT

Приложение находится в разработке
[Дизайн Figma](https://www.figma.com/file/k1LcgXHGTHIeiCv4XuPbND/FakeNFT-(YP)?type=design&node-id=641-28900&mode=design&t=fgnB4W4EzuDvM57H-0)    

## Назначение и цели приложения

Приложение помогает пользователям просматривать и покупать NFT (Non-Fungible Token). Функциональность покупки имитируется с помощью мокового сервера.

Цели приложения:

- просмотр коллекций NFT;
- просмотр и покупка NFT (имитируется);
- просмотр рейтинга пользователей.

## Краткое описание приложения

- Приложение демонстрирует каталог NFT, структурированных в виде коллекций
- Пользователь может посмотреть информацию о каталоге коллекций, выбранной коллекции и выбранном NFT.
- Пользователь может добавлять понравившиеся NFT в избранное.
- Пользователь может удалять и добавлять товары в корзину, а также оплачивать заказ (покупка имитируется).
- Пользователь может посмотреть рейтинг пользователей и информацию о пользователях.
- Пользователь может смотреть информацию и своем профиле, включая информацию об избранных и принадлежащих ему NFT.


##Каталог

###Экран каталога
На экране каталога отображается таблица, показывающая доступные коллекции NFT. Для каждой коллекции NFT отображается:
- обложка коллекции;
- название коллекции;
- количество NFT в коллекции.
- на экране есть кнопка сортировки, при нажатии на которую пользователю предлагается выбрать один из доступных способов сортировки. Содержимое таблицы упорядочивается согласно выбранному способу. (пока не реализовано)

Пока данные для показа не загружены, должен отображаться индикатор загрузки.

При нажатии на одну из ячеек таблицы пользователь попадает на экран выбранной коллекции NFT.

###Экран коллекции NFT
Экран отображает информацию о выбранной коллекции NFT, и содержит:
- обложку коллекции NFT;
- название коллекции NFT;
- текстовое описание коллекции NFT;
- имя автора коллекции (ссылка на его сайт);
- коллекцию с информацией о входящий в коллекцию NFT.

При нажатии на имя автора коллекции открывается его сайт в вебвью.

Каждая ячейка коллекции содержит:
- изображение NFT;
- название NFT;
- рейтинг NFT;
- стоимость NFT (в ETH);
- кнопку для добавления в избранное / удаления из избранного (сердечко);
- кнопку добавления NFT в корзину / удаления NFT из корзины.

При нажатии на кнопку добавления NFT в корзину / удаления NFT из корзины производится добавление или удаление NFT из заказа (корзины). Изображение кнопки при этом меняется, если NFT добавлено в заказ отображается кнопка с крестиком, если нет - кнопка без крестика.

При нажатии на ячейку открывается экран NFT. (пока не реализовано)

##Корзина

###Экран заказа
На экране таблицы отображается таблица со списком добавленных в заказ NFT. Для каждого NFT указаны:
- изображение;
- имя;
- рейтинг;
- цена;
- кнопка удаления из корзины.

При нажатии на кнопку удаления из корзины показывается экран подтверждения удаления, который содержит:
- изображение NFT;
- текст об удалении;
- кнопку подтверждения удаления;
- кнопку отказа от удаления.

Сверху на экране есть кнопка сортировки, при нажатии на которую пользователю предлагается выбрать один из доступных способов сортировки. Содержимое таблицы упорядочивается согласно выбранному способу. (пока не реализовано)

Внизу экрана расположена панель с количеством NFT в заказе, общей ценой и кнопкой оплаты. При нажатии на кнопку оплаты происходит переход на экран выбора валюты.

Пока данные для показа не загружены или обновляются, должен отображаться индикатор загрузки. (пока не реализовано)

###Экран выбора валюты
Экран позволяет выбрать валюту для оплаты заказа.

Сверху экрана находится заголовок и кнопка возврата на предыдущий экран. Под ним - коллекция с доступными способами оплаты. Для каждой валюты указывается:
- логотип;
- полное наименование;
- сокращенное наименование.
Внизу находится текст со ссылкой на пользовательское соглашение (ведет на https://yandex.ru/legal/practicum_termsofuse/ , открывается в вебвью).

Под текстом - кнопка оплаты, при ее нажатии посылается запрос на сервер. Если сервер ответил, что оплата прошла успешно, то показывается экран с информацией об этом и кнопкой возврата в корзину. В случае неуспешной оплаты показывается соответствующий экран с кнопками повтора запроса и возврата в корзину.

##Профиль

##Экран профиля
Экран показывает информацию о пользователе. Он содержит:
- фото пользователя;
- имя пользователя;
- описание пользователя;
- кнопку Мои NFT (ведет на экран NFT пользователя);
- кнопку Избранные NFT (ведет на экран с избранными NFT); 
- кнопку О разработчике (открывает в вебвью сайт пользователя).
В правом верхнем углу экрана находится кнопка редактирования профиля. Нажав на нее, пользователь видит всплывающий экран, на котором может отредактировать имя пользователя, описание, сайт и ссылку на изображение. Загружать само изображение через приложение не нужно, обновляется только ссылка на изображение. (пока не реализовано)

###Экран Мои NFT
Представляет собой таблицу, каждая ячейка которой содержит:
- иконку NFT;
- название NFT;
- автора NFT;
- цену NFT в ETH.
Сверху на экране есть кнопка сортировки, при нажатии на которую пользователю предлагается выбрать один из доступных способов сортировки. Содержимое таблицы упорядочивается согласно выбранному способу. (пока не реализоано)

В случае отсутствия NFT показывается соответствующая надпись. (пока не реализовано)

###Экран Избранные NFT
Содержит коллекцию c NFT, добавленными в избранное (лайкнутыми). Каждая ячейка содержит информацию об NFT:
- иконка;
- сердечко;
- название;
- рейтинг;
- цена в ETH.
Нажатие на сердечко удаляет NFT из избранного, содержимое коллекции при этом обновляется.

В случае отсутствия избранных NFT показывается соответствующая надпись. (пока не реализовано)

##Статистика

###Экран рейтинга
Экран отображает список пользователей. Он представляет собой таблицу. Для каждого пользователя указываются:
- место в рейтинге;
- аватарка;
- имя пользователя;
- количество NFT.
Сверху на экране есть кнопка сортировки, при нажатии на которую пользователю предлагается выбрать один из доступных способов сортировки. Содержимое таблицы упорядочивается согласно выбранному способу. (пока не реализовано)

При нажатии на одну из ячеек происходит переход на экран информации о пользователе. (пока не реализовано)

###Экран информации о пользователе
Экран отображает информацию о пользователе:
- фото пользователя;
- имя пользователя;
- описание пользователя.
- Также он содержит кнопку перехода на сайт пользователя (открывается в вебвью) и возможность перехода на экран Коллекции пользователя.

###Экран коллекции пользователя
Содержит коллекцию  c NFT пользователя. Каждая ячейка содержит информацию об NFT:
- иконка;
- сердечко;
- название;
- рейтинг;
- стоимость NFT (в ETH);
- кнопку добавления NFT в корзину / удаления NFT из корзины.

##Roadmap
- доделать имитацию покупки NFT
- реализовать изменение ссылки на аватар
- реализовать экран информации о пользователе
- реализовать экран коллекции пользователя
- реализовать аутентификацию
- выполнить рефакторинг
- сделать обработку ошибок (показывать алерт в местах, где это необходимо)
- во время загрузки картинок показывать анимацию - градиент
- обработать пустые списки (например, показывать сообщение "У вас еще нет избранных NFT")
- попробовать реализовать смену аватара (не просто менять ссылку, а попробовать загрузить файл)
- реализовать страницу просмотра NFT
