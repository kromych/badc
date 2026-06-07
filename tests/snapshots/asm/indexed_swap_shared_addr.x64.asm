
indexed_swap_shared_addr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	(%rdi,%rsi,8), %rax
               	movq	(%rdi,%rdx,8), %rcx
               	movq	%rcx, (%rdi,%rsi,8)
               	movq	%rax, (%rdi,%rdx,8)
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rax,%rdx,8)
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rdi
               	xorq	%rbx, %rbx
               	movl	$0x4, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movl	$0x2, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	movl	$0x1, %edx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
