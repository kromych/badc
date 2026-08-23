
inline_asm_goto_output.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<classify>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movl	%ebx, %eax
               	addl	$0x1, %eax
               	cmpl	$0xa, %ebx
               	jg	<addr>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	jmp	<addr>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<accumulate>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r10
               	movl	(%r10), %eax
               	addl	$0x5, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movslq	0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x3, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movl	%ebx, %eax
               	addl	$0x1, %eax
               	cmpl	$0xa, %ebx
               	jg	<addr>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	jmp	<addr>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %eax
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movl	%ebx, %eax
               	addl	$0x1, %eax
               	cmpl	$0xa, %ebx
               	jg	<addr>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	jmp	<addr>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x79, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x25, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %r10
               	movl	(%r10), %eax
               	addl	$0x5, %eax
               	jmp	<addr>
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	jmp	<addr>
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
