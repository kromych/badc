
volatile_ptr_alias_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	add	x1, x1, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0xa
               	b.gt	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
