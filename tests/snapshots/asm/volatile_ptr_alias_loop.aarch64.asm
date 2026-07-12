
volatile_ptr_alias_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	stur	x1, [x29, #-0x10]
               	b	<addr>
               	ldur	x2, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	str	w1, [x2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0xa
               	b.gt	<addr>
               	ldursw	x1, [x29, #-0x8]
               	cmp	x1, #0x3
               	b.lt	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
