
pointer_difference_wide.aarch64:	file format elf64-littleaarch64

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

<d12>:
               	sub	x0, x0, x1
               	mov	x1, #0xaaab             // =43691
               	movk	x1, #0xaaaa, lsl #16
               	movk	x1, #0xaaaa, lsl #32
               	movk	x1, #0x2aaa, lsl #48
               	smulh	x0, x0, x1
               	asr	x0, x0, #1
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	ret

<d16>:
               	sub	x0, x0, x1
               	asr	x1, x0, #63
               	lsr	x1, x1, #60
               	add	x0, x0, x1
               	asr	x0, x0, #4
               	ret

<d4>:
               	sub	x0, x0, x1
               	asr	x1, x0, #63
               	lsr	x1, x1, #62
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x100000000000     // =17592186044416
               	stur	x0, [x29, #-0x38]
               	ldur	x20, [x29, #-0x38]
               	mov	x17, #0x600000000       // =25769803776
               	add	x21, x20, x17
               	mov	x17, #0x800000000       // =34359738368
               	add	x22, x20, x17
               	mov	x17, #0x3ffffffffc      // =274877906940
               	add	x23, x20, x17
               	sub	x0, x29, #0x30
               	add	x1, x0, #0x24
               	sub	x3, x1, x0
               	mov	x2, #0xaaab             // =43691
               	movk	x2, #0xaaaa, lsl #16
               	movk	x2, #0xaaaa, lsl #32
               	movk	x2, #0x2aaa, lsl #48
               	smulh	x3, x3, x2
               	asr	x3, x3, #1
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	cmp	x3, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x0, x1
               	smulh	x0, x0, x2
               	asr	x0, x0, #1
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0xfffffffff       // =68719476735
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	mov	x17, #-0xfffffffff      // =-68719476735
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
