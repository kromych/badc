
switch_goto_label_into_case.aarch64:	file format elf64-littleaarch64

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
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w0, #0x4
               	b.lt	<addr>
               	cmp	w0, #0x4
               	b.eq	<addr>
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	w0, #0x8
               	cset	x0, le
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ret

<main>:
               	mov	x0, #0xa                // =10
               	mov	x0, #0x14               // =20
               	mov	x0, #0x1e               // =30
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	mov	x2, x1
               	mov	x0, #0x1e               // =30
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
