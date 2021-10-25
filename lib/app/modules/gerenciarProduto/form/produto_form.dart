import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/modules/gerenciarProduto/components/custom_text_field.dart';
import 'package:catalogo/app/modules/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as urlValida;

class ProdutoFormulario extends StatefulWidget {
  @override
  State<ProdutoFormulario> createState() => _ProdutoFormularioState();
}

class _ProdutoFormularioState
    extends ModularState<ProdutoFormulario, GerenciadorProdutoController> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formData = Produto();
  var _itemSelecionado;

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    try {
      await controller.service.repositoryProduto.save(_formData);
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o produto.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            )
          ],
        ),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    String label;
    String descText;
    int line;
    int tamanho;

    dropDownItemSelected(String novoItem) {
      setState(() {
        _itemSelecionado = novoItem;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Formulário Produto')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Divider(),
              CustomTextField(
                  label: 'Nome do Produto',
                  descText: 'Digite o nome do Produto...',
                  onSaved: (name) => _formData.name = name ?? '',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'O campo não pode ser nulo';
                    }
                    if (text.length < 4) {
                      return 'O campo deve ter no mínimo 4 caracteres';
                    }
                  }),
              Divider(),
              CustomTextField(
                  label: 'Descrição',
                  descText: 'Digite uma descrição...',
                  line: 3,
                  tamanho: 250,
                  onSaved: (description) =>
                      _formData.description = description ?? '',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'O campo não pode ser nulo';
                    }
                    if (text.length < 4) {
                      return 'O campo deve ter no mínimo 4 caracteres';
                    }
                  }),
              Divider(),
              CustomTextField(
                  label: 'Valor',
                  descText: 'Digite o valor..',
                  onSaved: (price) =>
                      _formData.price = double.parse(price ?? '0.0'),
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
              Divider(),
              CategoriaDropDownInput<String>(
                onSaved: (category) =>
                    _formData.categoryId = int.parse(_itemSelecionado),
                hintText: "Selecione Categoria",
                options: ['1', '2'],
                value: _itemSelecionado,
                onChanged: (category) {
                  dropDownItemSelected(category!);
                  setState(() {
                    _itemSelecionado = category;
                    // state.didChange(newValue);
                  });
                },
                getLabel: (category) => category,
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _imageUrlController,
                      label: 'URL da imagem',
                      descText: 'Cole a URL da imagem...',
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocus,
                      onSaved: (imageUrl) => _formData.photo = imageUrl ?? '',
                      textInputAction: TextInputAction.done,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'O campo não pode ser nulo';
                        }
                        if (!urlValida.isURL(text)) {
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
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a Url')
                        : Image.network(_imageUrlController.text),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: Icon(Icons.save),
                      label: Text('Salvar')),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
