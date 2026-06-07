
comparison_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x5, %ebx
               	xorq	%r12, %r12
               	cmpq	$0x0, %rbx
               	jle	<addr>
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jl	<addr>
               	movslq	%r12d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0xa, %rbx
               	jge	<addr>
               	movslq	%r12d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0xa, %rbx
               	jg	<addr>
               	movslq	%r12d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jbe	<addr>
               	movslq	%r12d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jb	<addr>
               	movslq	%r12d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0xa, %rbx
               	jae	<addr>
               	movslq	%r12d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0xa, %rbx
               	ja	<addr>
               	movslq	%r12d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	cmpq	$0xa, %rbx
               	jle	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %rbx
               	jge	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	%r12d, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r12d, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
