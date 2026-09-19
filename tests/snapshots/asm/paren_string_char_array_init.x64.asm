
paren_string_char_array_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	movzbq	0x8(%rdx), %rax
               	xorq	$0x6e, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x9(%rdx), %rax
               	xorq	$0x5f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xf(%rdx), %rax
               	xorq	$0x73, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpb	$0x0, 0x10(%rdx)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	%eax, %rcx
               	cmpb	$0x0, (%rsi,%rcx)
               	je	<addr>
               	leaq	0x8(%rdx), %r8
               	movzbq	(%r8,%rcx), %r8
               	movsbq	(%rdi,%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movslq	%eax, %rcx
               	cmpb	$0x0, (%rsi,%rcx)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x6f, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x77, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x70, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x6e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x3, %eax
               	retq
