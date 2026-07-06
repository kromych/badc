
inline_arg_count_mismatch.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	add	x0, x0, x1
               	sxtw	x20, w0
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
