
clock_monotonic_advances.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x280, %esi            # imm = 0x280
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$-0x1, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x0, %rax
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	setge	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	$0xf4240, %rdx          # imm = 0xF4240
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x1, %edi
               	leaq	-0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
