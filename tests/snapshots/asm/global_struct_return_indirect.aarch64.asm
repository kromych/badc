
global_struct_return_indirect.aarch64:	file format elf64-littleaarch64

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

<get_global>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x8, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, x0
               	sub	x17, x29, #0x8
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldrb	w0, [x16, #0x10]
               	strb	w0, [x17, #0x10]
               	ldrb	w0, [x16, #0x11]
               	strb	w0, [x17, #0x11]
               	ldrb	w0, [x16, #0x12]
               	strb	w0, [x17, #0x12]
               	ldrb	w0, [x16, #0x13]
               	strb	w0, [x17, #0x13]
               	mov	x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x8, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x10]
               	eor	x0, x1, #0x1
               	cbnz	w0, <addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x8, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldr	w20, [x0]
               	sub	x8, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x10]
               	add	x0, x20, x0
               	mov	w0, w0
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
