
symbol_inner_array_size_no_leak.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%esi, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	%rsi, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rdx
               	shlq	$0x1, %rdx
               	addq	%rdi, %rdx
               	imulq	$0x3, %rax, %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	movq	%rsi, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	shlq	$0x1, %rax
               	addq	%rdi, %rax
               	movswq	(%rax), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movswq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0xe, %rax
               	movswq	(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	addq	$0xe, %rax
               	movl	$0x63, %ecx
               	movw	%cx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	addq	$0xe, %rax
               	movswq	(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
