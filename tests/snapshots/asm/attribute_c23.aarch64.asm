
attribute_c23.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<classify>:
               	mov	x1, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x0, w0
               	ret
               	add	x0, x0, #0x1
               	b	<addr>
               	cmp	x1, #0x1
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>

<main>:
               	mov	x0, #0x0                // =0
               	mov	x0, #0xa                // =10
               	mov	x0, #0xb                // =11
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret

<die>:
               	b	<addr>
