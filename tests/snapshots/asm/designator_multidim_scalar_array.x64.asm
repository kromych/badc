
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
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	0x20(%rdx), %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rdi
               	cmpl	$0x9, %edi
               	jne	<addr>
               	leaq	0x20(%rdx), %rdi
               	addq	%rdi, %rsi
               	movslq	0x4(%rsi), %rsi
               	cmpl	$0xa, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movslq	(%rdi), %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	addq	%rdx, %rsi
               	movslq	0x4(%rsi), %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
