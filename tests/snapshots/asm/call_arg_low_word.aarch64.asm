
call_arg_low_word.aarch64:	file format elf64-littleaarch64

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

<scale>:
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	ret

<widen>:
               	sxtw	x0, w0
               	ret

<halve>:
               	mov	w0, w0
               	lsr	x0, x0, #1
               	ret

<sum>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x0, x0, x1
               	ret

<pick>:
               	ldr	x0, [x0, w1, sxtw #3]
               	ret

<pick_u>:
               	ldr	x0, [x0, w1, uxtw #3]
               	ret

<byte>:
               	sxtb	x0, w0
               	ret

<half>:
               	and	x0, x0, #0xffff
               	ret

<via_scale>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	orr	x0, x0, #0x1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_widen>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, #0x1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_halve>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	eor	x0, x0, #0x2
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_sum>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	x1, x1, #0x1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_pick>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	x1, x1, #0x5
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_pick_u>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x1, x1, #0x1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_byte>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_half>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	and	x0, x0, #0xffff
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x4                // =4
               	movk	x0, #0xbeef, lsl #32
               	movk	x0, #0xdead, lsl #48
               	stur	x0, [x29, #-0x10]
               	mov	x0, #-0x4               // =-4
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x1234, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	ldur	x1, [x29, #-0x10]
               	bl	<addr>
               	cmp	x0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	x1, [x29, #-0x10]
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7b              // =-123
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x1234, lsl #48
               	bl	<addr>
               	mov	x17, #-0x7b             // =-123
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0x1234, lsl #16
               	movk	x0, #0xbeef, lsl #32
               	movk	x0, #0xdead, lsl #48
               	bl	<addr>
               	mov	x17, #0xfffe            // =65534
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
