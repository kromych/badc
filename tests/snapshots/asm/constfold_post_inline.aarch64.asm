
constfold_post_inline.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	mov	x1, #0x40               // =64
               	lsl	x1, x0, x1
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x41               // =65
               	lsl	x0, x0, x1
               	mov	x17, #0x9bde            // =39902
               	movk	x17, #0x1357, lsl #16
               	movk	x17, #0x8acf, lsl #32
               	movk	x17, #0x246, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	add	x2, x0, #0x5
               	mov	x17, #0xcdf4            // =52724
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ls	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ror	x2, x0, #0x7
               	mov	x17, #0x579b            // =22427
               	movk	x17, #0xcf13, lsl #16
               	movk	x17, #0x468a, lsl #32
               	movk	x17, #0xde02, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x41              // =65
               	lsl	x0, x0, x17
               	mov	x17, #0x9bde            // =39902
               	movk	x17, #0x1357, lsl #16
               	movk	x17, #0x8acf, lsl #32
               	movk	x17, #0x246, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	asr	x0, x0, #1
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
