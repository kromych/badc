
inline_struct_param_returned.x64:	file format elf64-x86-64

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

<id_word>:
               	movq	%rdi, %rax
               	retq

<id_pair>:
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	retq

<id_pair_hint>:
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	retq

<use_word>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rdi
               	callq	<addr>
               	popq	%rbp
               	retq

<use_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	imulq	$0xa, %rax, %rax
               	addq	%rdx, %rax
               	popq	%rbp
               	retq

<use_big>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %rax
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rsi, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x3e8, %rdi, %rdx      # imm = 0x3E8
               	addq	%rdx, %rcx
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	addq	%rcx, %rax
               	retq

<use_hint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	imulq	$0xa, %rax, %rax
               	addq	%rdx, %rax
               	popq	%rbp
               	retq

<use_twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rdx, 0x8(%rdi)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rdx, %rax
               	leave
               	retq

<use_pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%esi, %rsi
               	leaq	-0x20(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi
               	movq	$0x7, (%rdi)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	$0x3, (%rax)
               	movq	$0x4, 0x8(%rax)
               	callq	<addr>
               	cmpq	$0x22, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	movq	$0x5, 0x20(%rax)
               	callq	<addr>
               	cmpq	$0xd431, %rax           # imm = 0xD431
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x62, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
