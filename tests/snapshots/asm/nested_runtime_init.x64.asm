
nested_runtime_init.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	cmpl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	0x3(%rax), %rsi
               	cmpl	%ecx, %ecx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x5(%rax), %rsi
               	cmpl	%eax, %eax
               	movl	$0x1, %edi
               	jne	<addr>
               	movq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpl	%esi, %esi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	0x2(%rax), %rsi
               	cmpl	%eax, %eax
               	movl	$0x1, %ecx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	%ecx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	%esi, %esi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r8, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
