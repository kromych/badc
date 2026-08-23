
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
               	mov	x4, #0xff               // =255
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x3
               	b	<addr>
               	add	x2, x5, x0
               	ldrsb	x6, [x2]
               	cmp	x0, #0x2
               	b.lt	<addr>
               	cmp	x0, #0x3
               	b.lt	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x2, x3
               	and	x6, x6, x4
               	and	x2, x2, x4
               	cmp	x6, x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, #0xa                // =10
               	b	<addr>
               	mov	x2, #0x63               // =99
               	b	<addr>
               	cmp	x0, #0x1
               	b.lt	<addr>
               	mov	x2, #0x62               // =98
               	b	<addr>
               	cbnz	x0, <addr>
               	mov	x2, #0x61               // =97
               	b	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	ret
               	mov	x0, #0x8                // =8
               	ret
