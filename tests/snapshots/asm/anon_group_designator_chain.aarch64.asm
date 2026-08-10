
anon_group_designator_chain.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<check_runtime>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x2, #0x14               // =20
               	mov	x3, #0x16               // =22
               	sub	x1, x29, #0x30
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	str	x0, [x1, #0x20]
               	str	x0, [x1, #0x28]
               	mov	x1, #0x1                // =1
               	sub	x4, x29, #0x30
               	str	w1, [x4]
               	sub	x1, x29, #0x30
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x30
               	str	w3, [x1, #0xc]
               	sub	x1, x29, #0x68
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	str	x0, [x1, #0x20]
               	str	x0, [x1, #0x28]
               	str	w0, [x1, #0x30]
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0x68
               	str	w0, [x1]
               	sub	x0, x29, #0x68
               	str	w2, [x0, #0xc]
               	sub	x0, x29, #0x68
               	str	w3, [x0, #0x10]
               	sub	x0, x29, #0x68
               	str	w2, [x0, #0x2c]
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldrb	w10, [x1, #0x30]
               	strb	w10, [x0, #0x30]
               	ldrb	w10, [x1, #0x31]
               	strb	w10, [x0, #0x31]
               	ldrb	w10, [x1, #0x32]
               	strb	w10, [x0, #0x32]
               	ldrb	w10, [x1, #0x33]
               	strb	w10, [x0, #0x33]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x14               // =20
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
