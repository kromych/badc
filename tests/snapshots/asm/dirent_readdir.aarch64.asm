
dirent_readdir.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x320              // =800
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x21, #0x0               // =0
               	mov	x22, x21
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	add	x22, x22, #0x1
               	add	x0, x0, #0x13
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w22
               	cmp	x0, #0x2
               	cset	x1, gt
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x21, #0x1               // =1
               	b	<addr>
               	sxtw	x1, w21
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
               	b	<addr>
