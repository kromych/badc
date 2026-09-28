
inline_asm_clobber_live_values.aarch64:	file format elf64-littleaarch64

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

<spread>:
               	stp	x26, x27, [sp, #-0x50]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x24, x25, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	add	x8, x0, #0x1
               	add	x11, x0, #0x2
               	add	x12, x0, #0x3
               	add	x13, x0, #0x4
               	add	x14, x0, #0x5
               	add	x15, x0, #0x6
               	add	x26, x0, #0x7
               	add	x27, x0, #0x8
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	lsl	x0, x11, #1
               	add	x0, x8, x0
               	lsl	x1, x12, #2
               	add	x0, x0, x1
               	lsl	x1, x13, #3
               	add	x0, x0, x1
               	lsl	x1, x14, #4
               	add	x0, x0, x1
               	lsl	x1, x15, #5
               	add	x0, x0, x1
               	lsl	x1, x26, #6
               	add	x0, x0, x1
               	lsl	x1, x27, #7
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	x26, x27, [sp], #0x50
               	ret

<branchy>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sxtw	x1, w1
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x8, x0, #0x1
               	cbz	x1, <addr>
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x0, x8
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<carried>:
               	mov	x12, x0
               	mov	x8, #0x0                // =0
               	mov	x11, x8
               	cmp	x8, x12
               	b.ge	<addr>
               	madd	x11, x8, x8, x11
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	add	x8, x8, #0x1
               	cmp	x8, x12
               	b.lt	<addr>
               	mov	x0, x11
               	ret

<jumped>:
               	sxtw	x11, w1
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x8, x0, #0x3
               	cbz	w11, <addr>
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	b	<addr>
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	mov	x0, x8
               	ret
               	add	x0, x8, #0x1
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x8, #0x0                // =0
               	mov	x11, x8
               	madd	x11, x8, x8, x11
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	add	x8, x8, #0x1
               	cmp	w8, #0xa
               	b.lt	<addr>
               	cmp	x11, #0x11d
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x16, #0x0               // =0
               	cbz	w16, <addr>
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	b	<addr>
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	mov	x16, #0x1               // =1
               	cbz	w16, <addr>
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	b	<addr>
               	mov	x0, xzr
               	mov	x1, xzr
               	mov	x2, xzr
               	mov	x3, xzr
               	mov	x4, xzr
               	mov	x5, xzr
               	mov	x6, xzr
               	mov	x7, xzr
               	mov	x9, xzr
               	mov	x10, xzr
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
