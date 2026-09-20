
switch_multilabel.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<classify>:
               	cmp	w0, #0x42
               	b.lt	<addr>
               	cmp	w0, #0x62
               	b.lt	<addr>
               	cmp	w0, #0x63
               	b.lt	<addr>
               	cmp	w0, #0x64
               	b.lt	<addr>
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	cmp	w0, #0x61
               	b.ge	<addr>
               	cmp	w0, #0x42
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w0, #0x32
               	b.lt	<addr>
               	cmp	w0, #0x33
               	b.lt	<addr>
               	cmp	w0, #0x41
               	b.ge	<addr>
               	cmp	w0, #0x33
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w0, #0x31
               	b.ge	<addr>
               	cmp	w0, #0x30
               	b.eq	<addr>
               	b	<addr>

<main>:
               	mov	x0, #0x0                // =0
               	ret
