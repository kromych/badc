
attribute_packed.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0xd, %rax
               	leaq	-0x20(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %edx
               	movb	%dl, (%rax)
               	leaq	-0x30(%rbp), %rax
               	incq	%rax
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	addq	$0x9, %rax
               	movabsq	$-0x7, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	incq	%rax
               	movq	(%rax), %rax
               	movabsq	$0x1122334455667788, %r13 # imm = 0x1122334455667788
               	cmpq	%r13, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	addq	$0x9, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x7, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
