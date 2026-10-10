
posix_unix_headers.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	leaq	-0x80(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movzbq	-0x80(%rbp), %rax
               	orq	$0x8, %rax
               	movb	%al, -0x80(%rbp)
               	movzbq	-0x7b(%rbp), %rax
               	orq	$0x1, %rax
               	movb	%al, -0x7b(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movzbq	-0x7b(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x10, %al
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	-0x80(%rbp), %rax
               	andq	$-0x9, %rax
               	movb	%al, -0x80(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
