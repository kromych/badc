
mem2reg_value_across_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x7
               	ret

<g>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x22, x0
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	b	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x1
               	add	x23, x0, x1
               	mov	x9, x21
               	mov	x0, x20
               	blr	x9
               	add	x0, x23, x0
               	add	x20, x20, #0x1
               	cmp	x20, x22
               	b.lt	<addr>
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
