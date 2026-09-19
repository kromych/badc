
hex_case_range.aarch64:	file format elf64-littleaarch64

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

<classify>:
               	cmp	w0, #0x10
               	b.ge	<addr>
               	cmp	w0, #0x30
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	cmp	w0, #0x40
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w0, #0x20
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret

<main>:
               	fmov	d0, #12.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
