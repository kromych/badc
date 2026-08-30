
ms_abi_firmware_boundary.x64:	file format elf64-x86-64

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

<step>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<probe>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	%r15, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rcx, %rbx
               	movq	%r9, %r14
               	movq	%r8, %r13
               	movq	%rdx, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, 0x50(%rsp)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, 0x48(%rsp)
               	leaq	(%rbx,%r14), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	(%r12,%r13), %rdi
               	callq	<addr>
               	imulq	$0x3e8, %r15, %rcx      # imm = 0x3E8
               	movq	0x58(%rsp), %rdx
               	imulq	$0x64, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x50(%rsp), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	addq	0x48(%rsp), %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %rdi
               	movq	0x10(%rsp), %r12
               	movq	0x18(%rsp), %r13
               	movq	0x20(%rsp), %r14
               	movq	0x28(%rsp), %r15
               	movq	0x30(%rsp), %rsi
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-<rip>, %rax       # <addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rsi, -0x70(%rbp)
               	movq	%rdi, -0x68(%rbp)
               	movq	%r8, -0x60(%rbp)
               	movq	%r9, -0x58(%rbp)
               	movq	%r10, -0x50(%rbp)
               	movq	%r11, -0x48(%rbp)
               	movq	%r12, -0x40(%rbp)
               	movq	%r13, -0x38(%rbp)
               	movq	%r14, -0x30(%rbp)
               	movq	%r15, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x20(%rbp), %r12
               	movq	-0x18(%rbp), %r13
               	movq	-0x10(%rbp), %r14
               	movq	-0x8(%rbp), %rbx
               	movq	%rsp, %r15
               	andq	$-0x10, %rsp
               	subq	$0xa0, %rsp
               	movq	$0x1, %rcx
               	movq	$0x2, %rdx
               	movq	$0x3, %r8
               	movq	$0x4, %r9
               	movq	$0x1111, %rsi           # imm = 0x1111
               	movq	$0x2222, %rdi           # imm = 0x2222
               	callq	*%rbx
               	movq	%r15, %rsp
               	movq	%rax, <rip>
               	movq	%rsi, <rip>
               	movq	%rdi, <rip>
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x78(%rbp), %rbx
               	movq	-0x70(%rbp), %rsi
               	movq	-0x68(%rbp), %rdi
               	movq	-0x60(%rbp), %r8
               	movq	-0x58(%rbp), %r9
               	movq	-0x50(%rbp), %r10
               	movq	-0x48(%rbp), %r11
               	movq	-0x40(%rbp), %r12
               	movq	-0x38(%rbp), %r13
               	movq	-0x30(%rbp), %r14
               	movq	-0x28(%rbp), %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
