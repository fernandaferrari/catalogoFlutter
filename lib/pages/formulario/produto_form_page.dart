// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:string_validator/string_validator.dart' as url_valida;

import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/formulario/produto_form_controller.dart';

import 'components/custom_text_field.dart';

class ProdutoFormulario extends StatefulWidget {
  final Produto? produto;
  const ProdutoFormulario({
    Key? key,
    required this.produto,
  }) : super(key: key);

  @override
  State<ProdutoFormulario> createState() => _ProdutoFormularioState();
}

class _ProdutoFormularioState
    extends ModularState<ProdutoFormulario, ProdutoFormController> {
  // ignore: prefer_typing_uninitialized_variables
  var itemSelecionado;

  final imageUrlController = TextEditingController();
  final imageUrlFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  var formData = Produto();

  @override
  void initState() {
    super.initState();
    imageUrlController.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (formData.id == null) {
      var arg = widget.produto;

      if (arg != null) {
        formData.name = arg.name;
        formData.id = arg.id;
        formData.price = arg.price;
        formData.description = arg.description;
        formData.photo = arg.photo;
        imageUrlController.text = arg.photo.toString();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    imageUrlFocus.removeListener(updateImage);
    imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  Future<void> _submitForm() async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    formKey.currentState?.save();

    try {
      controller.save(produto: formData);
      formData = Produto();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto salvo com sucesso!'),
          duration: Duration(seconds: 5),
        ),
      );
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro para salvar o produto.'),
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.canPop();
              },
              child: const Text('Erro'),
            )
          ],
        ),
      );
    } finally {
      Modular.to.pushNamed("/gerenciar/");
    }
  }

  @override
  Widget build(BuildContext context) {
    dropDownItemSelected(String novoItem) {
      setState(() {
        itemSelecionado = novoItem;
      });
    }

    List<String>? categoria = controller.categoria() ?? [""];

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Formulário Produto')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const Divider(),
              CustomTextField(
                  key: const Key("nome"),
                  initialValue: (formData.name),
                  label: 'Nome do Produto',
                  descText: 'Digite o nome do Produto...',
                  onSaved: (name) => formData.name = name ?? '',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'O campo não pode ser nulo';
                    }
                    if (text.length < 4) {
                      return 'O campo deve ter no mínimo 4 caracteres';
                    }
                  }),
              const Divider(),
              CustomTextField(
                  key: const Key("descricao"),
                  initialValue: (formData.description),
                  label: 'Descrição',
                  descText: 'Digite uma descrição...',
                  line: 3,
                  tamanho: 1000,
                  onSaved: (description) =>
                      formData.description = description ?? '',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'O campo não pode ser nulo';
                    }
                    if (text.length < 4) {
                      return 'O campo deve ter no mínimo 4 caracteres';
                    }
                  }),
              const Divider(),
              CustomTextField(
                  key: const Key("valor"),
                  initialValue: (formData.price).toString() == 'null'
                      ? ''
                      : (formData.price).toString(),
                  label: 'Valor',
                  descText: 'Digite o valor..',
                  onSaved: (price) =>
                      formData.price = double.parse(price ?? '0.0'),
                  keyboardType: TextInputType.number,
                  validator: (_price) {
                    final priceString = _price ?? '-1';
                    final price = double.tryParse(priceString) ?? -1;
                    if (_price == null || _price.isEmpty) {
                      return 'O campo não pode ser nulo';
                    }

                    if (price < 0) {
                      return 'Informe um preço válido.';
                    }
                  }),
              const Divider(),
              CategoriaDropDownInput<String>(
                key: const Key("cats"),
                onSaved: (category) {
                  var teste = controller.buscaCategoria(itemSelecionado);
                  formData.categoryId = int.parse(teste);
                },
                hintText: "Selecione Categoria",
                options: categoria,
                value: itemSelecionado,
                onChanged: (category) {
                  dropDownItemSelected(category!);
                  setState(() {
                    itemSelecionado = category;
                  });
                },
                getLabel: (category) => category,
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextField(
                      key: const Key("imagem"),
                      controller: imageUrlController,
                      label: 'URL da imagem',
                      descText: 'Cole a URL da imagem...',
                      keyboardType: TextInputType.url,
                      focusNode: imageUrlFocus,
                      onSaved: (imageUrl) => formData.photo = imageUrl ?? '',
                      textInputAction: TextInputAction.done,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'O campo não pode ser nulo';
                        }
                        if (!url_valida.isURL(text)) {
                          return 'Insira uma url válida';
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: imageUrlController.text.isEmpty
                        ? const Text('Informe a Url')
                        : Image.network(imageUrlController.text),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      key: const Key("save"),
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                        fontSize: 18,
                      )),
                      onPressed: () {
                        _submitForm();
                      },
                      child: const Text('Salvar'),
                    ),
                  );
                })
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
