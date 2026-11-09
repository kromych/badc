
addr_null_compare_past_a_subobject_size_query.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x908             // =2312
               	movk	x17, #0xb0a, lsl #16
               	movk	x17, #0xd0c, lsl #32
               	movk	x17, #0xf0e, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
