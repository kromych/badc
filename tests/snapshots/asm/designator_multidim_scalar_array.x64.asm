
designator_multidim_scalar_array.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x20(%rcx), %rdi
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rdi
               	cmpl	$0x9, %edi
               	jne	<addr>
               	leaq	0x20(%rcx), %rdi
               	leaq	(%rdi,%rsi), %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0xa, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movslq	(%rdi), %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	(%rcx,%rsi), %rdx
               	movslq	0x4(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
