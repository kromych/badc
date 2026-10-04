
pointer_to_array_typedef_member_subscript.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0, #0x808]
               	and	x1, x1, #0xffffffff0000003f
               	mov	x17, #0x240             // =576
               	orr	x1, x1, x17
               	str	w1, [x0, #0x808]
               	ldr	w1, [x0, #0x80c]
               	and	x1, x1, #0xffffffff0000003f
               	mov	x17, #0x140             // =320
               	orr	x1, x1, x17
               	str	w1, [x0, #0x80c]
               	add	x1, x0, #0x800
               	ldr	w1, [x1, #0x8]
               	asr	x1, x1, #6
               	cmp	w1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	w0, [x0, #0x80c]
               	asr	x0, x0, #6
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
