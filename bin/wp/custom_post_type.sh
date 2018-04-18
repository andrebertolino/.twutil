cpt_config()
{
    echo ""
    echo -e "\033[01;34mNome do CPT:\033[00;37m"
    read cpt_general_name
    cpt_general_name_slug="$(echo -n "${cpt_general_name}" | sed -e 's/[^[:alnum:]]/_/g' | iconv -f utf8 -t ascii//TRANSLIT | sed -e 's/[^_[:alnum:]]//g' | tr -s '-' | tr A-Z a-z)"
    echo ""
    echo -e "\033[01;34mNome do CPT no singular:\033[00;37m"
    read cpt_singular_name
    cpt_singular_name_slug="$(echo -n "${cpt_singular_name}" | sed -e 's/[^[:alnum:]]/_/g' | iconv -f utf8 -t ascii//TRANSLIT | sed -e 's/[^_[:alnum:]]//g' | tr -s '-' | tr A-Z a-z)"
    echo ""
    echo -e "\033[01;34mEscolha os suportes deste CPT:\033[00;37m"
    echo -e "\033[00;34m'supports' => array('title', 'editor', 'author', 'thumbnail', 'excerpt', 'trackbacks', 'custom-fields', 'comments', 'revisions', 'page-attributes', 'post-formats')\033[00;37m"
    echo -e "\033[01;33mExemplo: 'title', 'editor', 'thumbnail'\033[00;37m"
    read cpt_supports
}

cpt_write_file()
{
    cat <<- _EOF_
    <?php // create custom post type ${cpt_general_name_slug}
    add_action('init', 'twp_register_cpt_${cpt_general_name_slug}');
    function twp_register_cpt_${cpt_general_name_slug}()
    {
        \$labels = array(
            'name' => '${cpt_general_name}',
            'singular_name' => '${cpt_singular_name}',
            'add_new' => 'Adicionar novo',
            'add_new_item' => 'Adicionar novo',
            'edit_item' => 'Editar item',
            'new_item' => 'Novo item',
            'view_item' => 'Ver item',
            'search_items' => 'Pesquisar',
            'not_found' => 'Nada encontrado',
            'not_found_in_trash' => 'Nada encontrado no lixo',
        );
        \$capabilities = array(
            'read_post' => 'read_${cpt_singular_name_slug}',
            'read_private_posts' => 'read_private_${cpt_general_name_slug}',
            'edit_post' => 'edit_${cpt_singular_name_slug}',
            'edit_posts' => 'edit_${cpt_general_name_slug}',
            'edit_others_posts' => 'edit_others_${cpt_general_name_slug}',
            'delete_post' => 'delete_${cpt_singular_name_slug}',
            'delete_posts' => 'delete_${cpt_general_name_slug}',
            'delete_others_posts' => 'delete_others_${cpt_general_name_slug}',
            'publish_posts' => 'publish_${cpt_general_name_slug}',
            'create_posts' => 'create_${cpt_singular_name_slug}',
        );
        \$args = array(
            'labels' => \$labels,
            'public' => true,
            'publicly_queryable' => true,
            'show_ui' => true,
            'query_var' => true,
            'rewrite' => true,
            'has_archive' => true, // Abilitando o uso do template de arquivo o archive-shopping.php
            'capability_type' => '${cpt_general_name_slug}',
            'capabilities' => \$capabilities,
            'hierarchical' => false,
            'rewrite' => array('slug' => '${cpt_general_name_slug}'), // Ex: http://localhost/site/${cpt_general_name_slug}
            'menu_position' => 100,
            'supports' => array($cpt_supports),
        );
        register_post_type('${cpt_general_name_slug}', \$args);
    }

    // add user capabilities admin
    add_action('admin_init', 'add_admin_caps_${cpt_general_name_slug}');
    function add_admin_caps_${cpt_general_name_slug}()
    {
        \$role = get_role('administrator');
        \$role->add_cap('read_${cpt_singular_name_slug}');
        \$role->add_cap('read_private_${cpt_general_name_slug}');
        \$role->add_cap('edit_${cpt_singular_name_slug}');
        \$role->add_cap('edit_${cpt_general_name_slug}');
        \$role->add_cap('edit_others_${cpt_general_name_slug}');
        \$role->add_cap('delete_${cpt_singular_name_slug}');
        \$role->add_cap('delete_${cpt_general_name_slug}');
        \$role->add_cap('delete_others_${cpt_general_name_slug}');
        \$role->add_cap('publish_${cpt_general_name_slug}');
        \$role->add_cap('create_${cpt_singular_name_slug}');
    }
    

    // wordpress user capabilities
    add_filter('map_meta_cap', '${cpt_singular_name_slug}_map_meta_cap', 10, 4);
    function ${cpt_singular_name_slug}_map_meta_cap(\$caps, \$cap, \$user_id, \$args)
    {
        if ('edit_${cpt_singular_name_slug}' == \$cap || 'delete_${cpt_singular_name_slug}' == \$cap || 'read_${cpt_singular_name_slug}' == \$cap) {
            \$post = get_post(\$args[0]);
            \$post_type = get_post_type_object(\$post->post_type);
            \$caps = array();
        }
        if ('edit_${cpt_singular_name_slug}' == \$cap) {
            if (\$user_id == \$post->post_author) {
                \$caps[] = \$post_type->cap->edit_posts;
            } else {
                \$caps[] = \$post_type->cap->edit_others_posts;
            }

        } elseif ('delete_${cpt_singular_name_slug}' == \$cap) {
            if (\$user_id == \$post->post_author) {
                \$caps[] = \$post_type->cap->delete_posts;
            } else {
                \$caps[] = \$post_type->cap->delete_others_posts;
            }

        } elseif ('read_${cpt_singular_name_slug}' == \$cap) {
            if ('private' != \$post->post_status) {
                \$caps[] = 'read';
            } elseif (\$user_id == \$post->post_author) {
                \$caps[] = 'read';
            } else {
                \$caps[] = \$post_type->cap->read_private_posts;
            }

        }
        return \$caps;
    }
_EOF_
}

# MAIN
custom_post_type()
{
    echo ""
    echo -e "\033[01;34mDeseja criar um CPT neste diretório?\033[00;37m"
    pwd
    echo -e "\033[01;34m(y/n)?\033[00;37m"
    read cpt_quest
    if [ "$cpt_quest" = "y" ]
    then
        echo ""
        cpt_config
        filename=$(pwd)/cpt_${cpt_general_name_slug}.php
        cpt_file_existe=
        if [ -f $filename ]; then
            echo ""
            echo -e "\033[01;34mO arquivo cpt_${cpt_general_name_slug}.php já exite. Deseja substituí-lo? (y/n)\033[00;37m"
            read cpt_file_existe
            if [ "$cpt_file_existe" != "y" ]; then
                echo -e '\033[01;31mA criação do CPT foi cancelada.\033[00;37m'
                exit 1
            fi
        fi
        cpt_write_file > $filename
        echo ""
        echo -e "\033[01;32mO arquivo cpt_${cpt_general_name_slug}.php foi criado com sucesso!\033[00;37m"
        echo ""
        echo -e "\033[01;37mAdicione o código abaixo no seu arquivo functions.php\033[00;37m"
        echo -e "\033[00;37minclude_once (sprintf('%s/path/cpt_${cpt_general_name_slug}.php', get_template_directory()));\033[00;37m"
        echo ""
    else
        echo -e '\033[01;31mPor favor acesse o diretório correto e execute novamente a função.\033[00;37m'
    fi
}