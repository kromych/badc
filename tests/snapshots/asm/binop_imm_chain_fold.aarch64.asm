
binop_imm_chain_fold.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0xa                // =10
               	add	x1, x0, #0x3
               	add	x1, x1, #0x7
               	add	x2, x0, #0x8
               	sub	x2, x2, #0x3
               	sub	x3, x0, #0x4
               	add	x3, x3, #0x9
               	sub	x4, x0, #0x2
               	sub	x4, x4, #0x5
               	mov	x17, #0x3f              // =63
               	and	x5, x0, x17
               	mov	x17, #0x3               // =3
               	orr	x6, x0, x17
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, x4
               	add	x1, x1, x5
               	add	x1, x1, x6
               	add	x0, x1, x0
               	sxtw	x20, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x20, #0x53
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
