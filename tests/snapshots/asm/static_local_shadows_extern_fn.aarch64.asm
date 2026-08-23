
static_local_shadows_extern_fn.aarch64:	file format elf64-littleaarch64

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

<driver>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x2
               	b.lt	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	cmp	w1, #0x1
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x2a               // =42
               	b	<addr>

<main>:
               	mov	x0, #0x2a               // =42
               	mov	x0, #0x2a               // =42
               	ret
