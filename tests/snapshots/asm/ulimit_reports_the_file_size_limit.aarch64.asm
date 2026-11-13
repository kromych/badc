
ulimit_reports_the_file_size_limit.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	lsr	x2, x0, #9
               	cmn	x0, #0x1
               	csel	x20, x1, x2, eq
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, x20
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldur	x0, [x29, #-0x10]
               	cmn	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	str	x1, [sp, #0x18]
               	bl	<addr>
               	ldr	x1, [sp, #0x18]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
