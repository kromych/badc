
ptr_diff_plus_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x20(%rax), %rdx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	sarq	$0x4, %rdi
               	shlq	$0x4, %rdi
               	addq	%rax, %rdi
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	addq	%rsi, %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x10(%rax), %rdx
               	addq	%rcx, %rdx
               	leaq	-0x30(%rbp), %rcx
               	leaq	0x30(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	addq	$0x20, %rax
               	addq	$0x20, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
