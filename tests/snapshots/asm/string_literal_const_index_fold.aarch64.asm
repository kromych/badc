
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
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x2, w0
               	add	x1, x1, x2
               	ldrsb	x4, [x1]
               	cmp	w0, #0x2
               	b.lt	<addr>
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x1, x3
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
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
               	cbnz	x0, <addr>
               	mov	x1, #0x61               // =97
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	ret
               	mov	x0, #0x8                // =8
               	ret
