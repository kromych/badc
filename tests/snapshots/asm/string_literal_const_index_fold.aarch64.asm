
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
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x0
               	ldrsb	x3, [x2]
               	cmp	x0, #0x2
               	b.lt	<addr>
               	cmp	x0, #0x3
               	b.lt	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x2, #0x0                // =0
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
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
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x8                // =8
               	ret
