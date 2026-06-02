
for_loop_call_body_and_step.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x14, w0
               	mov	x0, x14
               	ret
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x14, w0
               	mov	x0, x14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	<addr>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x7
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x10]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	mov	x17, #0x6               // =6
               	mul	x14, x14, x17
               	sxtw	x0, w14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
