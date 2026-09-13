
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
               	mov	x2, #0x4028000000000000 // =4622945017495814144
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	mov	x1, x0
               	mov	x1, #0x2                // =2
               	mov	x3, x1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, #0x4028000000000000 // =4622945017495814144
               	fmov	d16, x2
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ret
