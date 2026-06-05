
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
               	sxtw	x0, w0
               	ret
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x0               // =0
               	mov	x21, x20
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x7
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	sxtw	x0, w21
               	bl	<addr>
               	mov	x21, x0
               	b	<addr>
               	sxtw	x0, w21
               	mov	x17, #0x6               // =6
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
