import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/layanan.dart';
import '../cubit/favorit_cubit.dart';
class LayananPage extends StatelessWidget {
 const LayananPage({super.key});
 @override Widget build(BuildContext context)=>DefaultTabController(length:3,child:Column(children:[const TabBar(isScrollable:true,tabs:[Tab(text:'Perizinan'),Tab(text:'Kesehatan'),Tab(text:'Transportasi')]),Expanded(child:TabBarView(children:['Perizinan','Kesehatan','Transportasi'].map((bidang)=>ListView(padding:const EdgeInsets.all(16),children:daftarLayanan.where((l)=>l.bidang==bidang).map((l)=>LayananCard(layanan:l)).toList())).toList()))]));
}
class LayananCard extends StatelessWidget {
 final Layanan layanan;
 const LayananCard({super.key,required this.layanan});
 @override Widget build(BuildContext context)=>Card(child:ListTile(title:Text(layanan.nama),subtitle:Text(layanan.bidang),onTap:() async {
 final result=await Navigator.pushNamed<String>(context,'/detail',arguments:layanan);
 if(!context.mounted||result==null) return;
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('$result ditambahkan ke pengajuan')));
 },trailing:BlocSelector<FavoritCubit,Set<String>,bool>(selector:(state)=>state.contains(layanan.nama),builder:(context,favorit)=>IconButton(tooltip:favorit?'Batalkan favorit ${layanan.nama}':'Favoritkan ${layanan.nama}',icon:Icon(favorit?Icons.star:Icons.star_border,color:Theme.of(context).colorScheme.primary),onPressed:(){final c=context.read<FavoritCubit>();favorit?c.batalTandai(layanan.nama):c.tandai(layanan.nama);}))));
}

