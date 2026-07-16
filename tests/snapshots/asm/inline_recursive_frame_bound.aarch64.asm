
inline_recursive_frame_bound.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<rec>:
               	sub	sp, sp, #0x10
               	str	x0, [sp, #-0x10]!
               	stp	x20, x21, [sp, #-0x160]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x150]
               	add	x29, sp, #0x150
               	mov	x23, x1
               	sxtw	x23, w23
               	stur	x0, [x29, #0x10]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x22, x29, #0x100
               	sxtw	x21, w20
               	add	x0, x23, x21
               	bl	<addr>
               	str	w0, [x22, x21, lsl #2]
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x40
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x20, x0
               	b	<addr>
               	sub	x2, x29, #0x100
               	ldrsw	x2, [x2, x1, lsl #2]
               	add	x20, x20, x2
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	ldur	x0, [x29, #0x10]
               	str	w20, [x0]
               	cmp	x23, #0x0
               	b.gt	<addr>
               	sxtw	x0, w20
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x150]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	add	sp, sp, #0x20
               	ret
               	ldur	x0, [x29, #0x10]
               	sub	x1, x23, #0x1
               	bl	<addr>
               	add	x0, x20, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x150]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	add	sp, sp, #0x20
               	ret

<once>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	add	x0, x0, #0x7
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x17, #0x17e0            // =6112
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0x17e0            // =6112
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
