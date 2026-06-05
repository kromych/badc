
typedef_array_param_decay.x64:	file format elf64-x86-64

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
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	cmpq	$0x10, %rdx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%rdx)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	shlq	$0x3, %rdx
               	movq	%rax, %rsi
               	addq	%rdx, %rsi
               	addq	%rcx, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rsi)
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x10(%rbp)
               	movl	%ecx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	$0x10, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movslq	-0x8(%rbp), %rsi
               	shlq	$0x3, %rsi
               	addq	%rax, %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	xorq	%rax, %rax
               	movl	%eax, -0x108(%rbp)
               	jmp	<addr>
               	movslq	-0x108(%rbp), %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x108(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	-0x108(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	callq	<addr>
               	movl	$0x110, %ecx            # imm = 0x110
               	movl	$0x2, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	addq	$0x78, %rax
               	movq	(%rax), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
