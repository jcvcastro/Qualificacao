% set(figureHandle, 'Units', 'inch')
caminho = './figs/';
nome = 'Figura_';
h =  findobj('type','figure');
nf = length(h);
   tam1 = [10 5]
   tam = [10 5];
for i=1:nf
   nomeFig = [nome num2str(i) '.tex'];
   % nomeCompleto = [caminho nomeFig];
   % fig=gcf;                                     % your figure
   hi=figure(i);
   set(hi,...
    'Units','inch',...
    'PaperPosition',[0 0 tam],...
    'PaperSize',tam1);
);
%    saveas(gcf, nomeFig)
end
% for i=1:nf
%    system(['pdf-crop-margins ' nome num2str(i) '.pdf'])
%    system(['mv ' nome  num2str(i) '_cropped.pdf ' caminho]);
% end
%%
   hi=gcf;
   tam = [1 1];
   set(hi,...   
    'Units','centimeters',...
    'PaperPosition',[0 0 tam],...
    'PaperSize',tam1);
%    saveas(gcf, nomeFig)
matlab2tikz([caminho 'teste2.tex']);