
inline_asm_x64_flags_push.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x7, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	pushfq
               	popq	%rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	andq	$0x40, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %edx
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	pushfq
               	popq	%rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x8(%rbp), %rax
               	andq	$0x40, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rbx
               	pushw	%bx
               	popw	%ax
               	movq	-0x40(%rbp), %r10
               	movw	%ax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movl	$0xbeef, %eax           # imm = 0xBEEF
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rbx
               	pushw	%bx
               	popw	%ax
               	movq	-0x40(%rbp), %r10
               	movw	%ax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0xbeef, %rax           # imm = 0xBEEF
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	pushfq
               	popq	%rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x38(%rbp), %rbx
               	pushq	%rbx
               	popfq
               	pushfq
               	popq	%rax
               	movq	-0x40(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	andq	$0x40, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
