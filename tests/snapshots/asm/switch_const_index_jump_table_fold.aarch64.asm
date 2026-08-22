
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

<pick_folded>:
               	mov	x0, #0xc                // =12
               	ret

<pick_live>:
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x14               // =20
               	ret
               	mov	x0, #0x15               // =21
               	ret
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0x17               // =23
               	ret
               	mov	x0, #0x18               // =24
               	ret
               	mov	x0, #0x19               // =25
               	ret
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x0, #0x1b               // =27
               	ret
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x5               // =5
               	stur	w20, [x29, #-0x8]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x1b
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
