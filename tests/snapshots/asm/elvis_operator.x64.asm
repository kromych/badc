
elvis_operator.x64:	file format elf64-x86-64

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
               	subq	$0xc0, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x5, %eax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x7, %eax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x64, %eax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpq	$0x78, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x75, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
