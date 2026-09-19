
zero_length_array_sizeof.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %r8
               	movq	%rax, %rcx
               	leaq	-0x8(%rbp), %rbx
               	movl	%eax, %esi
               	cmpl	$0x4, %esi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	%rsi, %r9
               	andq	$0x7, %r9
               	movzbq	(%r8,%r9), %r9
               	movb	%r9b, (%rbx)
               	leaq	0x1(%rsi), %rax
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ecx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movzbq	-0x8(%rbp), %rdi
               	movb	%dil, (%rsi,%rdx)
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x42, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x1(%rcx), %rdx
               	xorq	$0x41, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x2(%rcx), %rdx
               	xorq	$0x44, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x3(%rcx), %rcx
               	xorq	$0x43, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	%eax, %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
