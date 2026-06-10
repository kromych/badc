
inline_arg_count_mismatch.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
