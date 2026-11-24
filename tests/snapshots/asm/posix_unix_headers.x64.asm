
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
               	subq	$0x88, %rsp
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, (%rsp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movzbq	(%rsp), %rax
               	orq	$0x8, %rax
               	movb	%al, (%rsp)
               	movzbq	0x5(%rsp), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, 0x5(%rsp)
               	andq	$0xff, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x88, %rsp
               	retq
               	testb	$0x10, %al
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x88, %rsp
               	retq
               	andq	$-0x9, %rax
               	movb	%al, (%rsp)
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x88, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
