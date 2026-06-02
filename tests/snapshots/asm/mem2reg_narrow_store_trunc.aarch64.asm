
mem2reg_narrow_store_trunc.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x10]
               	b	<addr>
               	mov	x14, #0x1               // =1
               	stur	x14, [x29, #-0x10]
               	b	<addr>
               	ldur	x14, [x29, #-0x10]
               	mov	x0, x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x12c              // =300
               	bl	<addr>
               	mov	x14, x0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
