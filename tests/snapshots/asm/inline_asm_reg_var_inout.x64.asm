
inline_asm_reg_var_inout.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movl	$0x4, %eax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, -0x110(%rbp)
               	movq	%rcx, -0x108(%rbp)
               	movq	%rax, -0x100(%rbp)
               	movq	-0x100(%rbp), %rax
               	addq	$0x1, %rax
               	movq	-0x108(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x110(%rbp), %rax
               	movq	-0x40(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movl	$0x5, %edi
               	movl	$0x6, %r8d
               	leaq	-0x78(%rbp), %r9
               	leaq	-0x80(%rbp), %rbx
               	leaq	-0x88(%rbp), %r12
               	leaq	-0x90(%rbp), %r13
               	movq	%rax, -0x110(%rbp)
               	movq	%rcx, -0x108(%rbp)
               	movq	%rdx, -0x100(%rbp)
               	movq	%rsi, -0xf8(%rbp)
               	movq	%r8, -0xf0(%rbp)
               	movq	%r9, -0xe8(%rbp)
               	movq	%r9, -0xe0(%rbp)
               	movq	%rbx, -0xd8(%rbp)
               	movq	%r12, -0xd0(%rbp)
               	movq	%r13, -0xc8(%rbp)
               	movq	%rax, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rsi, -0xa8(%rbp)
               	movq	%rdi, -0xa0(%rbp)
               	movq	%r8, -0x98(%rbp)
               	movq	-0xc0(%rbp), %rax
               	movq	-0xb8(%rbp), %rcx
               	movq	-0xb0(%rbp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	movq	-0xa0(%rbp), %r8
               	movq	-0x98(%rbp), %r9
               	addq	%r8, %rax
               	addq	%r9, %rcx
               	addq	$0x2, %rdx
               	addq	$0x3, %rsi
               	movq	-0xe0(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xd8(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0xd0(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0xc8(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x110(%rbp), %rax
               	movq	-0x108(%rbp), %rcx
               	movq	-0x100(%rbp), %rdx
               	movq	-0xf8(%rbp), %rsi
               	movq	-0xf0(%rbp), %r8
               	movq	-0xe8(%rbp), %r9
               	movq	-0x78(%rbp), %rax
               	movq	-0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x88(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x90(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
