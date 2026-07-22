
inline_asm_x64_sib.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x1000(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx,%rcx,8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x5, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	movq	(%rbx,%rcx,8), %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1005, %rax           # imm = 0x1005
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x5, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	movq	0x10(%rbx,%rcx,8), %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1007, %rax           # imm = 0x1007
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x18, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	movq	(%rbx,%rcx), %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1003, %rax           # imm = 0x1003
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x2, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	movl	(%rbx,%rcx,4), %eax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1001, %rax           # imm = 0x1001
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x4, %ecx
               	movl	$0xf00d, %edx           # imm = 0xF00D
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	movq	%rcx, 0x8(%rax,%rbx,2)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	0x10(%rax), %rax
               	cmpq	$0xf00d, %rax           # imm = 0xF00D
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rax
               	movl	$0x3, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	leaq	0x8(%rbx,%rcx,8), %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	addq	$0x20, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
