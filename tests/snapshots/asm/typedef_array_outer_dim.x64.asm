
typedef_array_outer_dim.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x18(%rbp)
               	movl	%ecx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	$0x4, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rcx
               	cmpq	$0x10, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x7, %rdx
               	addq	%rax, %rdx
               	movslq	-0x10(%rbp), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rdx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, (%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movslq	-0x8(%rbp), %rsi
               	shlq	$0x7, %rsi
               	addq	%rax, %rsi
               	movslq	-0x10(%rbp), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x208(%rbp)
               	movl	%eax, -0x210(%rbp)
               	jmp	<addr>
               	movslq	-0x210(%rbp), %rax
               	cmpq	$0x40, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x210(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x208(%rbp), %rax
               	movq	(%rax), %rcx
               	movslq	-0x210(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rdi
               	callq	<addr>
               	movq	-0x208(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	addq	$0x1f8, %rax            # imm = 0x1F8
               	movq	(%rax), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	addq	$0xb8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
