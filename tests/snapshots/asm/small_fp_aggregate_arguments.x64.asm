
small_fp_aggregate_arguments.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rdx
               	xorl	%eax, %eax
               	movq	$0x41, (%rsp)
               	movl	$0x40200000, 0x4(%rsp)  # imm = 0x40200000
               	leaq	0x8(%rsp), %rsi
               	movabsq	$0x400000003f800000, %rcx # imm = 0x400000003F800000
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	movabsq	$0x400000003f800000, %r11 # imm = 0x400000003F800000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	(%rdx), %r10
               	movq	%r10, (%rsi)
               	movq	0x8(%rsp), %rcx
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rcx
               	movabsq	$0x4020000000000041, %r11 # imm = 0x4020000000000041
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x40400000, 0x8(%rsp)  # imm = 0x40400000
               	movl	$0x40800000, 0xc(%rsp)  # imm = 0x40800000
               	movq	0x8(%rsp), %rcx
               	movabsq	$0x4080000040400000, %r11 # imm = 0x4080000040400000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	addq	$0x18, %rsp
               	retq
