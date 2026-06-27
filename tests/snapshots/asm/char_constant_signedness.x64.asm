
char_constant_signedness.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<pick>:
               	movsbq	(%rdi), %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	cmpq	$-0x80, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x28, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$-0x80, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0x80, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
