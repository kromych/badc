
small_fp_aggregate_arguments.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movb	$0x41, -0x10(%rbp)
               	movl	$0x40200000, -0xc(%rbp) # imm = 0x40200000
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	movl	$0x40000000, -0x4(%rbp) # imm = 0x40000000
               	movq	-0x8(%rbp), %rsi
               	movabsq	$0x400000003f800000, %r11 # imm = 0x400000003F800000
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rcx, -0x8(%rbp)
               	movl	$0x3fc00000, -0x8(%rbp) # imm = 0x3FC00000
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rax
               	movabsq	$0x4020000000000041, %r11 # imm = 0x4020000000000041
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x40400000, -0x8(%rbp) # imm = 0x40400000
               	movl	$0x40800000, -0x4(%rbp) # imm = 0x40800000
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4080000040400000, %r11 # imm = 0x4080000040400000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
