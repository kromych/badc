
switch_jump_table_dense.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x3                // =3
               	cmp	w1, #0x13
               	b.gt	<addr>
               	cmp	w1, #0xf
               	b.eq	<addr>
               	cmp	w1, #0xf
               	b.ge	<addr>
               	sub	x2, x1, #0x2
               	sub	x0, x1, #0x3
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x1                // =1
               	cmp	w0, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	b	<addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	mov	x0, #0xf                // =15
               	b	<addr>
               	mov	x0, #0x10               // =16
               	b	<addr>
               	sub	x2, x1, #0x3
               	b	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x13
               	b.le	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
