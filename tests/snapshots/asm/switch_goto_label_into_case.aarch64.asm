
switch_goto_label_into_case.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0xa               // =10
               	mov	x0, x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x14              // =20
               	mov	x0, x13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x1e              // =30
               	mov	x0, x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x5
               	cset	x13, ge
               	stur	x13, [x29, #-0x8]
               	cbz	x13, <addr>
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x8
               	cset	x0, le
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
