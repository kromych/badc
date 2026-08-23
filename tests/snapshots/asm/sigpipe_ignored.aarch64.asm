
sigpipe_ignored.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0xd                // =13
               	mov	x21, #0x1               // =1
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	ldrsw	x0, [x20, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
