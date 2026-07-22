
switch_goto_label_into_case.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.lt	<addr>
               	cmp	x0, #0x4
               	b.lt	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	cmp	x0, #0x5
               	cset	x1, ge
               	cbz	x1, <addr>
               	cmp	x0, #0x8
               	cset	x1, le
               	cbz	x1, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x2
               	b.lt	<addr>
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	mov	x0, #0xa                // =10
               	mov	x0, #0x14               // =20
               	mov	x0, #0x1e               // =30
               	mov	x0, #0x1e               // =30
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1e               // =30
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1e               // =30
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1e               // =30
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
