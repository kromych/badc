
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x10(%rbp)
               	movl	%ecx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	$0xa, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rax, %rdx
               	movl	%ecx, (%rdx)
               	movq	%rax, %rcx
               	addq	$0x28, %rcx
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	movslq	-0x8(%rbp), %rsi
               	shlq	$0x2, %rsi
               	movq	%rax, %rdi
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rdi
               	movq	%rax, %r8
               	addq	$0x28, %r8
               	addq	%r8, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	addq	$0xa0, %rcx
               	movslq	-0x10(%rbp), %rdx
               	movl	%edx, (%rcx)
               	addq	$0xa0, %rax
               	movslq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0xa8(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x3c, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0xa0, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
