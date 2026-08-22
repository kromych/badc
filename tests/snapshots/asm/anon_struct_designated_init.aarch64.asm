
anon_struct_designated_init.aarch64:	file format elf64-littleaarch64

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

<check_runtime>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x3, #0xb                // =11
               	mov	x4, #0x16               // =22
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	w1, [x0, #0x10]
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	str	w4, [x0, #0x8]
               	str	w3, [x0, #0x4]
               	mov	x3, #0x4                // =4
               	str	w3, [x0, #0x10]
               	mov	x0, x2
               	mov	x0, x2
               	mov	x0, x2
               	mov	x0, x1
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	mov	x1, x0
               	mov	x0, #0xb                // =11
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
