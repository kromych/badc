
struct_param_stack_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
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
               	add	x0, x0, x7
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x1, x0, x1
               	sub	x0, x29, #0x10
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
               	add	x1, x0, x7
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x1, x1, x0
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x1, x1, x0
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x90
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x1, x1, #0x24
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	x0, #0xbe0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x2, x1, #0x24
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x1, x2, x1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	x0, #0x10e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
