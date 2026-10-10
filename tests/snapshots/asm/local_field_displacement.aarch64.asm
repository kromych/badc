
local_field_displacement.aarch64:	file format elf64-littleaarch64

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

<write_all>:
               	add	x2, x1, #0x1
               	str	x2, [x0]
               	add	x2, x1, #0x2
               	str	x2, [x0, #0x8]
               	add	x2, x1, #0x3
               	str	x2, [x0, #0x10]
               	add	x1, x1, #0x4
               	str	x1, [x0, #0x18]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x20
               	mov	x1, #0x1                // =1
               	strb	w1, [sp, #0x20]
               	mov	x0, sp
               	str	x1, [sp]
               	mov	x2, #0x2                // =2
               	str	x2, [sp, #0x8]
               	mov	x3, #0x3                // =3
               	str	x3, [sp, #0x10]
               	mov	x4, #0x4                // =4
               	str	x4, [sp, #0x18]
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, x4
               	bl	<addr>
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	add	x0, x0, x1
               	ldr	x1, [sp, #0x10]
               	add	x0, x0, x1
               	ldr	x1, [sp, #0x18]
               	add	x0, x0, x1
               	ldrb	w1, [sp, #0x20]
               	eor	x1, x1, #0x1
               	cbz	w1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x0, #0x32
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
