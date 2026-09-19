
inline_into_computed_goto.x64:	file format elf64-x86-64

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

<interp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rax)
               	movq	$0x0, -0x28(%rbp)
               	movl	$0x0, -0x20(%rbp)
               	movq	-0x50(%rbp), %rcx
               	movl	$0x1, -0x20(%rbp)
               	movslq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movq	-0x28(%rbp), %rsi
               	movq	-0x40(%rbp), %rdi
               	movq	-0x50(%rbp), %rax
               	movslq	-0x20(%rbp), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x20(%rbp)
               	movslq	(%rax,%rcx,4), %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	andq	$-0x4, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, -0x28(%rbp)
               	leaq	-0x18(%rbp), %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x20(%rbp)
               	movslq	(%rax,%rcx,4), %rax
               	movq	(%rsi,%rax,8), %rax
               	jmpq	*%rax
               	movq	-0x28(%rbp), %rax
               	addq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	-0x50(%rbp), %rdx
               	movslq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	(%rdx,%rax,4), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movq	-0x28(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x38(%rbp), %rsi
               	movq	$0x67, (%rsi)
               	movq	$0xc9, 0x8(%rsi)
               	movq	$0x12c, 0x10(%rsi)      # imm = 0x12C
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	callq	<addr>
               	cmpq	$0x384, %rax            # imm = 0x384
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
