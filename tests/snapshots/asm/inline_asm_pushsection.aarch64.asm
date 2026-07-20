
inline_asm_pushsection.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x2a               // =42
               	sub	sp, sp, #0x10
               	str	x1, [sp]
               	nop
               	nop
               	add	sp, sp, #0x10
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<fixup_style>:
               	nop
               	nop
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	bl	<addr>
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
