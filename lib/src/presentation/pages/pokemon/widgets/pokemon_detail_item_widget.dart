import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mdp_pokedex_app/src/domain/models/models.dart';
import 'package:mdp_pokedex_app/src/presentation/pages/pages.dart';
import 'package:mdp_pokedex_app/src/presentation/widgets/widgets.dart';
import 'package:mdp_pokedex_app/src/presentation/common/helpers/helpers.dart';
import 'package:mdp_pokedex_app/src/presentation/common/constants/constants.dart';

class PokemonDetailItemWidget extends StatefulWidget {
  const PokemonDetailItemWidget({
    super.key,
    required this.pokemon,
  });

  final PokemonFull pokemon;

  @override
  State<PokemonDetailItemWidget> createState() => _PokemonDetailItemWidgetState();
}

class _PokemonDetailItemWidgetState extends State<PokemonDetailItemWidget> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = PokemonHelper.formatColor(widget.pokemon.types[0].type.name);
    return ContainerWidget(
      color: color,
      child: SafeArea(
        child: Stack(
          children: [
            _getImagePokeball(context),
            _getContentPokemon(context, color),
          ],
        ),
      ),
    );
  }

  Widget _getContentPokemon(BuildContext context, Color color) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          _getHeaderDetail(context),
          _getBodyDetail(color, context),
        ],
      ),
    );
  }

  Widget _getBodyDetail(Color color, context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _getInfoDetail(color, context),
            Positioned(
              top: size.height * 0.1,
              child: SizedBox(
                width: size.width * 0.55,
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/ball.gif'),
                  image: NetworkImage(PokemonHelper.formatImage(widget.pokemon.id.toString())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getInfoDetail(Color color, context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(child: Container(),),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(widget.pokemon.id > 1)
                CupertinoButton(
                  onPressed: (){
                    if(widget.pokemon.id > 1){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailPage(id: widget.pokemon.id - 1),
                        ),
                      );
                    }
                  },
                  minSize: 0,
                  padding: EdgeInsets.zero,
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
                ),
              if(widget.pokemon.id == 1)
                Container(),
              CupertinoButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonDetailPage(id: widget.pokemon.id + 1),
                    ),
                  );
                },
                minSize: 0,
                padding: EdgeInsets.zero,
                child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 1,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ],
          ),
          child: Column(
            children: [
              Wrap(
                spacing: 16,
                children: widget.pokemon.types.map((type) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PokemonHelper.formatColor(type.type.name),
                  ),
                  child: TextWidget(
                    text: PokemonHelper.formatCapitalizeName(type.type.name),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )).toList(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextWidget(text: 'About', color: color, fontWeight: FontWeight.bold, fontSize: 14)
              ),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(Icons.percent),
                                SvgPicture.asset(
                                  'assets/images/weight.svg',
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 8),
                                TextWidget(text: '${widget.pokemon.weight} kg',color: AppColors.textInput)
                              ],
                            ),
                          ),
                          const TextWidget(text: 'Weight',color: AppColors.textLabelCard, fontSize: 8)
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.divider,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/straighten.svg',
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 8),
                                TextWidget(text: '${widget.pokemon.height} m',color: AppColors.textInput)
                              ],
                            ),
                          ),
                          const TextWidget(text: 'Height',color: AppColors.textLabelCard, fontSize: 8)
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.divider,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Column(
                              children: [
                                TextWidget(text: widget.pokemon.moves[0].move.name,color: AppColors.textInput),
                                const SizedBox(height: 7),
                                TextWidget(text: widget.pokemon.moves[1].move.name,color: AppColors.textInput)
                              ],
                            ),
                          ),
                          const TextWidget(text: 'Moves',color: AppColors.textLabelCard, fontSize: 8)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: const TextWidget(
                  text: 'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.',
                  color: AppColors.textTitleCard,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  height: 1.6,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextWidget(text: 'Base Stats', color: color, fontWeight: FontWeight.bold, fontSize: 14)
              ),
              SizedBox(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: widget.pokemon.stats.map((stat){
                        return TextWidget(
                          text: PokemonHelper.formatNameStat(stat.stat.name),
                          color: color,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                        );
                      })
                      .toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 1,
                      height: 96,
                      color: AppColors.divider,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: widget.pokemon.stats.map((stat){
                        return TextWidget(
                          text: stat.baseStat.toString(),
                          color: AppColors.textTitleCard,
                          textAlign: TextAlign.right,
                          height: 1.6,
                        );
                      })
                      .toList(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: widget.pokemon.stats.map((stat){
                          int score = stat.baseStat;
                          double maxWidth = size.width - 16;
                          double width = (score / 400) * maxWidth;

                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                height: 4,
                                // width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: color.withOpacity(0.2),
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (BuildContext context, Widget? child) {
                                  final animatedWidth = _animation.value * width;
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 6),
                                    width: animatedWidth.isFinite ? animatedWidth : 0,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: color,
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        })
                        .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getImagePokeball(context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/images/pokeball.svg',
            height: size.height * 0.3,
            color: Colors.white.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Padding _getHeaderDetail(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,20,20,24),
      child: Row(
        children: [
          CupertinoButton(
            minSize: 0,
            padding: const EdgeInsets.only(right: 8),
            onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white,size: 32),
          ),
          Expanded(
            child: SizedBox(
              child: TextWidget(
                text: PokemonHelper.formatCapitalizeName(widget.pokemon.name.toString()),
                fontSize: 24,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.bold,
              )
            )
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: TextWidget(
              text: PokemonHelper.formatIdNumber(widget.pokemon.id.toString()),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );
  }
}
