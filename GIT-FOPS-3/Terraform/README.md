#### Список игнорируемых файлов:

- все файлы заканчивающиеся на (*.tfstate), (*.tfvars), (*.tfvars.json), (*_override.tf), (*_override.tf.json)

- файлы с названиями: (crash.log), (override.tf), (override.tf), (.terraformrc), (terraform.rc)

- файлы в которых присутствуют следующие названия: (crash.*.log), (crash.*.log)

- где символ (*) означает любые буквы и цифры.

- файл key.json

#### Так же будет игнорироваться директория (**/.terraform/*)

<details>
<summary>Полный листинг</summary>

```
nva@Lenovo-G50-80:~/git$ git clone https://github.com/vanechaev/study.git
Клонирование в «study»…
remote: Enumerating objects: 645, done.
remote: Counting objects: 100% (230/230), done.
remote: Compressing objects: 100% (132/132), done.
remote: Total 645 (delta 140), reused 149 (delta 93), pack-reused 415
Получение объектов: 100% (645/645), 4.52 МиБ | 1.33 МиБ/с, готово.
Определение изменений: 100% (337/337), готово.
nva@Lenovo-G50-80:~/git$ ls
study
nva@Lenovo-G50-80:~/git$ cd study/
nva@Lenovo-G50-80:~/git/study$ git config --global Vladimir.Nechaev
nva@Lenovo-G50-80:~/git/study$ git config --global user.email nechaev.va@hotmail.com
nva@Lenovo-G50-80:~/git/study$ git config --global user.name "Vladimir Nechaev"
nva@Lenovo-G50-80:~/git/study$ git config --global core.editor nano
nva@Lenovo-G50-80:~/git/study$ git status
На ветке main
Ваша ветка обновлена в соответствии с «origin/main».

нечего коммитить, нет изменений в рабочем каталоге
nva@Lenovo-G50-80:~/git/study$ ls
README.md  SDB-12  SLRB-12  virt-23  VirtualBox_terst_30_10_2022_21_35_20.png
nva@Lenovo-G50-80:~/git/study$ nano README.md 
nva@Lenovo-G50-80:~/git/study$ git status
На ветке main
Ваша ветка обновлена в соответствии с «origin/main».

Изменения, которые не в индексе для коммита:
  (используйте «git add <файл>…», чтобы добавить файл в индекс)
  (используйте «git restore <файл>…», чтобы отменить изменения в рабочем каталоге)
        изменено:      README.md

нет изменений добавленных для коммита
(используйте «git add» и/или «git commit -a»)
nva@Lenovo-G50-80:~/git/study$ git diff
diff --git a/README.md b/README.md
index 0c57921..73bf373 100644
--- a/README.md
+++ b/README.md
@@ -1,2 +1,4 @@
 # study
+
 training-netology
+
nva@Lenovo-G50-80:~/git/study$ git diff --staged
nva@Lenovo-G50-80:~/git/study$ git status
На ветке main
Ваша ветка обновлена в соответствии с «origin/main».

Изменения, которые не в индексе для коммита:
  (используйте «git add <файл>…», чтобы добавить файл в индекс)
  (используйте «git restore <файл>…», чтобы отменить изменения в рабочем каталоге)
        изменено:      README.md

нет изменений добавленных для коммита
(используйте «git add» и/или «git commit -a»)
nva@Lenovo-G50-80:~/git/study$ git add README.md 
nva@Lenovo-G50-80:~/git/study$ git status
На ветке main
Ваша ветка обновлена в соответствии с «origin/main».

Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>…», чтобы убрать из индекса)
        изменено:      README.md

nva@Lenovo-G50-80:~/git/study$ git diff --staged
diff --git a/README.md b/README.md
index 0c57921..73bf373 100644
--- a/README.md
+++ b/README.md
@@ -1,2 +1,4 @@
 # study
+
 training-netology
+
nva@Lenovo-G50-80:~/git/study$ git diff
nva@Lenovo-G50-80:~/git/study$ nano .gitignore
nva@Lenovo-G50-80:~/git/study$ git status
На ветке main
Ваша ветка обновлена в соответствии с «origin/main».

Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>…», чтобы убрать из индекса)
        изменено:      README.md

Неотслеживаемые файлы:
  (используйте «git add <файл>…», чтобы добавить в то, что будет включено в коммит)
        .gitignore

nva@Lenovo-G50-80:~/git/study$ git add .gitignore 
nva@Lenovo-G50-80:~/git/study$ git status
На ветке main
Ваша ветка обновлена в соответствии с «origin/main».

Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>…», чтобы убрать из индекса)
        новый файл:    .gitignore
        изменено:      README.md

nva@Lenovo-G50-80:~/git/study$ mkdir GIT-FOPS-3
nva@Lenovo-G50-80:~/git/study$ cd GIT-FOPS-3/
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git commit -m 'First commit'
[main ee8bbd5] First commit
 2 files changed, 2 insertions(+)
 create mode 100644 .gitignore
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git status
На ветке main
Ваша ветка опережает «origin/main» на 1 коммит.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

нечего коммитить, нет изменений в рабочем каталоге
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git diff
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git diff --staged
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ mkdir Terraform
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ cd Terraform/
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ nano .gitignore
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ nano README.md
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ git status
На ветке main
Ваша ветка опережает «origin/main» на 1 коммит.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

Неотслеживаемые файлы:
  (используйте «git add <файл>…», чтобы добавить в то, что будет включено в коммит)
        ../

ничего не добавлено в коммит, но есть неотслеживаемые файлы (используйте «git add», чтобы отслеживать их)
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ ls
README.md
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ ls -la
итого 16
drwxrwxr-x 2 nva nva 4096 янв 25 09:37 .
drwxrwxr-x 3 nva nva 4096 янв 25 09:18 ..
-rw-rw-r-- 1 nva nva  884 янв 25 09:20 .gitignore
-rw-rw-r-- 1 nva nva  608 янв 25 09:37 README.md
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ git commit -m 'Added gitignore'
На ветке main
Ваша ветка опережает «origin/main» на 1 коммит.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

Неотслеживаемые файлы:
  (используйте «git add <файл>…», чтобы добавить в то, что будет включено в коммит)
        ../

ничего не добавлено в коммит, но есть неотслеживаемые файлы (используйте «git add», чтобы отслеживать их)
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ git add .gitignore 
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ git add README.md 
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ git status
На ветке main
Ваша ветка опережает «origin/main» на 1 коммит.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>…», чтобы убрать из индекса)
        новый файл:    .gitignore
        новый файл:    README.md

nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ git commit -m 'Added gitignore + readme'
[main a719824] Added gitignore + readme
 2 files changed, 45 insertions(+)
 create mode 100644 GIT-FOPS-3/Terraform/.gitignore
 create mode 100644 GIT-FOPS-3/Terraform/README.md
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3/Terraform$ cd ..
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ nano will_be_deleted.txt
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ nano will_be_moved.txt
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git status
На ветке main
Ваша ветка опережает «origin/main» на 2 коммита.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

Неотслеживаемые файлы:
  (используйте «git add <файл>…», чтобы добавить в то, что будет включено в коммит)
        will_be_deleted.txt
        will_be_moved.txt

ничего не добавлено в коммит, но есть неотслеживаемые файлы (используйте «git add», чтобы отслеживать их)
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git add will_be_deleted.txt will_be_moved.txt 
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git status
На ветке main
Ваша ветка опережает «origin/main» на 2 коммита.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>…», чтобы убрать из индекса)
        новый файл:    will_be_deleted.txt
        новый файл:    will_be_moved.txt

nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git commit -m 'Prepare to delete and move'
[main 479e723] Prepare to delete and move
 2 files changed, 2 insertions(+)
 create mode 100644 GIT-FOPS-3/will_be_deleted.txt
 create mode 100644 GIT-FOPS-3/will_be_moved.txt
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ del
delgroup  delpart   deluser   delv      
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ del
delgroup  delpart   deluser   delv      
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git rm 
Terraform/           will_be_deleted.txt  will_be_moved.txt    
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git rm will_be_deleted.txt 
rm 'GIT-FOPS-3/will_be_deleted.txt'
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git status
На ветке main
Ваша ветка опережает «origin/main» на 3 коммита.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>…», чтобы убрать из индекса)
        удалено:       will_be_deleted.txt

nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git mv will_be_moved.txt has_been_moved.txt
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git status
На ветке main
Ваша ветка опережает «origin/main» на 3 коммита.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>…», чтобы убрать из индекса)
        переименовано: will_be_moved.txt -> has_been_moved.txt
        удалено:       will_be_deleted.txt

nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git commit -m 'Moved and deleted'
[main bacd153] Moved and deleted
 2 files changed, 1 deletion(-)
 rename GIT-FOPS-3/{will_be_moved.txt => has_been_moved.txt} (100%)
 delete mode 100644 GIT-FOPS-3/will_be_deleted.txt
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git status
На ветке main
Ваша ветка опережает «origin/main» на 4 коммита.
  (используйте «git push», чтобы опубликовать ваши локальные коммиты)

нечего коммитить, нет изменений в рабочем каталоге
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git log
commit bacd153711b8fdf6b2f8b573392d419b59ea7350 (HEAD -> main)
Author: Vladimir Nechaev <nechaev.va@hotmail.com>
Date:   Wed Jan 25 09:59:33 2023 +0300

    Moved and deleted

commit 479e723aec4240534b4306e30bb69aff758ffadd
Author: Vladimir Nechaev <nechaev.va@hotmail.com>
Date:   Wed Jan 25 09:49:00 2023 +0300

    Prepare to delete and move

commit a71982480be89cc6d5bec87b6c4ecfd7f3b4120a
Author: Vladimir Nechaev <nechaev.va@hotmail.com>
Date:   Wed Jan 25 09:41:58 2023 +0300

    Added gitignore + readme

commit ee8bbd5c2a5110be3eb2d2532e113417705a7bdb
Author: Vladimir Nechaev <nechaev.va@hotmail.com>
Date:   Wed Jan 25 09:17:07 2023 +0300

    First commit

commit 99c2333468ba77e5491f6524e89f8a4aa1fdfd22 (origin/main, origin/HEAD)
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Wed Jan 18 14:40:21 2023 +0300

    Update 03-virt-docker.md

commit 9d8cd76bbc9078f979c3fbb3c6336f799f6552d1
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Wed Jan 18 10:09:51 2023 +0300

    Update 02-virt-iaac.md

commit 1ca78a1501b8ff27f831665f6d0fb251dff417e2
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Wed Jan 18 10:08:14 2023 +0300

    Update 02-virt-iaac.md

commit ee3c2b6c5f0d69bb1f9ccb41bbae98a458f3378a
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Tue Jan 17 13:31:52 2023 +0300

    Update 02-virt-iaac.md

commit cbc126d5f59c935a12408534b8e56b36242cccb3
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Tue Jan 17 10:18:01 2023 +0300

    Update 03-virt-docker.md

commit 59189c07c0134421a7251b1d64a384e65860c9dc
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Tue Jan 17 09:48:32 2023 +0300

    Create 03-virt-docker.md

commit f3b8fb3bc55d5d7fa77a1fe873f8604b1bbca2b4
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Jan 15 16:21:31 2023 +0300

    Update 02-virt-iaac.md

commit c3a5858bab21d84d23785c31f1a9d32c4dbb6ea8
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Jan 15 15:24:11 2023 +0300

    Update 01-virt-basics.md

commit ea494b4b45d8612c576b75ee5a131238d6e06289
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Jan 15 14:26:57 2023 +0300

    Update 01-virt-basics.md

commit c57fbe3187e9dd4a0f2e79f8854dbfe9ab109817
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Jan 15 13:32:05 2023 +0300

    Create 02-virt-iaac.md

commit 8ee880e58fb570f775db8760b475fa513cd504c4
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Jan 15 13:26:33 2023 +0300

    Create 01-virt-basics.md

commit 95211d294c7fd7431acf1a37b94eafd0a7854a65
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 16:13:18 2022 +0300

    Rename 12.09 "Базы данных в облаке".md to 12.9 "Базы данных в облаке".md

commit 67506cc9bf504c363f761f64896fe8ffaca34fe0
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 16:12:36 2022 +0300

    Create 12.09 "Базы данных в облаке".md

commit f6e7062cae50f762faff993444e6f211fd60db4e
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 16:09:33 2022 +0300

    Update 12.8 "Резервное копирование баз данных".md

commit d56dc962fd215994d2cd6bdcbd100dfed106f55d
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 14:48:47 2022 +0300

    Create 12.8 "Резервное копирование баз данных".md

commit 4367a7872cdd1c217f3ae681a8e08d9b8c934c69
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 14:41:26 2022 +0300

    Update 12.7 "Репликация и масштабирование. Часть 2".md

commit 0c14398ba67e392807ccbb3df39375e4ea9336a0
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 14:37:28 2022 +0300

    G

commit 171da13c2ccff89a767470913aa016210bec38bd
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 14:36:59 2022 +0300

    Delete G_Screenshot_20221216_142736.png

commit 6ead257b194743c1eb9a650c39b5f210029f7ef6
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 14:31:12 2022 +0300

    V

commit 73f32163e5beaadbf335fa5bc856c868fa200661
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 14:30:31 2022 +0300

    G

commit f8df20fa6cc28112e2e605343bbd4479e31dba15
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 13:25:05 2022 +0300

    Delete изображение_2022-12-16_131300750.png

commit 697a122f8fef2a81df7647425f97cfdc7a2944d5
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 13:13:54 2022 +0300

    горизонтальный
    
    горизонтальный

commit 4918d62c633a2e0af7cb86e08b24090e39de47ef
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 13:12:48 2022 +0300

    Create img

commit a8f8b8b4477015bf1fe9a13a619d5e4150481194
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 12:27:35 2022 +0300

    Update 12.7 "Репликация и масштабирование. Часть 2".md

commit 52f67046b7521b763a7ee1c3d0b182ffe22a251e
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Fri Dec 16 11:17:36 2022 +0300

    Create 12.7 "Репликация и масштабирование. Часть 2".md

commit 0bd53c11c2ce517cbb5434e662bf73f12b79fb42
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Thu Dec 8 15:14:41 2022 +0300

    Update 12.5 "Реляционные базы данных: Индексы".md

commit af08b089c3e371712f5e62e151a68cb240df2726
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Thu Dec 8 15:03:09 2022 +0300

    Update 12.5 "Реляционные базы данных: Индексы".md

commit d5eef0e27be5db0a5e0b30e687ceeac75aedd932
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Thu Dec 8 11:58:40 2022 +0300

    Update 12.5 "Реляционные базы данных: Индексы".md

commit ce7b9d9ee87b70e063dab747962d1b86caccfb83
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Wed Dec 7 15:44:29 2022 +0300

    Update 12.6 "Репликация и масштабирование. Часть 1".md

commit 4cb9568ed614da04487afc94a42c3b36ef82dfd9
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Wed Dec 7 15:37:56 2022 +0300

    Update 12.6 "Репликация и масштабирование. Часть 1".md

commit da39e6492a534f973b5e4f7a2c18230e10d46efd
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Wed Dec 7 15:19:29 2022 +0300

    Update 12.6 "Репликация и масштабирование. Часть 1".md

commit 0d3ac826861757d68ed3ddc12008b08c0e4414c9
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Wed Dec 7 15:19:01 2022 +0300

    Add files via upload
    
    master-3*

commit 21ed99e2081801e07f08fd516d7341155fe3dd35
...skipping...

    Update 11.1 "Базы данных, их типы".md

commit 040c71e37ad84d95365ee4b10bdf3a0fe28729f3
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Oct 30 18:00:41 2022 +0300

    Update 11.1 "Базы данных, их типы".md

commit 1eafbb48d0a6c39cf483e6160dd63e16c6ce1353
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Oct 30 15:31:44 2022 +0300

    Rename 11.1 "Базы данных, их типы.md to 11.1 "Базы данных, их типы".md

commit 1d8817400f73856b2ab7c602b6e8ec162c413489
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sun Oct 30 15:30:03 2022 +0300

    Create 11.1 "Базы данных, их типы.md

commit 036b51c5af9d176b3f2e4a96c026cf28d756f794
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sat Oct 29 13:31:37 2022 +0300

    Rename 11.2 "Кеширование Redis-memcached" to 11.2 "Кеширование Redis-memcached".md

commit 04e439afd43df467eba8392613513b05cde22695
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sat Oct 29 13:29:32 2022 +0300

    Create 11.2 "Кеширование Redis-memcached"

commit 5188f19a7c5d244581e30d7a5b24e7d73302e341
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sat Oct 29 13:27:36 2022 +0300

    Delete DBD-12 directory

commit e69c5b284f2691aa658f990470e5fbd59008c7bf
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sat Oct 29 13:25:45 2022 +0300

    Create 11.2 "Кеширование Redis-memcached"

commit 01c75fac8ecb92f0351fcea9d78bcd0be9bb8326
Author: Nechaev Vladimir Alekseevich <111578816+vanechaev@users.noreply.github.com>
Date:   Sat Oct 29 11:57:55 2022 +0300

    Initial commit

nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ git push
Username for 'https://github.com': vanechaev
Password for 'https://vanechaev@github.com': 
Перечисление объектов: 20, готово.
Подсчет объектов: 100% (20/20), готово.
При сжатии изменений используется до 4 потоков
Сжатие объектов: 100% (13/13), готово.
Запись объектов: 100% (18/18), 2.24 КиБ | 1.12 МиБ/с, готово.
Всего 18 (изменений 3), повторно использовано 0 (изменений 0), повторно использовано пакетов 0
remote: Resolving deltas: 100% (3/3), done.
To https://github.com/vanechaev/study.git
   99c2333..bacd153  main -> main
nva@Lenovo-G50-80:~/git/study/GIT-FOPS-3$ 
```
</details>
