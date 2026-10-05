
conditional_select.aarch64:	file format elf64-littleaarch64

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

<tern>:
               	sxtw	x0, w0
               	sxtw	x2, w2
               	sxtw	x1, w1
               	cmp	x2, #0x0
               	csel	w0, w0, w1, ne
               	ret

<min2>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	cmp	w0, w1
               	csel	w0, w0, w1, lt
               	ret

<max2>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	cmp	w0, w1
               	csel	w0, w0, w1, gt
               	ret

<abs2>:
               	cmp	x0, #0x0
               	b.ge	<addr>
               	neg	x0, x0
               	ret

<ffs_i>:
               	rbit	w0, w0
               	clz	w0, w0
               	cmp	w0, #0x20
               	csinc	w0, wzr, w0, eq
               	ret

<ffs_l>:
               	rbit	x0, x0
               	clz	x0, x0
               	cmp	w0, #0x40
               	csinc	x0, xzr, x0, eq
               	ret

<guarded>:
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	ldrsw	x0, [x0]
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
