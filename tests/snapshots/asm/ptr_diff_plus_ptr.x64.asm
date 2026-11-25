
ptr_diff_plus_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x20(%rax), %rdi
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x4, %rcx
               	addq	%rax, %rcx
               	cmpq	%rdi, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	(%rdx,%rsi), %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x10(%rax), %rdx
               	addq	%rcx, %rdx
               	leaq	(%rsp), %rcx
               	leaq	0x30(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	addq	$0x20, %rax
               	addq	$0x20, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
