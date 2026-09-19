
string_literal_const_index_fold.aarch64:	file format elf64-littleaarch64

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

<main>:
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x2
               	cmp	w0, #0x5
               	b.ge	<addr>
               	ldrsb	x4, [x3, x0]
               	cmp	w0, #0x2
               	b.lt	<addr>
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x1, x2
               	and	x4, x4, #0xff
               	cmp	w4, w1
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
               	mov	x1, #0x63               // =99
               	b	<addr>
               	cmp	w0, #0x1
               	b.lt	<addr>
               	mov	x1, #0x62               // =98
               	b	<addr>
               	mov	x1, #0x61               // =97
               	and	x4, x4, #0xff
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x8                // =8
               	ret
