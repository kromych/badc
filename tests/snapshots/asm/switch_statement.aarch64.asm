
switch_statement.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x2                // =2
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	b	<addr>
               	mov	x2, #0x14               // =20
               	b	<addr>
               	sxtw	x0, w2
               	add	x0, x0, #0x5
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x64               // =100
               	b	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
