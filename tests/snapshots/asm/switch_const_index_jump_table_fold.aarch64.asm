
switch_const_index_jump_table_fold.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0xc                // =12
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x14               // =20
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x14               // =20
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x14               // =20
               	cmp	x0, #0x1b
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x14               // =20
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	b	<addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	b	<addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0x15               // =21
               	b	<addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	b	<addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0x15               // =21
               	b	<addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	b	<addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0x15               // =21
               	b	<addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	b	<addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, #-0x2               // =-2
               	b	<addr>
