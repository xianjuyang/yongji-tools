$f = "$PSScriptRoot\ket-vocabulary.html"
$utf8 = [System.Text.UTF8Encoding]::new($false)
$sw = [System.IO.StreamWriter]::new($f, $false, $utf8)

# ====== PART 1: HTML + CSS ======
$sw.Write(@'
<!DOCTYPE html><html lang="zh-CN"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
<meta name="apple-mobile-web-app-capable" content="yes"><meta name="apple-mobile-web-app-title" content="KET词汇">
<meta name="theme-color" content="#1a6b5a"><title>永汲教育 · KET词汇训练</title>
<style>
:root{--pri:#1a6b5a;--pri-light:#e8f5f0;--pri-dark:#0f4a3e;--bg:#f8fafb;--card:#fff;--text:#1e293b;--muted:#94a3b8;--border:#e5e7eb;--radius:10px;--shadow:0 1px 3px rgba(0,0,0,.06);--red:#dc2626;--green:#16a34a;--amber:#d97706}
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'PingFang SC','Microsoft YaHei',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
.topbar{background:var(--card);border-bottom:1px solid var(--border);padding:0 14px;height:50px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;box-shadow:var(--shadow)}
.topbar .brand{display:flex;align-items:center;gap:8px;font-size:15px;font-weight:700;color:var(--pri-dark)}
.topbar .brand .dot{width:27px;height:27px;border-radius:6px;background:var(--pri);display:flex;align-items:center;justify-content:center;color:#fff;font-size:14px;font-weight:800}
.btn{padding:7px 13px;border-radius:6px;border:none;font-size:12px;font-weight:600;cursor:pointer;font-family:inherit;transition:all .15s;white-space:nowrap}
.btn-pri{background:var(--pri);color:#fff}.btn-pri:hover{background:var(--pri-dark)}
.btn-outline{background:#fff;color:var(--pri);border:1.5px solid var(--pri)}.btn-outline:hover{background:var(--pri-light)}
.btn-sm{padding:5px 10px;font-size:11px}
.layout{display:flex;height:calc(100vh - 50px)}
.sidebar{width:250px;min-width:250px;background:var(--card);border-right:1px solid var(--border);display:flex;flex-direction:column;overflow:hidden}
.sidebar-head{padding:10px 12px;border-bottom:1px solid var(--border)}
.sidebar-head input{width:100%;padding:7px 9px;border:1.5px solid var(--border);border-radius:7px;font-size:12px;font-family:inherit;outline:none;background:#f9fafb}
.sidebar-head input:focus{border-color:var(--pri);background:#fff}
.sidebar-list{flex:1;overflow-y:auto;padding:4px}
.unit-label{font-size:10px;font-weight:700;color:var(--muted);padding:8px 10px 3px;letter-spacing:.5px}
.topic-item{padding:9px 10px;border-radius:6px;cursor:pointer;font-size:11px;font-weight:500;transition:all .1s;margin-bottom:1px;display:flex;justify-content:space-between;align-items:center}
.topic-item:hover{background:#f1f5f9}
.topic-item.active{background:var(--pri-light);color:var(--pri-dark);font-weight:700}
.topic-item.done .check{display:inline}
.topic-item .check{font-size:10px;display:none}
.topic-item .num{font-size:10px;color:var(--muted);margin-right:4px}
.main{flex:1;overflow-y:auto;padding:16px 20px;display:flex;flex-direction:column;gap:14px}
.passage-card{background:var(--card);border-radius:var(--radius);box-shadow:var(--shadow);padding:18px 22px;border-left:4px solid var(--pri)}
.passage-card .ptitle{font-size:14px;font-weight:700;margin-bottom:10px}
.passage-card .ptext{font-size:15px;line-height:2;color:#475569}
.passage-card .ptext .vw{color:var(--pri);font-weight:700;cursor:pointer;border-bottom:1px dashed var(--pri-light)}
.passage-card .ptext .vw:hover{background:var(--pri-light)}
.passage-actions{display:flex;gap:8px;margin-top:10px;flex-wrap:wrap}
.words-card{background:var(--card);border-radius:var(--radius);box-shadow:var(--shadow);overflow:hidden}
.words-card .whead{padding:12px 16px;border-bottom:1px solid var(--border);display:flex;justify-content:space-between;align-items:center}
.words-card .whead h3{font-size:14px;font-weight:700}
.word-row{display:flex;align-items:center;padding:7px 14px;border-bottom:1px solid #f8fafb;font-size:12px;cursor:pointer;transition:background .1s}
.word-row:hover{background:#fafcfb}
.word-row .wn{width:26px;font-size:10px;color:var(--muted)}
.word-row .we{font-weight:600;flex:1}
.word-row .wt{font-size:9px;color:var(--muted);margin:0 6px;background:#f1f5f9;padding:1px 5px;border-radius:3px}
.word-row .wc{color:#64748b;font-size:11px;text-align:right;min-width:70px}
.word-row .ws{font-size:15px;cursor:pointer;margin-left:6px;color:#e5e7eb}
.word-row .ws.liked{color:#f59e0b}
.test-card{background:var(--card);border-radius:var(--radius);box-shadow:var(--shadow);padding:20px 22px}
.test-card .theader{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px}
.test-card .theader h3{font-size:14px;font-weight:700}
.test-q{margin-bottom:14px;padding:14px;background:#f9fafb;border-radius:8px}
.test-q .qnum{font-size:11px;font-weight:700;color:var(--pri);margin-bottom:6px}
.test-q .qtext{font-size:14px;font-weight:600;margin-bottom:8px}
.test-q .opts{display:grid;grid-template-columns:1fr 1fr;gap:6px}
.test-q .opt{padding:9px 12px;border:2px solid var(--border);border-radius:7px;cursor:pointer;font-size:12px;transition:all .12s;background:#fff;text-align:left;font-family:inherit}
.test-q .opt:hover{border-color:var(--pri);background:var(--pri-light)}
.test-q .opt.chosen{border-color:var(--pri);background:var(--pri-light);font-weight:700}
.test-q .opt.correct{border-color:var(--green);background:#f0fdf4;color:#065f46}
.test-q .opt.wrong{border-color:var(--red);background:#fef2f2;color:#991b1b}
.test-q .feedback{font-size:12px;margin-top:6px;display:none}
.test-q .feedback.correct{color:var(--green);display:block}
.test-q .feedback.wrong{color:var(--red);display:block}
.empty{text-align:center;padding:60px 20px;color:var(--muted)}
.empty .icon{font-size:48px;margin-bottom:10px}
.toast-container{position:fixed;bottom:30px;left:50%;transform:translateX(-50%);z-index:300;display:flex;flex-direction:column;gap:8px;align-items:center}
.toast{padding:10px 20px;border-radius:8px;font-size:13px;font-weight:600;animation:toastIn .25s,toastOut .25s 1.5s forwards;box-shadow:0 4px 16px rgba(0,0,0,.15);pointer-events:none}
.toast-info{background:#1e293b;color:#fff}.toast-ok{background:#065f46;color:#fff}
@keyframes toastIn{from{opacity:0;transform:translateY(10px)}to{opacity:1;transform:translateY(0)}}
@keyframes toastOut{from{opacity:1}to{opacity:0}}
@media(max-width:768px){.sidebar{width:180px;min-width:180px}.main{padding:10px}.passage-card{padding:14px}.test-q .opts{grid-template-columns:1fr}}
@media(max-width:560px){.layout{flex-direction:column}.sidebar{width:100%;min-width:0;max-height:180px;border-right:none;border-bottom:1px solid var(--border)}.main{height:auto}}
</style></head><body>
<div class="topbar"><div class="brand"><div class="dot">K</div>KET词汇训练 · 20话题</div>
<div class="actions"><button class="btn btn-sm btn-outline" onclick="resetProgress()">🔄 重置进度</button></div></div>
<div class="layout">
<div class="sidebar"><div class="sidebar-head"><input type="text" id="searchInput" placeholder="🔍 搜索单词…" oninput="onSearch(this.value)"></div><div class="sidebar-list" id="topicList"></div></div>
<div class="main" id="mainContent"><div class="empty"><div class="icon">📖</div><h3>选择一个话题开始学习</h3><p style="font-size:13px;color:var(--muted);">20个话题 · 800个单词 · 每课文章+测试</p></div></div>
</div>
<div class="toast-container" id="toastContainer"></div>
<script>
'@)

# ====== PART 2: JS ENGINE ======
$sw.Write(@'
var D=[],completed=JSON.parse(localStorage.getItem('ket2_progress')||'{}'),currentTopic=0,synth=window.speechSynthesis,speaking=false;
function T(t,u,w,p,q){D.push({t:t,u:u,w:w,p:p,q:q})}
function saveProgress(){localStorage.setItem('ket2_progress',JSON.stringify(completed))}
function toast(msg,type){type=type||'info';var c=document.getElementById('toastContainer'),el=document.createElement('div');el.className='toast toast-'+type;el.textContent=msg;c.appendChild(el);setTimeout(function(){el.remove()},1800)}
function selectTopic(idx){currentTopic=idx;renderTopic(idx);document.getElementById('mainContent').scrollTop=0}
function resetProgress(){if(!confirm('确定重置所有学习进度吗？'))return;completed={};saveProgress();renderSidebar();if(D.length>0)renderTopic(currentTopic);toast('进度已重置','info')}
function onSearch(val){val=(val||'').trim().toLowerCase();renderSidebar(val)}
function markDone(idx){completed['done_'+idx]=!completed['done_'+idx];saveProgress();renderSidebar();renderTopic(idx);toast(completed['done_'+idx]?'已标记完成 ✅':'已取消标记','ok')}
function toggleStar(idx,wi){var k='star_'+idx+'_'+wi;completed[k]=!completed[k];saveProgress();renderTopic(idx)}
function speakWord(word){if(speaking){synth.cancel();speaking=false;return}var u=new SpeechSynthesisUtterance(word);u.lang='en-GB';u.rate=0.8;u.onend=function(){speaking=false};speaking=true;synth.speak(u)}
function speakPassage(idx){if(speaking){synth.cancel();speaking=false;return}var t=D[idx],txt=t.p.replace(/\*/g,''),u=new SpeechSynthesisUtterance(txt);u.lang='en-GB';u.rate=0.85;u.onend=function(){speaking=false};speaking=true;synth.speak(u);var b=document.getElementById('btnSpeak');if(b){b.textContent='⏹ 停止';b.style.background='var(--red)'}setTimeout(function(){var b=document.getElementById('btnSpeak');if(b){b.textContent='🔊 朗读';b.style.background='var(--pri)'}},txt.length*65)}
function speakSlow(idx){if(speaking){synth.cancel();speaking=false;return}var t=D[idx],txt=t.p.replace(/\*/g,''),u=new SpeechSynthesisUtterance(txt);u.lang='en-GB';u.rate=0.55;u.onend=function(){speaking=false};speaking=true;synth.speak(u)}

function renderSidebar(filter){
  var list=document.getElementById('topicList'),html='',lastUnit='';
  for(var i=0;i<D.length;i++){
    var t=D[i];
    if(filter){var found=false;for(var j=0;j<t.w.length;j++){if(t.w[j][0].toLowerCase().indexOf(filter)>-1||t.w[j][1].indexOf(filter)>-1||t.t.indexOf(filter)>-1){found=true;break}}if(!found)continue}
    if(t.u!==lastUnit){html+='<div class="unit-label">'+t.u+'</div>';lastUnit=t.u}
    html+='<div class="topic-item'+(i===currentTopic?' active':'')+(completed['done_'+i]?' done':'')+'" onclick="selectTopic('+i+')"><span><span class="num">'+(i+1)+'.</span>'+t.t+'</span><span class="check">✅</span></div>';
  }
  if(!html)html='<div style="text-align:center;padding:20px;color:var(--muted);font-size:12px;">未找到匹配</div>';
  list.innerHTML=html;
}

function renderTopic(idx){
  var t=D[idx],main=document.getElementById('mainContent'),html='',vocabMap={};
  for(var i=0;i<t.w.length;i++){vocabMap[t.w[i][0].toLowerCase()]=true}
  var words=t.p.split(' '),passageHtml='';
  for(var wi=0;wi<words.length;wi++){
    var w=words[wi],clean=w.replace(/[^a-zA-Z'-]/g,'').toLowerCase();
    if(vocabMap[clean])passageHtml+='<span class="vw" onclick="speakWord(\''+clean.replace(/'/g,"\\'")+'\')">'+w+'</span> ';
    else passageHtml+=w+' ';
  }
  html+='<div class="passage-card"><div class="ptitle">📖 Topic '+(idx+1)+': '+t.t+'</div><div class="ptext">'+passageHtml+'</div>';
  html+='<div class="passage-actions"><button class="btn btn-sm btn-pri" onclick="speakPassage('+idx+')" id="btnSpeak">🔊 朗读</button><button class="btn btn-sm btn-outline" onclick="speakSlow('+idx+')">🐢 慢速</button><button class="btn btn-sm btn-outline" onclick="markDone('+idx+')">✅ '+(completed['done_'+idx]?'取消完成':'标记完成')+'</button></div></div>';
  html+='<div class="words-card"><div class="whead"><h3>📝 词汇 ('+t.w.length+'个)</h3><span style="font-size:11px;color:var(--muted)">点击单词听发音</span></div>';
  for(var i=0;i<t.w.length;i++){
    var w=t.w[i],sk='star_'+idx+'_'+i;
    html+='<div class="word-row" onclick="speakWord(\''+w[0].replace(/'/g,"\\'")+'\')"><span class="wn">'+(i+1)+'</span><span class="we">'+w[0]+'</span><span class="wt">'+w[2]+'</span><span class="wc">'+w[1]+'</span><span class="ws'+(completed[sk]?' liked':'')+'" onclick="event.stopPropagation();toggleStar('+idx+','+i+')">'+(completed[sk]?'★':'☆')+'</span></div>';
  }
  html+='</div>';
  html+='<div class="test-card"><div class="theader"><h3>📝 测试 (10题)</h3><button class="btn btn-sm btn-pri" onclick="startTest('+idx+')">🔄 重新测试</button></div><div id="testArea">'+buildTestHTML(idx)+'</div></div>';
  main.innerHTML=html;
}

function buildTestHTML(idx){
  var t=D[idx],q=t.q,html='';
  for(var i=0;i<q.length;i++){
    var qi=q[i];
    html+='<div class="test-q"><div class="qnum">'+(i+1)+'. '+qi.type+'</div><div class="qtext">'+qi.q+'</div><div class="opts">';
    for(var j=0;j<qi.opts.length;j++){html+='<button class="opt" id="opt_'+i+'_'+j+'" onclick="checkAnswer('+idx+','+i+','+j+',this)">'+'ABCD'[j]+'. '+qi.opts[j]+'</button>'}
    html+='</div><div class="feedback" id="fb_'+i+'"></div></div>';
  }
  return html;
}

function startTest(idx){
  var t=D[idx],shuffled=[];
  for(var i=0;i<t.q.length;i++)shuffled.push(i);
  for(var i=shuffled.length-1;i>0;i--){var j=Math.floor(Math.random()*(i+1)),tmp=shuffled[i];shuffled[i]=shuffled[j];shuffled[j]=tmp}
  var html='';
  for(var si=0;si<shuffled.length;si++){
    var i=shuffled[si],qi=t.q[i];
    html+='<div class="test-q"><div class="qnum">'+(si+1)+'. '+qi.type+'</div><div class="qtext">'+qi.q+'</div><div class="opts">';
    for(var j=0;j<qi.opts.length;j++){html+='<button class="opt" id="opt_'+i+'_'+j+'" onclick="checkAnswer('+idx+','+i+','+j+',this)">'+'ABCD'[j]+'. '+qi.opts[j]+'</button>'}
    html+='</div><div class="feedback" id="fb_'+i+'"></div></div>';
  }
  document.getElementById('testArea').innerHTML=html;
}

function checkAnswer(topicIdx,qIdx,optIdx,btn){
  var t=D[topicIdx],qi=t.q[qIdx],opts=document.querySelectorAll('#opt_'+qIdx+'_0,#opt_'+qIdx+'_1,#opt_'+qIdx+'_2,#opt_'+qIdx+'_3');
  for(var i=0;i<opts.length;i++){opts[i].disabled=true;opts[i].style.pointerEvents='none'}
  var fb=document.getElementById('fb_'+qIdx);
  if(optIdx===qi.answer){
    btn.classList.add('correct');fb.className='feedback correct';fb.textContent='✅ 正确！';
    completed['test_'+topicIdx+'_'+qIdx]=true;
  }else{
    btn.classList.add('wrong');fb.className='feedback wrong';fb.textContent='❌ 错误。正确答案 '+qi.opts[qi.answer];
    var cb=document.getElementById('opt_'+qIdx+'_'+qi.answer);if(cb)cb.classList.add('correct');
  }
  saveProgress();
  var correct=0,total=0;
  for(var i=0;i<t.q.length;i++){if(completed['test_'+topicIdx+'_'+i])correct++;total++}
  if(total===t.q.length){setTimeout(function(){toast('测试完成：'+correct+'/'+total+' ('+Math.round(correct/total*100)+'%)',correct>=8?'ok':'info')},500)}
}

function init(){renderSidebar();if(D.length>0)renderTopic(0)}
'@)

$sw.Close()
Write-Host "Build script created: $((Get-Item $f).Length) bytes"
