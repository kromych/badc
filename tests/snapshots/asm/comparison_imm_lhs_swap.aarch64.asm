
comparison_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	mov	x20, #0x1               // =1
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
