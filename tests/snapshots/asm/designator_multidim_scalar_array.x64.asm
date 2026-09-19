
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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x20(%rcx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	$0x9, %esi
               	jne	<addr>
               	leaq	0x20(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0xa, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	cmpl	$0x0, (%rsi)
               	jne	<addr>
               	addq	%rcx, %rdx
               	cmpl	$0x0, 0x4(%rdx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
