
scalar_brace_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x5, %eax
               	leaq	<rip>, %rcx
               	movq	%rax, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	movl	$0x7, %esi
               	movslq	%edx, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0xb, %rdi
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x29, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rcx), %rax
               	xorq	$0x78, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r8d
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movzbq	0x1(%rcx), %rax
               	xorq	$0x79, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	jmp	<addr>
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movzbq	0x2(%rcx), %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	jmp	<addr>
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x7, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x7, %eax
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
               	addb	%al, 0x41(%rdx)
