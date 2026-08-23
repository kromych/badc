
struct_param_stack_spill.aarch64:	file format elf64-littleaarch64

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

<f16>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0xa0]
               	str	x17, [x16]
               	ldr	x17, [x29, #0xa8]
               	str	x17, [x16, #0x8]
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x1, x0, x7
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x90
               	ret

<f12>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0xa0]
               	str	x17, [x16]
               	ldr	w17, [x29, #0xa8]
               	str	w17, [x16, #0x8]
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x2, x0, x7
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x2, x2, x1
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x1, x2, x1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x90
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x22, #0x1               // =1
               	stur	x22, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x8]
               	sub	x20, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	ldur	x2, [x29, #-0x10]
               	mov	x21, #0x3               // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	sub	sp, sp, #0x10
               	mov	x16, x20
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x0, x2
               	mov	x2, x21
               	blr	x9
               	add	sp, sp, #0x10
               	cmp	x0, #0xbe0
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x22, #0x0               // =0
               	str	x22, [x20]
               	str	w22, [x20, #0x8]
               	ldursw	x0, [x29, #-0x8]
               	str	w0, [x20]
               	sub	x0, x29, #0x20
               	str	w21, [x0, #0x4]
               	mov	x3, #0x4                // =4
               	str	w3, [x0, #0x8]
               	ldur	x2, [x29, #-0x10]
               	mov	x20, #0x2               // =2
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	sub	sp, sp, #0x10
               	mov	x16, x0
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldrb	w17, [x16, #0x8]
               	strb	w17, [sp, #0x8]
               	ldrb	w17, [x16, #0x9]
               	strb	w17, [sp, #0x9]
               	ldrb	w17, [x16, #0xa]
               	strb	w17, [sp, #0xa]
               	ldrb	w17, [x16, #0xb]
               	strb	w17, [sp, #0xb]
               	mov	x0, x2
               	mov	x2, x21
               	mov	x1, x20
               	blr	x9
               	add	sp, sp, #0x10
               	cmp	x0, #0x10e
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
