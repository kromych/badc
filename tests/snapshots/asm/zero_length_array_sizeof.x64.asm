
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
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rsi      # <addr>
               	movq	%rax, %rcx
               	cmpl	$0x4, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rax, %rdi
               	andq	$0x7, %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	movb	%dil, -0x8(%rbp)
               	incq	%rax
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	0x1(%rcx), %rdx
               	movzbq	-0x8(%rbp), %r8
               	movb	%r8b, (%rdi,%rcx)
               	cmpl	$0x4, %edx
               	jge	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	leaq	<rip>, %rdx      # <addr>
               	cmpl	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movzbq	-0x10(%rbp), %rcx
               	xorq	$0x42, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0xf(%rbp), %rcx
               	xorq	$0x41, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0xe(%rbp), %rcx
               	xorq	$0x44, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0xd(%rbp), %rcx
               	xorq	$0x43, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
