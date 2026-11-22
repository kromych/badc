
posix_unix_headers.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, -0x80(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movzbq	-0x80(%rbp), %rax
               	orq	$0x8, %rax
               	movb	%al, -0x80(%rbp)
               	movzbq	-0x7b(%rbp), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, -0x7b(%rbp)
               	andq	$0xff, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	testb	$0x10, %al
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	andq	$-0x9, %rax
               	movb	%al, -0x80(%rbp)
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
