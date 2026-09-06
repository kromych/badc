
inline_asm_x64_sib.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	0x1000(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx,%rcx,8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x5, %edx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	movq	(%rbx,%rcx,8), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1005, %rax           # imm = 0x1005
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x5, %edx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	movq	0x10(%rbx,%rcx,8), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1007, %rax           # imm = 0x1007
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x18, %edx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	movq	(%rbx,%rcx), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1003, %rax           # imm = 0x1003
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	$0x2, %edx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	movl	(%rbx,%rcx,4), %eax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1001, %rax           # imm = 0x1001
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movl	$0x4, %eax
               	movl	$0xf00d, %ecx           # imm = 0xF00D
               	movq	%rdx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	movq	%rcx, 0x8(%rax,%rbx,2)
               	movq	0x10(%rdx), %rax
               	cmpq	$0xf00d, %rax           # imm = 0xF00D
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rdx
               	movl	$0x3, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	leaq	0x8(%rbx,%rcx,8), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	leaq	0x20(%rdx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
