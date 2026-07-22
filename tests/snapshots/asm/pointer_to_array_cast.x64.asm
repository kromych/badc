
pointer_to_array_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rsi
               	leaq	(%rcx,%rcx,2), %rdx
               	movslq	%edx, %rdi
               	movw	%di, (%rsi,%rcx,2)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x18, %rcx
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movswq	0x14(%rax), %rcx
               	cmpq	$0x1e, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movswq	0xc(%rax), %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
