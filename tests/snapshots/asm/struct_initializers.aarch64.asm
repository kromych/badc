
struct_initializers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x340              // =832
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<do_sub>:
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x0, [x20]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x10]
               	mov	x1, #0xa                // =10
               	mov	x2, #0x4                // =4
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x18]
               	ldrb	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	ldrb	w0, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	mov	x1, #0x5                // =5
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
