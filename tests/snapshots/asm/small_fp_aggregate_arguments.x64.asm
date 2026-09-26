
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

<bits_f2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<bits_d1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<bits_f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<bits_cf>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movb	$0x41, (%rax)
               	movl	$0x40200000, 0x4(%rax)  # imm = 0x40200000
               	leaq	-0x20(%rbp), %r9
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	movabsq	$0x400000003f800000, %r11 # imm = 0x400000003F800000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	movabsq	$0x4008000000000000, %r11 # imm = 0x4008000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	cmpq	$0x3fc00000, %rax       # imm = 0x3FC00000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rax
               	movabsq	$0x4020000000000041, %r11 # imm = 0x4020000000000041
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %r9
               	movq	$0x0, (%r9)
               	movl	$0x40400000, (%r9)      # imm = 0x40400000
               	movl	$0x40800000, 0x4(%r9)   # imm = 0x40800000
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	movabsq	$0x4080000040400000, %r11 # imm = 0x4080000040400000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
