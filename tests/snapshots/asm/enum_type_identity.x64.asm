
enum_type_identity.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	leaq	0x8(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2, 0x4(%rax)
               	movl	0x4(%rax), %eax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
