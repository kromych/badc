
param_incoming_reg_clobber.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdx, 0x30(%rbp)
               	jmp	<addr>
               	movl	0x30(%rbp), %eax
               	movq	%rax, %rcx
               	addq	$-0x1, %rcx
               	movl	%ecx, 0x30(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$0x1, %rax
               	movq	%rsi, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rsi), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%ecx, %rcx
               	movq	%rdx, 0x30(%rbp)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	0x30(%rbp), %edx
               	callq	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movl	0x30(%rbp), %eax
               	subq	$0x1, %rax
               	movl	%eax, %eax
               	addq	%rax, %rdi
               	jmp	<addr>
               	movl	0x30(%rbp), %eax
               	movq	%rax, %rcx
               	addq	$-0x1, %rcx
               	movl	%ecx, 0x30(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$-0x1, %rax
               	movq	%rsi, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rsi), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x1, %ecx
               	callq	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movslq	%ebx, %rax
               	addq	%rax, %rcx
               	movzbq	(%rcx), %rcx
               	movl	$0x8, %edx
               	subq	%rax, %rdx
               	movslq	%edx, %rax
               	andq	$0xff, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	callq	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	addq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%ebx, %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
